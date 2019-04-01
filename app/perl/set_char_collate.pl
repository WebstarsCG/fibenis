#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
		my $param  = shift @_;
		
		my $dbh    = $param->{'dbh'};
		
		my $cdbh   = $param->{'cdbh'};
		
		my $global = $param->{'global'};
		
		my $req    = $param->{'req'};
		
		my $lv;
		
		# global
		
		$lv->{'char'}    = 'utf8';
		
		$lv->{'collate'} = 'utf8_general_ci';
		
		$lv->{'engine'}  = 'InnoDB';
		
		# content
		
		$lv->{'content'} = 'Set Char & Collate<br>';
		
		$lv->{'intent'}->{2}="&nbsp;&nbsp;&nbsp;";
		
		# column name
		
		$lv->{'column_type'}->{'TEXT'} = $lv->{'column_type'}->{'CHAR'} = $lv->{'column_type'}->{'VARCHAR'} = 'mysql_type_name';
		
		$lv->{'column_type'}->{'ENUM'} = $lv->{'column_type'}->{'SET'} = 'mysql_type_name';
				
		# get ea
		
		$lv->{'table_result'} = $dbh->table_info(undef,$global->{'db_name'},'','TABLE');
		 
		$lv->{'table_info'}   = $lv->{'table_result'}->fetchall_hashref('TABLE_NAME');
						
		# each tables
		
		for(sort keys %{$lv->{'table_info'}}){
		    
		    $lv->{'table'} = $lv->{'table_info'}->{$_};
		    
		    $lv->{'content'}.="<b>$lv->{'table'}->{'TABLE_NAME'}</b><br>";
		    
		    # set engine
		    
		    $dbh->do("ALTER TABLE $lv->{'table'}->{'TABLE_NAME'} ENGINE = $lv->{'engine'}");
		    
		    # set char set
		    
		    $dbh->do("ALTER TABLE $lv->{'table'}->{'TABLE_NAME'} CHARACTER SET = $lv->{'char'}");
		    
		    # set collate
		    
		    $dbh->do("ALTER TABLE $lv->{'table'}->{'TABLE_NAME'} DEFAULT CHARACTER SET $lv->{'char'} COLLATE $lv->{'collate'}");
		    
		    # set column char
		    
		    
			$lv->{'col_result'} = $dbh->column_info(undef,
								$global->{'db_name'},
								$lv->{'table'}->{'TABLE_NAME'},
								'');
		    
			$lv->{'col_info'}   = $dbh->selectall_hashref("SHOW COLUMNS FROM $lv->{'table'}->{'TABLE_NAME'}","1");
                        						
			# column info
			
			for(sort keys %{$lv->{'col_info'}}){
				
				
				$lv->{'col'} = $lv->{'col_info'}->{$_};
				  
				if($lv->{'col'}->{'Type'}=~m/^(char|varchar|text|enum|set)/ig){

                                         $lv->{'col_type_name'}=$lv->{'col'}->{'Type'};
					
					# Column Name
				
					$lv->{'content'}.=$lv->{'intent'}->{2}."$lv->{'col'}->{'Field'}<br>";
					                                        
					$dbh->do("ALTER TABLE $lv->{'table'}->{'TABLE_NAME'}
						  MODIFY $lv->{'col'}->{'Field'} $lv->{'col_type_name'}
						  CHARACTER SET $lv->{'char'} COLLATE $lv->{'collate'}");
					
				} # end
			
			} # end
                        
                        
			
		} # each table
		
		# get column info
		
		print $lv->{'content'};
	    
	    return 1;
    
    } # end of action
    

    
    