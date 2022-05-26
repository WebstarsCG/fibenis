#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
	    my $param  = shift @_;
	    
	    my $dbh    = $param->{'dbh'};
	    
	    my $cdbh   = $param->{'cdbh'};
	    
	    my $global = $param->{'global'};
	    
	    my $req    = $param->{'req'};
	    
	    my $lv;
	    
	    $lv->{'content'} = 'Set Length<br>';
	    $lv->{'counter'}->{'row'}=0;
	    
	    $lv->{'is_auto'}->{1}= " NOT NULL AUTO_INCREMENT ";
	    $lv->{'is_auto'}->{0}= "";
	    
	    # get ea
	    
	    $lv->{'len'} = $cdbh->selectall_hashref("SELECT
								id,
								table_name,
								field_name,
								field_type,
								field_size,
								is_auto
							    FROM
								len",1);
	    
	
	    
	    # len
	    
	    foreach (sort keys %{$lv->{'len'}}){
		
		my $len = $lv->{'len'}->{$_};
		
		# counter
		
		$lv->{'counter'}->{'row'}++;
		
		# table clean
		
		$len->{'table_name'}=~s/[^\w\_]//ig;
		
		# field clean
		
		$len->{'field_name'}=lc($len->{'field_name'});
		
		$len->{'field_name'}=~s/[^\w\_]//ig;
					
		$lv->{'content'}.="$lv->{'counter'}->{'row'}) $len->{'table_name'} - $len->{'field_name'} - $len->{'field_type'} ($len->{'field_size'}) <br>";		
		    
		$lv->{'len_query'} = "ALTER TABLE $len->{'table_name'}
						MODIFY $len->{'field_name'}
						$len->{'field_type'}($len->{'field_size'})
						$lv->{'is_auto'}->{$len->{'is_auto'}}
					";			    
		    
		$dbh->do($lv->{'len_query'});
		
	    } # end index
	    
	    
	    print $lv->{'content'};
	    
	    return 1;
    
    } # end of action

    
    