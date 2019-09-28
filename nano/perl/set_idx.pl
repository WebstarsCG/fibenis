#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
	    my $param  = shift @_;
	    
	    my $dbh    = $param->{'dbh'};
	    
	    my $cdbh   = $param->{'cdbh'};
	    
	    my $global = $param->{'global'};
	    
	    my $req    = $param->{'req'};
	    
	    my $lv;
	    
	    $lv->{'content'}='Set Index<br>';
	    
	    
	    
	    
	    # get ea
	    
	    $lv->{'idx'} = $cdbh->selectall_hashref("SELECT
								id,
								table_name,
								field_names
							    FROM
								idx",1);		
	    # relation
	    
	    foreach (sort keys %{$lv->{'idx'}}){
		
		my $idx = $lv->{'idx'}->{$_};
		
		# table clean
		
		$idx->{'table_name'}=~s/[^\w\_]//ig;
		
		# field clean
		
		$idx->{'field_names'}=lc($idx->{'field_names'});
		
		$idx->{'field_names'}=~s/[^\w\,\_]//ig;
		
		@{$idx ->{'fields'}} = split(/,/,$idx ->{'field_names'});
		
		$lv->{'content'}.="Table : ".$idx->{table_name}."<br>";
		
		# for each field
		
		for my $field_name (sort @{$idx ->{'fields'}}){
		    
			$lv->{'content'}.="&nbsp;&nbsp;&nbsp;$field_name<br>";
		    
			$lv->{'idx_query'} = "ALTER TABLE $idx->{table_name}
					     ADD INDEX ( $field_name )";			    
			    
			$dbh->do($lv->{'idx_query'});
			
		} # each field		    
		
	    } # end index
	    
	    print $lv->{'content'};
	    
	    return 1;
    
    } # end of action

    
    