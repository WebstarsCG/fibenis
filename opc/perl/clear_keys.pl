#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
		my $param  = shift @_;
		
		my $dbh    = $param->{'dbh'};
		
		my $cdbh   = $param->{'cdbh'};
		
		my $global = $param->{'global'};
		
		my $req    = $param->{'req'};
		
		my $lv;
                
                $lv->{'content'} = '';
                
             
		$lv->{'counter'}={'fk'=>0,
				  'table'=>0};
		
		# get foriegn key
		
		$lv->{'fk_info'}      =  $param->{'dbh'}->selectall_hashref("SELECT
                                                                                    TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME
                                                                               FROM
                                                                                    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                                                                               WHERE
                                                                                    TABLE_SCHEMA='$global->{db_name}' AND REFERENCED_TABLE_SCHEMA IS NOT NULL","4");
		              
		# Forieng Key Removal
                
                $lv->{'content'}.="<br><br>Foriegn Removal<br>"; 
		
                
                # each foriegn key
		
		for(keys %{$lv->{'fk_info'}}){
                        
		    $lv->{'fk'} = $lv->{'fk_info'}->{$_};
                    
                    $lv->{'content'}.="$lv->{'fk'}->{'TABLE_NAME'} - $lv->{'fk'}->{'CONSTRAINT_NAME'} <br>";
		    
		    $lv->{'drop_fk_query'} = "ALTER TABLE $lv->{'fk'}->{'TABLE_NAME'} DROP FOREIGN KEY $lv->{'fk'}->{'CONSTRAINT_NAME'}";
		    		    
		    $param->{'dbh'}->do($lv->{'drop_fk_query'}) || return "Fail Foriegn Key";
		    
		    $lv->{'counter'}->{'fk'}++;
		    
		} # end
		
		# tables based action
		
		$lv->{'table_result'} = $dbh->table_info(undef,$global->{'db_name'},'','TABLE');
		 
		$lv->{'table_info'}   = $lv->{'table_result'}->fetchall_hashref('TABLE_NAME');
			
		#print Dumper($lv->{'table_info'});	
			
                $lv->{'content'}.="<br><br>Index Removal<br>";        
                        
		# each tables
		
		for(sort keys %{$lv->{'table_info'}}){
		    
		    $lv->{'table'} = $lv->{'table_info'}->{$_};
		    
		    $lv->{'content'}.=$lv->{'table'}->{'TABLE_NAME'}."<br>";
		    
		    # get index
		    
		    for($dbh->selectall_hashref("SHOW INDEX FROM $lv->{'table'}->{'TABLE_NAME'}","3")){
			
			$lv->{'table_key'} = $_;
			
			delete($lv->{'table_key'}->{'PRIMARY'});
			
			
			# each key
			
			for my $table_key (keys %{$lv->{'table_key'}}){
			    
			    # remove index
			    
			    $lv->{'key_drop_query'} = "ALTER TABLE $lv->{'table'}->{'TABLE_NAME'} DROP INDEX $table_key";
			    
			    $dbh->do($lv->{'key_drop_query'});				
			    
			} # end
			
		    } # end index		    
		    
		} # table
                
                print $lv->{'content'};
		
		return 1;
    
    } # end of action

    
    