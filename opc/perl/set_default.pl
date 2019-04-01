#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
	    my $param  = shift @_;
	    
	    my $dbh    = $param->{'dbh'};
	    
	    my $cdbh   = $param->{'cdbh'};
	    
	    my $global = $param->{'global'};
	    
	    my $req    = $param->{'req'};
	    
	    my $lv;
	    
	    $lv->{'content'} = 'Set Default';
	    $lv->{'counter'}->{'row'}=0;
	    
	    # get ea
	    
	    $lv->{'data'} = $cdbh->selectall_hashref("SELECT
								id,
								table_name,
								field_name,
								field_value,								
								update_null
							    FROM
								default",1) || "$DBI::errstr";
	    
	   
	    
	    # len
	    
	    foreach (sort keys %{$lv->{'data'}}){
		
		my $default = $lv->{'data'}->{$_};
		
		
		
		# counter
		
		$lv->{'counter'}->{'row'}++;
		
		# table clean
		
		$default->{'table_name'}=~s/[^\w\_]//ig;
		
		# field clean
		
		$default->{'field_name'}=lc($default->{'field_name'});
		
		$default->{'field_name'}=~s/[^\w\_]//ig;
		
		# null
		
		$default->{'null'} = ($default->{'is_null'})?' IS NULL ':' IS NOT NULL ';
					
		$lv->{'content'}.="$lv->{'counter'}->{'row'}) $default->{'table_name'} - $default->{'field_name'} - $default->{'field_value'} <br>";		
		    
		$lv->{'query'} = "ALTER TABLE $default->{'table_name'}
				        ALTER $default->{'field_name'}
				        SET DEFAULT $default->{'field_value'} 
				";			    
		    
		$dbh->do($lv->{'query'});
		
		# repair exist
		
		if ($default->{'update_null'}){
			
			$lv->{'content'}.=$default->{'table_name'}.'-'.$default->{'field_name'}.'-'.$default->{'field_value'}.'<br>';
			
			$lv->{'repair_query'} = "UPDATE
							$default->{'table_name'}
						SET
							$default->{'field_name'}=$default->{'field_value'}
						WHERE
							$default->{'field_name'} IS NULL OR LENGTH($default->{'field_name'})=0
						";
						
						
			$dbh->do($lv->{'repair_query'});
			
		} #code
		
		
		
	    } # end index
	    
	    
	    print $lv->{'content'};
	    
	    return 1;
    
    } # end of action

    
    