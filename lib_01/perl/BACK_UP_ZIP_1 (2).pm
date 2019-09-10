#!/usr/bin/perl -w 
    
    package BACK_UP_ZIP;  
	
	use Archive::Zip;
	
	use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
	
	use Schedule::ByClock;
	
	use File::Path 'remove_tree';
        
        use File::Find;
	
	use DATE_NAMING;
        
        use FILE_SIZE_FINDER;
	
	use Archive::Extract;
	
	use DBI;
	
	use Array::Utils qw(:all);
	
	use CGI;
	
	use CGI::Carp qw/fatalsToBrowser/;
	
	use warnings;
	
	
	
	#my $backup_user_name    =  'root';  
	#
	#my $driver              =  "mysql";
	#
	#my $backup_data_base    =    'backup';
	#
	#my $dsn                  = "DBI:$driver:database=$backup_data_base";
	#
	#my $backup_password     =  '';
	#
	#my $dbh = DBI->connect($dsn, $backup_user_name, $backup_password ) or die $DBI::errstr;
                
        
    #Function
    
	sub create_back_up(){
            
            
	    my $scheduler = Schedule::ByClock->new(0,10,20,30,40,50);
	    
	    

	    #while ( defined( my $r = $scheduler->get_control_on_second ) ){
		    
		    my $backup_r_v          =   $_[0];
		    
		    my $application_name    =   $backup_r_v ->{app_property }->{application_name};
		    
		    my $mysql_bin           =   $backup_r_v ->{mysql_conf};
		    
		    
		    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
		    
		    #print $restore_filename;
		    
		    my $type		    = "backup";
	    
		    
	    
		    my $backup_user_name    =  	$backup_r_v->{base_config}->{backup_user_name};  
		    
		    my $driver              = 	$backup_r_v->{base_config}->{driver};  
		                 
		    my $backup_data_base    =  $backup_r_v->{base_config}->{backup_data_base};  
		                 
		    my $dsn                  = "DBI:$driver:database=$backup_data_base";
		                 
		    my $backup_password     =  $backup_r_v->{base_config}->{ backup_password};
		    
		    my $dbh = DBI->connect($dsn, $backup_user_name, $backup_password ) or die $DBI::errstr;
		    
		    my $sth		=	$dbh->prepare("INSERT INTO backup_log (file_name,date,start,type) values (?,?,?,?) ");
		    
		    $start_time		=	"$hour:$min:$sec";
		    
		    $year		+=	1900;
		    
		    $mon		+=	1;
		    
		    $start_date		=	"$year-$mon-$mday";
		    
		    $sth->execute($application_name,$start_date,$start_time,$type);
		    
		    $sth->finish();
		   
		    
		    
		    
		# Back up folder naming by date and time
	    
		    my $naming_data     =   &DATE_NAMING::date_naming();
		    
		    my $file_name       =   $application_name.'_'.$naming_data->{theTime}.$naming_data->{p_year}.$naming_data->{p_hour}.$naming_data->{p_minute}.$naming_data->{second};
		    
		    my $temp_path       =   'c:/xampp/htdocs';
		    
		    my $dir             =   $temp_path.'/tmp';
		    
		    mkdir($dir);
		   
		# Copy the file to the temp file
		
		    my $log="Failure";
		    
		    my $err="File Location Is Incorrect";
		
		    dircopy($backup_r_v->{app_property }->{folder_to_backup},$dir) or die "Error in location".goto LOG;
		    
		   #print "Folder Will get backuped";
		    
		
                    foreach my $key (keys %{$backup_r_v}){
		    
			if ($key eq "remove_folder") {
			
		     
			    foreach(@{$backup_r_v->{$key}}){
			
				my $r_d     =   $dir.'/'.$_;
		       
				remove_tree( $r_d, {keep_root => 1} ) or  print "No Such Folder Has Been Found But Backup Has Been Made\n\n";
			
				#print $backup_r_v->{remove_folder}->[$_];
		       
			    }
			}
			    
			if ($key eq "remove_folder_comp") {
			    
			    foreach(@{$backup_r_v->{$key}}){
				
				my $r_d     =   $dir.'/'.$_;
		       
			        remove_tree( $r_d, {keep_root => 0} ) or print "No Such Folder Has Been Found But Backup Has Been Made\n\n";
			    
			    }
		       } 
		    
		    } #for
		   
		   # db
		   
		   my $database_backup 	=	$backup_r_v->{db_backup}->{is_backup};
		   
		   my $user_name    	=   	$backup_r_v->{db_backup}->{user_name};
		   
		   my $get_password 	=   	($backup_r_v->{db_backup}->{password})? $backup_r_v->{db_backup}->{password}:'';
                   
                   my $password     	= 	$get_password eq '' ?'' : '-p $password';
		   
		   my $data_base    	=   	$backup_r_v->{db_backup}->{db_name};
		   
		   my $db_path      	=   	$dir.'/DB_BACKUP/';
		   
		   mkdir($db_path );
		   
		   my $b_file_name    	=  	$db_path.$application_name.'_db_backup.sql';
		   
################################################################################################################
                    
                   
                   
		   
################################################################################################################
		# Check For Db Backup
		
		   #if ($database_backup eq 1) {
		    
		    #check for Structure backup
			
                        if (exists($backup_r_v->{db_backup}->{is_structure_only}) && ($backup_r_v->{db_backup}->{is_structure_only} eq 1)){
			    
			    #if ($backup_r_v->{db_backup}->{is_structure_only} eq 1) {
			    
				my $s_db_file_name = $db_path.$data_base.'_structure_backup.sql';
                                
                                `cd $mysql_bin && mysqldump --no-data -u $user_name $password $data_base > $s_db_file_name`;
				
			 #}
			}
		    #Check for Full db backup
			
                        if (exists($backup_r_v->{db_backup}->{is_db_full_backup}) && ($backup_r_v->{db_backup}->{is_db_full_backup} eq 1) ){
			
			    #if($backup_r_v->{db_backup}->{is_db_full_backup} eq 1){
				
				my $f_db_file_name = $db_path.'full_db_backup.sql';
                                
                                `cd $mysql_bin && mysqldump -h localhost -u $user_name $password $data_base > $f_db_file_name`;
			   #}
			}
		    #check for table backup
		    
			if (exists ($backup_r_v->{db_backup}->{table_name})) {
			  
			    foreach(@{$backup_r_v->{db_backup}->{table_name}})
			    
			    {
				my $t_name          =   $_;
                                
                                my $t_s_file_name   =   $db_path.$t_name.'_table_structure_db_backup.sql';
				
				my $t_file_name     =  $db_path.$t_name.'_table_data_db_backup.sql';
                                
			       # print $t_file_name;
				
			    # Table Backup - structure
                            
                                my $password = $password eq '' ?'' : '-p $password';
                            
                                  `cd $mysql_bin && mysqldump --no-data -h localhost -u $user_name  $password $data_base $t_name\ >$t_s_file_name`;
                            
                            # Table Backup -data
                                
                                `cd $mysql_bin && mysqldump -h localhost -u $user_name $password --no-create-info $data_base $t_name \ > $t_file_name `;
			    
			    }
			
			}
		    #Multiple DB Backup
		    
			if (exists($backup_r_v->{db_backup}->{multiple_database})){
		       
			    foreach(@{$backup_r_v->{db_backup}->{multiple_database}}){
			       
				my $m_name  =   $_;
			       
				my $m_db_file_name = $db_path.$m_name.'_multiple_full_db_backup.sql';
			       
			       `cd $mysql_bin && mysqldump -h localhost -u $user_name $password $m_name > $m_db_file_name`;
			       
			    }
			}
		    #Data only
                    
                        if (exists($backup_r_v->{db_backup}->{is_data_only}) && ($backup_r_v->{db_backup}->{is_data_only} eq 1) ){
                            
                            my $data_db_file_name = $db_path.$data_base.'_data_db_backup.sql';
                            
                            `cd $mysql_bin && mysqldump -h localhost -u $user_name $password --no-create-info $data_base > $data_db_file_name`;
                        
                        }
		    # Delete a particular table and backup a remaining table
			
			if (exists($backup_r_v->{db_backup}->{delete_table}) && (@{$backup_r_v->{db_backup}->{delete_table}->{table_to_delete}})){
			    
			#if(@{$backup_r_v->{db_backup}->{delete_table}->{table_to_delete}}) {
			    
			   # my $d_database_name =   $backup_r_v->{delete_table}->{database_name};
			    
			    my $unzip_folder    =   $backup_r_v->{unzip}->{unzip_folder};
			    
			    my $dsn             =   "DBI:mysql:database=$data_base";
				
			    my $dbh             =   DBI->connect( $dsn,$user_name, $password) or die $DBI::errstr;
			    
			    my $sql             =   $dbh->prepare("show tables");
			    
			    my $p_d_table_file_name = $db_path.'particular_table_backup_db_backup.sql';
                            
                            my $p_d_table_s_file_name = $db_path.'particular_table_structure_backup_db_backup.sql';
                            
                            
			    
			    $sql->execute() or die $DBI::errstr;
			    
			    my $ary_ref         =   $dbh->selectcol_arrayref($sql) or die $DBI::errstr;
			    
			    my @whole_db_table  =   @{$ary_ref};
			    
			    my @diff            =   array_diff(@whole_db_table, @{$backup_r_v->{db_backup}->{delete_table}->{table_to_delete}});
                        
                        #Particular table_backup -Structure
                        
                            `cd $mysql_bin && mysqldump --no-data -h localhost -u $user_name $password $data_base @diff\ > $p_d_table_s_file_name`;
                        
                        #Particular table_backup -data
                        
			    `cd $mysql_bin && mysqldump -h localhost -u $user_name $password --no-create-info $data_base @diff\ > $p_d_table_file_name `;
			}
		    
                #Group Db Backup
                
                    if (exists($backup_r_v->{db_backup}->{group})) {
                        
                        my @hash_key        =    keys %{$backup_r_v->{db_backup}->{group}};
                        
                        #print @hash_key;
                        
                        my $size_hask_key   =   scalar @hash_key;
                        
                        my $group           =   $backup_r_v->{db_backup}->{group};
                        
                        for(my $group_key=0; $group_key<$size_hask_key; $group_key++){
                            
                            if (exists($group->{$hash_key[$group_key]}->{exclude})) {
                                
                                my $dsn             =   "DBI:mysql:database=$data_base";
				
                                my $dbh             =   DBI->connect( $dsn,$user_name, $password) or die $DBI::errstr;
			    
                                my $sql             =   $dbh->prepare("show tables");
                                
                                my $p_d_table_file_name = $db_path.$hash_key[$group_key].'_group_table_exclude_data_backup_db_backup.sql';
                            
                                my $p_d_table_s_file_name = $db_path.$hash_key[$group_key].'_group_table_exclude_structure_backup_db_backup.sql';

                                $sql->execute() or die $DBI::errstr;
			    
                                my $ary_ref         =   $dbh->selectcol_arrayref($sql) or die $DBI::errstr;
			    
                                my @whole_db_table  =   @{$ary_ref};
                                
                                my @excluded_array  =   @{$group->{$hash_key[$group_key]}->{exclude}};
			    
                                my @diff            =   array_diff(@whole_db_table, @excluded_array );
                                
                            #Particular table_backup -Structure
                        
                                `cd $mysql_bin && mysqldump --no-data -h localhost -u $user_name $password $data_base @diff\ > $p_d_table_s_file_name`;
                        
                            #Particular table_backup -data
                        
                                `cd $mysql_bin && mysqldump -h localhost -u $user_name $password --no-create-info $data_base @diff\ > $p_d_table_file_name `;
                               
                            }#if
                            
                            if (exists($group->{$hash_key[$group_key]}->{include})) {
                                
                                my @include_array       =   @{$group->{$hash_key[$group_key]}->{include}};
                                
                                #print @include_array;
                                
                                my $p_d_table_file_name = $db_path.$hash_key[$group_key].'_group_table_include_data_backup_db_backup.sql';
                            
                                my $p_d_table_s_file_name = $db_path.$hash_key[$group_key].'_group_table_include_structure_backup_db_backup.sql';
                                
                            #Particular table_backup -Structure
                        
                                `cd $mysql_bin && mysqldump --no-data -h localhost -u $user_name $password $data_base @include_array\ > $p_d_table_s_file_name`;
                        
                            #Particular table_backup -data
                        
                                `cd $mysql_bin && mysqldump -h localhost -u $user_name $password --no-create-info $data_base @include_array\ > $p_d_table_file_name `;
                                
                            }#if
                            
                            
                        }#for                       
                    
                    }#if
                    
		   
		# Create a handler for creating a archeive
		
		    my $zip = Archive::Zip->new();
		
		# add all readable files and directories below .
	 
		    $zip->addTree( $dir , $application_name);
	    
		   
		# WRITE BLOCK And write them into a file
		
		    $zip->writeToFileNamed($backup_r_v ->{app_property }->{write_backup }.$file_name.'.zip');
                    
                    my $zip_file_name = $file_name.'.zip';
	
		    remove_tree( $dir, {keep_root => 0} );
	    
		# END OF WRITE
	    
		    if ($zip->eocdOffset())
		    {
			warn "A virus has added ", $zip->eocdOffset, " bytes of garbage\n";
		    }
	    
		#now extract the same files into /tmpx
		    
		    
		     unless ($backup_r_v ->{app_property }->{write_backup }.$file_name.'.zip' == AZ_OK ) {
			
			die goto LOG;
			
			$err	=	"Error In Zip";
		     }
			$log="Success";
			
			$err	=	"             BACKUP  SUCCESSFULL";
			
			#print "           BACKUP ===============> SUCCESSFULL \n\n";
		    
		    LOG:
		    
                        my ($sec_u,$min_u,$hour_u,$mday_u,$mon_u,$year_u,$wday_u,$yday_u,$isdst_u) = localtime();
			
			my $start_time_u	=	"$hour_u:$min_u:$sec_u";
			
			#print "UPDATE backup_log SET  end = '$start_time_u', status ='$log' WHERE
			#			      
			#				file_name='$application_name'
			#			      AND
			#				start='$start_time'
			#			      ";
			
			$sthu	=	$dbh->prepare("UPDATE backup_log SET  end = '$start_time_u', status ='$log' WHERE
						      
							file_name='$application_name'
						      AND
							start='$start_time'
						      ");
                       
		        $sthu->execute();
			
			print $err;
			
			
            ######################################################################################################
            
               
                my $zipfile = $backup_r_v ->{app_property }->{write_backup }.$file_name.'.zip';
                
                if ( -e $zipfile) {
                    
                    my $size_kb =   &FILE_SIZE_FINDER::file_size($zipfile);
                   
                    my $sth = $dbh->prepare("INSERT INTO file_desk
                                                
                                                (backup_filename,app_name,size,backup_location,created_on)
                                            values
                                                ('$zip_file_name','$application_name','$size_kb','$zipfile',CURRENT_DATE)");
                        
                        $sth->execute() or die $DBI::errstr;
                        
                        $sth->finish();
                        
                        #print $current_date;
                        
                }
            
            ######################################################################################################
		    
		    
		
     
     } # End Of Function
        
    # Restore function automatic
    
        sub restore(){
            
            my $backup_r_v          =   $_[0];
	    
	    my $type		    = 	"Restore";
	    
	    my $restore_filename    = 	"$backup_r_v->{current_file_name}";
	    
	    my $auto_db		    =   "$backup_r_v->{restore_database}->{auto_backup_db }";
	    
	    my $app_name	    = 	"$backup_r_v->{app_name}";
	    
	    my $backup_user_name    =   $backup_r_v->{base_config}->{backup_user_name};
	       
	    my $get_password        =  ($backup_r_v->{base_config}->{backup_password})? $backup_r_v->{db_backup}->{password}:'';
	    
	    my $backup_password     =   $get_password eq '' ?'' : '-p $password';
	    
	    my $data_base           =   $backup_r_v->{base_config}->{backup_data_base };
	    
	    my $driver		    =   $backup_r_v->{base_config}->{driver};
	       
	    my $dsn                  = "DBI:$driver:database=$data_base";
	    
	    my $mysql_bin           =   $backup_r_v ->{mysql_conf};
	    
	    my $dbh = DBI->connect($dsn, $backup_user_name, $backup_password ) or die $DBI::errstr;

	    my $log='Failure';
	    
            if (exists($backup_r_v->{unzip}->{is_unzip}) &&($backup_r_v->{unzip}->{is_unzip} eq 1)){
		
		    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
		    
		    #print $restore_filename;
		
		    my $sth		=	$dbh->prepare("INSERT INTO backup_log (file_name,date,start,type) values (?,?,?,?) ");
		    
		    $start_time		=	"$hour:$min:$sec";
		    
		    $year		+=	1900;
		    
		    $mon		+=	1;
		    
		    $start_date		=	"$year-$mon-$mday";
		    
		    $sth->execute($restore_filename,$start_date,$start_time,$type);
		    
		    $sth->finish();
		   
			
		### build an Archive::Extract object ###
		    
		    # my $unzip_file	=   $backup_r_v->{unzip}->{file_name}; 
		    
		    my $unzip_file	=  $backup_r_v ->{unzip}->{file_name};
		       
		    # print $unzip_file;
		      
		    my $zip_extract	= 	Archive::Extract->new( archive => $unzip_file ) or goto LOG;
			
		### extract 
			
		    my $ok 		= 	$zip_extract->extract( to => $backup_r_v->{unzip}->{unzip_folder} ) or die $zip_extract->error;
                        
		    if ($ok eq 1 ){
                            
                        print "\n";
                           
                        print "\t\t\t                          RESTORE SUCCESSFULL         \n";
			    
			$log="Success";
			    
			    
                    }else{
			    
			print "Extract Error";
			    
			$log="Failure";
			    
		    }
		}
            
               if ($backup_r_v->{restore_database}->{is_restore_db} eq 1) {
		    
		    
		    my $path        =   $backup_r_v->{unzip}->{unzip_folder}."$app_name";
		    
		   # print $path;
		    
		    my  $path_db    = '';
		    
		    opendir my $dir, $path or die "Cannot open directory: $!";
    
		    my @files       =   readdir $dir;
		    
		    #print @files;
		    
		#    foreach (@files){
		#    
		#	if ($_ eq '.' || $_ eq '..') {
		#	
		#	}
		#	elsif($_ eq 'DB_BACKUP'){
		#    
		#	    my $path_db   =   $path.'/'.$_;
		#	    
		#	    #opendir my $dir_in, $path_in or die "cant open : $!";
		#	    
		#	   # my @files_d = readdir $dir_in;
		#	    
		#	#    foreach(@files_d){
		#	#
		#	#	if ($_ eq 'DB_BACKUP') {
		#	#	
		#	#		$path_db = $path_in.'/'.$_;
		#	#	}
		#	#    
		#	#    }
		#	   
		#	}
		#    }
		    $path_db = $path;
	    
		    my $folder_path     			=    $path_db.'/full_db_backup.sql' ;
		    
		    my $master_path_exclude_structure   	=    $path_db.'/master_table_group_table_exclude_structure_backup_db_backup.sql';
		    
		    my $master_path_exclude_data   		=   $path_db.'/master_table_group_table_exclude_data_backup_db_backup.sql';
		    
		    my $master_path_include_structure   	=   $path_db.'/master_table_group_table_include_structure_backup_db_backup.sql';
		    
		    my $master_path_include_data   		=   $path_db.'/master_table_group_table_include_data_backup_db_backup.sql';
		    
				   
		    #$dbh->do("create database if not exists $db ");
		    #
		    #$dbh->do( "use $db");
		    
	    #Restore of full Db
                    
		if ($backup_r_v->{restore_database}->{is_full_database_restore}->{is_full_database_condition} eq 1) {
		    
		    my $new_database    =   $backup_r_v->{restore_database}->{is_full_database_restore}->{database_name};
		    
		    my $db_file_name    =   $backup_r_v->{restore_database}->{is_full_database_restore}->{db_file_name};
		    
		    $dbh->do("create database IF NOT EXISTS $new_database ");
		    
		   $dbh->do( "use $new_database");
		   
		   `cd $mysql_bin && mysql -u $backup_user_name $backup_password $new_database < $db_file_name`;
		    
		}
		
		
	    #Restore  with structure and table
                        
		if (exists($backup_r_v->{restore_database}->{structure_data_restore}) && ($backup_r_v->{restore_database}->{structure_data_restore}->{table_structure_restore} eq 1)) {

		    my $new_database    	=   $backup_r_v->{restore_database}->{structure_data_restore}->{database_name};
		    
		    my $structure_file_name     =   $backup_r_v->{restore_database}->{structure_data_restore}->{db_structure_name};
			    
		    my $data_file_name  	=   $backup_r_v->{restore_database}->{structure_data_restore}->{db_data_name };
		    
		    $dbh->do("create database if not exists $new_database ");
		    
		    $dbh->do( "use $new_database");
		    
		    #print  $structure_file_name ;
		    
		    $sql    =   $dbh->prepare("SHOW tables");
		    
		    my $ary_ref         =   $dbh->selectcol_arrayref($sql) or die goto EMPTY;
			    
                    my @whole_db_table  =   @{$ary_ref};
                            
                    for(@whole_db_table) {
			
			$dbh->do("DROP table $_");
                               
                        }
		EMPTY:
		
		    $dbh->do("create database if not exists $new_database ");
				
		    $dbh->do( "use $new_database");
		    
		#importing structure of table
                                
		    `cd $mysql_bin && mysql -u $backup_user_name $backup_password  $new_database  < $structure_file_name`;
                                
                #importing a table data
                            
                   `cd $mysql_bin && mysql  -u $backup_user_name $backup_password  $new_database < $data_file_name`;
                
		
		}
		
	    #Restore  single table  structure and table
                        
		if (exists($backup_r_v->{restore_database}->{db_table_restore}) && ($backup_r_v->{restore_database}->{db_table_restore}->{db_table_alone})) {
		    
		    my $new_database    	=   $backup_r_v->{restore_database}->{structure_data_restore}->{database_name};
		    
		    my $structure_file_name     =   $backup_r_v->{restore_database}->{db_table_restore}->{db_structure_name};
		   
		    my $data_file_name  	=   $backup_r_v->{restore_database}->{db_table_restore}->{db_data_name };
		    
		    #print $new_database ;
		    
		    $dbh->do("create database if not exists $new_database ");
		    
		    $dbh->do( "use $new_database");
		    
		    $sql    =   $dbh->prepare("SHOW tables");
		    
		    $sql->execute()or die $DBI::errstr;
		    
		    my $ary_ref         =   $dbh->selectcol_arrayref($sql) or die $DBI::errstr;
		    
		    my @whole_db_table  =   @{$ary_ref};
		    
		    #print @whole_db_table;
		    
		    my $table_name      =   $backup_r_v->{restore_database}->{db_table_restore}->{restore_table};
		    
		    my @t_name= @{$table_name};
		    
		    if (@whole_db_table eq @t_name) {
			
			$dbh->do("DROP table @t_name ");
		       
		    }
			
		    #importing structure of table
			
			`cd $mysql_bin && mysql -u $backup_user_name $backup_password  $new_database  < $structure_file_name`;
			
		    #importing a table data
		    
			`cd $mysql_bin && mysql  -u $backup_user_name $backup_password  $new_database < $data_file_name`;
		    
		    }
	
	    
	    if (-e $folder_path) {
                
		  #  my $new_database	=	$backup_r_v->{restore_database}->{is_full_database_restore}->{database_name};
		    
		    $dbh->do("create database if not exists $auto_db ");
				
		    $dbh->do( "use $auto_db");
		    
                   `cd $mysql_bin && mysql -u $backup_user_name $backup_password  $auto_db < $folder_path `;
                    
                    print "\n";
                    print "ABOUT DB BACKUP \n\n";
                    print "\t-------->Full DB is UPDATED \n";
                    
                    
                    goto DB_END;
                }
               
               if(-e $master_path_exclude_structure){
		
		
		    $dbh->do("create database if not exists $auto_db ");
				
		    $dbh->do( "use $auto_db");
                 
                    `cd $mysql_bin && mysql -u $backup_user_name $backup_password $auto_db < $master_path_exclude_structure `;
                    
                    `cd $mysql_bin && mysql -u $backup_user_name $backup_password $auto_db < $master_path_exclude_structure `;
                    
                    print "\n";
                    print "ABOUT DB BACKUP \n\n";
                    print "\t---------->Master Table Has Sussfully Update \n" ;
                  
                    goto DB_END;
                    
               }
               
                if(-e $master_path_include_structure){
		    
		    $dbh->do("create database if not exists $auto_db");
				
		    $dbh->do( "use $auto_db");
                 
                    `cd $mysql_bin && mysql -u $backup_user_name $backup_password $auto_db < $master_path_include_structure `;
                    
                    `cd $mysql_bin && mysql -u $backup_user_name $backup_password $auto_db < $master_path_include_structure `;
                    
                    print "\n";
                    print "ABOUT DB BACKUP \n\n";
                    print "\t----------->Master Table Has Sussfully Update \n" ;
                    
                  
                    goto DB_END;
                    
               }
           
            DB_END:
               
            
        }
	        
	LOG:
			if ($log eq 'Failure') {
			    
			    print "RESTORE UNSUCCESSFULL";

			}
			
			my ($sec_u,$min_u,$hour_u,$mday_u,$mon_u,$year_u,$wday_u,$yday_u,$isdst_u) = localtime();
			
			my $start_time_u	=	"$hour_u:$min_u:$sec_u";
			
                        $sthu	=	$dbh->prepare("UPDATE backup_log SET  end = '$start_time_u', status ='$log' WHERE
						      
							file_name='$restore_filename'
						      AND
							start='$start_time'
						      ");
                       
		        $sthu->execute();
		
		
		}   
    
     
1;