#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
	    my $param  = shift @_;
	    
	    my $dbh    = $param->{'dbh'};
	    
	    my $cdbh   = $param->{'cdbh'};
	    
	    my $global = $param->{'global'};
	    
	    my $req    = $param->{'req'};
	    
	    my $lv;
	    
	    $lv->{'contnet'} = 'Unique Table<br>';
	    
	    # get ea
	    
	    $lv->{'uniq'} = $cdbh->selectall_hashref("SELECT
								id,
								table_name,
								field_name
							    FROM
								unq",1);		
	    # uniq
	    
	    foreach (sort keys %{$lv->{'uniq'}}){
		
		my $uniq = $lv->{'uniq'}->{$_};
		
		# table clean
		
		$uniq->{'table_name'}=~s/[^\w\_]//ig;
		
		# field clean
		
		$uniq->{'field_name'}=lc($uniq->{'field_name'});
		
		$uniq->{'field_name'}=~s/[^\w\,\_]//ig;
		
		@{$uniq->{'fields'}} = split(/,/,$uniq->{'field_name'});
		
		$lv->{'contnet'}.="Table : ".$uniq->{'table_name'}."<br>";
		
		# for each field
		
		for my $uniq_field (sort @{$uniq->{'fields'}}){
		    
			$lv->{'contnet'}.="&nbsp;&nbsp;&nbsp;$uniq_field<br>";
		    
			$lv->{'uniq_query'} = "ALTER TABLE $uniq->{'table_name'}
					       ADD UNIQUE INDEX ($uniq_field )";			    
			    
			$dbh->do($lv->{'uniq_query'});
			
		} # each field		    
		
	    } # end index
	    
	    print $lv->{'contnet'};
	    
	    return 1;
    
    } # end of action

    
    