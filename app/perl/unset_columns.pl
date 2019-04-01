#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
	    my $param  = shift @_;
	    
	    my $dbh    = $param->{'dbh'};
	    
	    my $cdbh   = $param->{'cdbh'};
	    
	    my $global = $param->{'global'};
	    
	    my $req    = $param->{'req'};
	    
	    my $lv;
	    
	    $lv->{'content'} = 'Unset Columns<br>';
	    $lv->{'counter'}->{'row'}=0;
	    
	    
	    # get ea
	    
	    $lv->{'col'} = $cdbh->selectall_hashref("SELECT
								id,
								table_name,
								field_name					
								
							    FROM
								del_cols",1);
	    
	    
	    # len
	    
	    foreach (sort keys %{$lv->{'col'}}){
		
		my $col = $lv->{'col'}->{$_};
		
		# counter
		
		$lv->{'counter'}->{'row'}++;
		
		# table clean
		
		$col->{'table_name'}=~s/[^\w\_]//ig;
		
		# field clean
		
		$col->{'field_name'}=lc($col->{'field_name'});
		
		$col->{'field_name'}=~s/[^\w\_]//ig;
					
		$lv->{'content'}.="$lv->{'counter'}->{'row'}) $col->{'table_name'} - $col->{'field_name'}<br>";		
		    
		$lv->{'len_query'} = "ALTER TABLE $col->{'table_name'}
						 DROP $col->{'field_name'}
						
					";			    
		    
		$dbh->do($lv->{'len_query'});
		
	    } # end index
	    
	    
	    print $lv->{'content'};
	    
	    return 1;
    
    } # end of action

    
    