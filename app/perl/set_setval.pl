#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
	    my $param  = shift @_;
	    
	    my $dbh    = $param->{'dbh'};
	    
	    my $cdbh   = $param->{'cdbh'};
	    
	    my $global = $param->{'global'};
	    
	    my $req    = $param->{'req'};
	    
	    my $lv;
	    
	    $lv->{'content'} = 'Set Value<br>';
	    $lv->{'counter'}->{'row'}=0;
	    
	    # get ea
	    
	    $lv->{'def'} = $cdbh->selectall_hashref("SELECT
							id,
							table_name,
							field_name,
							check_value,
							set_value
						     FROM
							setval",1) || "$DBI::errstr";
	    
	    # len
	    
	    foreach (sort keys %{$lv->{'def'}}){
		
		my $def = $lv->{'def'}->{$_};
				
		# counter
		
		$lv->{'counter'}->{'row'}++;
		
		# is all table
		
		$def->{'is_all_table'}=$def->{'table_name'}=~m/^(\*){1}$/ig;
		
		# all table
		
		if($def->{'is_all_table'}){
			
			# inner row
			
			$lv->{'counter'}->{'inner'}->{'row'} = 0;
			
			# get ea
		
			$lv->{'table_result'} = $dbh->table_info(undef,$global->{'db_name'},'','TABLE');
			 
			$lv->{'table_info'}   = $lv->{'table_result'}->fetchall_hashref('TABLE_NAME');
							
			# each tables
			
			for(sort keys %{$lv->{'table_info'}}){
							    
				$lv->{'table'} = $lv->{'table_info'}->{$_};
				
				# each column
			    
				$lv->{'col_info'}   = $dbh->selectall_hashref("SHOW COLUMNS FROM $lv->{'table'}->{'TABLE_NAME'}","1");
						    
				
				# if field avail
				
				if ($lv->{'col_info'}->{$def->{'field_name'}}) {
					
					# counter
					
					$lv->{'counter'}->{'inner'}->{'row'}++;
					
					# log
				
					$lv->{'content'}.="$lv->{'counter'}->{'row'}.$lv->{'counter'}->{'inner'}->{'row'}) ".
					                  "$lv->{'table'}->{'TABLE_NAME'} - $def->{'field_name'} - $def->{'check_value'} -> $def->{'set_value'} <br>";		
					
					# query
					
					$lv->{'query'} = "	UPDATE 
									$lv->{'table'}->{'TABLE_NAME'}
								SET
									$def->{'field_name'}= $def->{'set_value'}
								WHERE
									$def->{'field_name'}= $def->{'check_value'}";
									
					$dbh->do($lv->{'query'});
					
				} # end				
								
			} # end of each table
			
			
		}else{
			
			# not all table action
		
			# table clean
			
			$def->{'table_name'}=~s/[^\w\_]//ig;
			
			# field clean
			
			$def->{'field_name'}=lc($def->{'field_name'});
			
			$def->{'field_name'}=~s/[^\w\_]//ig;
						
			$lv->{'content'}.="$lv->{'counter'}->{'row'}) $def->{'table_name'} - $def->{'field_name'} - $def->{'check_value'} -> $def->{'set_value'} <br>";		
			    
			$lv->{'query'} = "	UPDATE 
							$def->{'table_name'}
						SET
							$def->{'field_name'}= $def->{'set_value'}
						WHERE
							$def->{'field_name'}= $def->{'check_value'}";
								    
			    
			$dbh->do($lv->{'query'});
			
		} # end of table action
		
	    } # end index
	    
	    
	    print $lv->{'content'};
	    
	    return 1;
    
    } # end of action

    
    