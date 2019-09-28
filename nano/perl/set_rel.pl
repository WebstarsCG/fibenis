#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
		my $param  = shift @_;
		
		my $dbh    = $param->{'dbh'};
		
		my $cdbh   = $param->{'cdbh'};
		
		my $global = $param->{'global'};
		
		my $req    = $param->{'req'};
		
		my $lv;
		
                
                $lv->{'content'} = 'Set Relations<br>';
		#print Dumper($param);
    
		# get ea
		
		$lv->{'relation'} = $cdbh->selectall_hashref("SELECT
								    id,
								    child_table,
								    child_field,
								    parent_table,
								    parent_field
								FROM
								    rel",1);
		
		#print Dumper($lv->{'relation'});
		
		# relation
		
		foreach my $relation_idx (keys %{$lv->{'relation'}}){
		    
		    my $relation = $lv->{'relation'}->{$relation_idx};
		    
		    $lv->{'fk_name'}        = "fk_$relation->{'child_table'}_$relation->{'child_field'}";
	
		    $lv->{'content'}.=$lv->{'fk_name'}."<br>";
	
		    # get existing fk
		    
		    $lv->{'fk_result'}      = $param->{'dbh'}->foreign_key_info(undef,$global->{'db_name'},$relation->{'parent_table'},
								                undef,$global->{'db_name'},$relation->{'child_table'});
		    
		    $lv->{'fk_exist_info'}  = $lv->{'fk_result'}->fetchall_hashref('FK_NAME');
		    
		    
		    $lv->{'query'}->{'set_relation'}=" ALTER TABLE 
								   $relation->{'child_table'}
							       ADD CONSTRAINT
								   fk_$relation->{'child_table'}_$relation->{'child_field'}
							       FOREIGN KEY
								   ($relation->{'child_field'})
							       REFERENCES
								   $relation->{'parent_table'}($relation->{'parent_field'})
							       ON DELETE CASCADE
							       ON UPDATE NO ACTION";
		    # check if foriegn key is there
		    
		    if( # if foriegn key not exists
		        (!$lv->{'fk_exist_info'}->{$lv->{'fk_name'}}) ||
		      
			# if exists and have update request
		        (($lv->{'fk_exist_info'}->{$lv->{'fk_name'}})
			  && ($req->{'update'}==1))
		    ){
		      		    
			    # updae  	    
			    if( ($lv->{'fk_exist_info'}->{$lv->{'fk_name'}})
			         && ($req->{'update'}==1)
			    ){
				
				# drop exist
                                
                                print "ALTER TABLE $relation->{'child_table'} DROP FOREIGN KEY $lv->{'fk_name'}";
				
				#$param->{'dbh'}->do("ALTER TABLE $relation->{'child_table'} DROP FOREIGN KEY $lv->{'fk_name'}") || return "Fail Foriegn Key";
			    
			    } # drop exist
				    
			    $param->{'dbh'}->do($lv->{'query'}->{'set_relation'}) || return "Fail Foriegn Key<br>".
                                                                                             $DBI::errstr.$lv->{'query'}->{'set_relation'};
		    
		    } # check
		    
		} # end relations
		
                print "<br><br><br><br><br><br><br>".$lv->{'content'};
                
		return 1;
    
    } # end of action

    
    