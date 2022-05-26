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
			
		$lv->{'engine'}  = 'InnoDB';
		
		# content
		
		$lv->{'content'} = 'Set Engine<br>';
				
		# get ea
		
		$lv->{'table_result'} = $dbh->table_info(undef,$global->{'db_name'},'','TABLE');
		 
		$lv->{'table_info'}   = $lv->{'table_result'}->fetchall_hashref('TABLE_NAME');
						
		# each tables
		
		for(sort keys %{$lv->{'table_info'}}){
		    
		    $lv->{'table'} = $lv->{'table_info'}->{$_};
		    
		    $lv->{'content'}.="<b>$lv->{'table'}->{'TABLE_NAME'}</b><br>";
		    
		    # set engine
		    
		    $dbh->do("ALTER TABLE $lv->{'table'}->{'TABLE_NAME'} ENGINE = $lv->{'engine'}");
		    		   
			
		} # each table
		
		# get column info
		
		print $lv->{'content'};
	    
	    return 1;
    
    } # end of action
    

    
    