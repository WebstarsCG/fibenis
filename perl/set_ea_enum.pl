#! /usr/bin/perl -w

  
    
    
    # action
    
    sub action(){
	
		my $param  = shift @_;
		
		my $dbh    = $param->{'dbh'};
		
		my $cdbh   = $param->{'cdbh'};
		
		my $lv;		
            
                $lv->{'content'}.='Set ea_enum';        
    
		# get ea
		
		$lv->{'entity'} = $cdbh->selectall_hashref("SELECT
								    id,
								    child_table,
								    child_table_field,
								    entity,
								    default_code
							    FROM
								    ea_enum",1);
		
		foreach my $ea (keys %{$lv->{'entity'}}){
		    
			# temp parent
			
			$temp->{'parent'} = $_;
		    
			# ea attr child
			
			$lv->{'content'}.="Code:$lv->{'entity'}->{$ea}->{'entity'}<br>".
					  "Field:$lv->{'entity'}->{$ea}->{'child_table_field'}<br>";
				
			# child items
			
			my @child_items = @{$dbh->selectcol_arrayref(qq/ SELECT
									    concat('\"',code,'\"'),
									    sn
									FROM
									    entity_attribute
									WHERE
									    entity_code='$lv->{entity}->{$ea}->{entity}'/,
									    { Columns=>[1]})
					    };
			
			$temp->{'child_length'} = scalar(@child_items);
				
			$lv->{'content'}.=" Length:".$temp->{'child_length'}."<br>";
			
			if($temp->{'child_length'}){
			    
			    # push default
			    
			    push(@child_items,'"NANA"');
			    
			    $temp->{'child_list'}=join(',',@child_items);
			    $temp->{'child_list'}=~s/\"/\'/ig; # replace # " by ' for 
			    
			    $lv->{'content'}.=&set_enum_action_process({'child_list'  		    => $temp->{'child_list'},
									'child_table' 		    => $lv->{'entity'}->{$ea}->{'child_table'},
									'child_table_field'    	    => $lv->{'entity'}->{$ea}->{'child_table_field'},
									'child_table_field_default'  => $lv->{'entity'}->{$ea}->{'default_code'},
									'dbh'       		    => $dbh,
									'global'		=> $global});
							       
			} # end
				
			$lv->{'content'}.="<hr>";
			
		} # end
		
		return $lv->{'content'};
    
    } # end of action

       
    # set enum action process
    
    sub set_enum_action_process(){
	
	my $param = shift @_;
	
	my $global = $param->{'global'};
	
	my $lv;
	
	# enum
	
	$lv->{'query'}->{'enum'}= " ALTER TABLE $param->{'child_table'} ".
				  " CHANGE $param->{'child_table_field'}".
				  " $param->{'child_table_field'} ENUM($param->{'child_list'})".
				  " CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'NANA'";
	
	# set default
	
	$lv->{'query'}->{'set_default'} =" UPDATE $param->{'child_table'} SET $param->{'child_table_field'}='$param->{'child_table_field'}' ".
	                                 " WHERE LENGTH($param->{'child_table_field'})=0 OR  $param->{'child_table_field'} IS NULL ";
	
	# enum, default
	
	for(@{['enum','set_default']}){
	    
	    $param->{'dbh'}->do($lv->{'query'}->{$_}) || return "Fail";
	    
	} # end
		
	return 1;
	
    } # end
    
    
    __END__
    
    # relation
	
	$lv->{'fk_name'}        = "fk_$param->{'child_table'}_$param->{'field'}";
	
	# get existing fk
	
	$lv->{'fk_result'}      = $param->{'dbh'}->foreign_key_info(undef,$global->{'db_name'},'entity_attribute',
						    undef,$global->{'db_name'},$param->{'child_table'});
	
	$lv->{'fk_exist_info'}  = $lv->{'fk_result'}->fetchall_hashref('FK_NAME');
	
	# check if foriegn key is there
	
	if(!$lv->{'fk_exist_info'}->{$lv->{'fk_name'}}){
	  
		print $lv->{'query'}->{'set_relation'}=" ALTER TABLE 
							$param->{'child_table'}
						    ADD CONSTRAINT
							fk_$param->{'child_table'}_$param->{'child_table_field'}
						    FOREIGN KEY
							($param->{'child_table_field'})
						    REFERENCES
							entity_attribute(code)
						    ON DELETE RESTRICT
						    ON UPDATE NO ACTION";
		
		#$param->{'dbh'}->do($lv->{'query'}->{'set_relation'}) || return "Fail Foriegn Key";
	
	} # end
  
    