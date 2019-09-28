#!C:/Perl64/bin/perl.exe

package FILE_WRITE;

    sub txt_file(){
        
        my $r_v         =   $_[0];
        
        my $dbh         =   $r_v->{dbh};
        
        my $database    =   $r_v->{database};
        
        my $db_path     =   $r_v->{db_path};
        
        my $structure_flag  =   $r_v->{structure_flag};
        
        my $f_nmae      =   $r_v->{f_name};
        
        print "gokul--->".$structure_flag;
        
        my $data_flag   =   $r_v->{data_flag};
        
        #print "------------>".$database;
        
        $dbh->do( "use $database");
        
        open my $fileHandle_pl, ">>", "$db_path/$f_nmae .pl" or die "Can't open '$db_path/db.txt'\n";
        
        open my $fileHandle, ">>", "$db_path/db.txt" or die "Can't open '$db_path/db.txt'\n";
        
        $sql    =   $dbh->prepare("SHOW tables");
		    
	$sql->execute()or die $DBI::errstr;
				
	my $ary_ref         =   $dbh->selectcol_arrayref($sql) or die $DBI::errstr;
		    
	my @whole_db_table  =   @{$ary_ref};
        
        if($structure_flag eq 1 ) {
		
            
            print $fileHandle_pl "struct = {";

        
            my $count   =   1;
				
            for(@whole_db_table) {
				
                #print $fileHandle_pl "\t\t".$count." ".$_."\n";
                
                my $tab =   $count ne 1 ? "\t":"";
            
                print $fileHandle_pl  $tab."\t".$count."=>".$_.",\n" ;
            
            $count++;
				
            }
            
            print $fileHandle_pl "};\n";
        }
    #/@ if data flag is there it check fo db tables and record /
    
	if($data_flag eq 1){
           
           print $fileHandle "DB NAME ".$database."\n\n";
            
            $count   =   1;
            
            print $fileHandle "\t\t"."SI.NO"."\t"."NO OF ROWS"."\t"."TABLE NAME"."\n\n";
            
            print $fileHandle_pl "data= {";
            
            for(@whole_db_table) {
                
                $sql    =   $dbh->prepare("SELECT COUNT(*) rows  FROM $_");
                
               # $sql = "SELECT COUNT(*) As $_ FROM $database";
               
                $sql->execute()or die $DBI::errstr;
                
		my $rowq = $sql->fetchrow_hashref;
                
                my $total = $rowq->{'rows'};
                
                print $fileHandle "\t\t".$count."\t".$total."\t\t".$_."\n";
            
                my $tab =   $count ne 1 ? "\t":"";
            
                print $fileHandle_pl  $tab."\t".$_."=>".$total.",\n" ; 
            
                $count++;
				
            }
            
            print $fileHandle_pl "};\n";
            
            close $fileHandle_pl;
        }			
    }
    
1;