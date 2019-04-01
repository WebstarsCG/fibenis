#! /usr/bin/perl -w
    
            # action
            
            sub action(){
                
                        my $param  = shift @_;
                        
                        my $dbh    = $param->{'dbh'};
                        
                        my $cdbh   = $param->{'cdbh'};
                        
                        my $global = $param->{'global'};
                        
                        my $req    = $param->{'req'};
                        
                        my $lv;
                        
                        $lv->{'content'} = 'Set Log<br>';
                        
                        # env
                        
                        $lv->{'log_primary_key'}      = "log_id ";
                        $lv->{'log_primary_key_size'} = "INT(11)";
                        $lv->{'log_type_code'}        = "log_type_code ENUM('LTAD','LTUD','LTDL') NOT NULL";
                        $lv->{'log_datetime'}         = "timestamp_log datetime DEFAULT NOW() NOT NULL";
            
                        # get ea
                        
                        $lv->{'log'} = $cdbh->selectall_hashref("SELECT	    id,
                                                                            table_name,
                                                                            primary_key,
                                                                            timestamp_to_datetime,
                                                                            unique_key
                                                                        FROM
                                                                            log",1);
                        
                        # print Dumper($lv->{'log'});
                        
                        # relation
                        
                        foreach my $log_idx (keys %{$lv->{'log'}}){
                            
                                    my $log = $lv->{'log'}->{$log_idx};
                                    
                                    $lv->{'log_table'} = $log->{'table_name'}.'_log';
                                    
                                    # drop table ifexists
                                    
                                    $lv->{'drop_table_query'} = "DROP TABLE IF EXISTS $lv->{'log_table'}";
                                   
                                    $dbh->do("$lv->{'drop_table_query'}");
                                   
                                    # create table
                                   
                                    $lv->{'table_query'} = "CREATE TABLE $lv->{'log_table'} LIKE $log->{'table_name'}";
                                   
                                    $dbh->do("$lv->{'table_query'}");
                                    
                                    # remove primary key
                                    
                                    $lv->{'alter_primary_key'}  = "ALTER TABLE $lv->{'log_table'} MODIFY $log->{'primary_key'} INT NOT NULL;";                                                              
                                    $lv->{'remove_primary_key'} = "ALTER TABLE $lv->{'log_table'} DROP PRIMARY KEY ;";
                                    
                                    $dbh->do("$lv->{'alter_primary_key'}");
                                    $dbh->do("$lv->{'remove_primary_key'}");
                                    
                                    # uniq
                                    
                                    for(split(/\,/,$log->{'unique_key'})){
                                           
                                                $lv->{'drop_unique_query'} = "ALTER TABLE $lv->{'log_table'}
                                                                               DROP INDEX $_";
                                                                               
                                                $dbh->do($lv->{'drop_unique_query'});
                                                
                                    } # end
                                    
                                    # timestamp to datetime
                                    
                                    for(split(/\,/,$log->{'timestamp_to_datetime'})){
                                           
                                                $lv->{'set_datetime_query'} = "ALTER TABLE $lv->{'log_table'}
                                                                               MODIFY $_
                                                                               datetime";
                                                                               
                                                $dbh->do($lv->{'set_datetime_query'});
                                    } # end
                                    
                                    
                                    # add log table columns
                                   
                                    $lv->{'add_columns'}  = ["ALTER TABLE $lv->{'log_table'} ADD COLUMN $lv->{'log_primary_key'} $lv->{'log_primary_key_size'} FIRST;",
                                                                   "ALTER TABLE $lv->{'log_table'} ADD PRIMARY KEY ( $lv->{'log_primary_key'} )",
                                                                   "ALTER TABLE $lv->{'log_table'} CHANGE
                                                                   $lv->{'log_primary_key'} $lv->{'log_primary_key'} $lv->{'log_primary_key_size'} NULL AUTO_INCREMENT",                                                                  
                                                                   "ALTER TABLE $lv->{'log_table'} ADD COLUMN $lv->{'log_type_code'}",
                                                                   "ALTER TABLE $lv->{'log_table'} ADD COLUMN $lv->{'log_datetime'}"];
                        
                                    for(@{$lv->{'add_columns'}}){
                                                
                                                $dbh->do($_); 
                                    }
                                    
                                    # drop unique and set as query
                                    
                                                                       
                                    # Trigger for insert/update/delete
                                    
                                                $lv->{'content'}.=$log->{'table_name'}."<br>";
                                    
                                                $param->{'table_name'} = $log->{'table_name'};
                                    
                                                $lv->{'column_field'} = &set_column_query($param);
                                                
                                                $lv->{'trg_name_temp'} = " trg_$log->{'table_name'}_after_ins";
                                    
                                                $lv->{'trg'}->{$lv->{'trg_name_temp'}}     =  "                                              
                                                                                                            CREATE TRIGGER $lv->{'trg_name_temp'} AFTER INSERT ON $log->{'table_name'}
                                                                                                            FOR EACH ROW
                                                                                                            BEGIN
                                                                                                                        INSERT INTO $lv->{'log_table'}
                                                                                                                                  (".join(',',@{$lv->{'column_field'}->{'columns'}}).",log_type_code)
                                                                                                                        VALUES
                                                                                                                                  (".join(',',@{$lv->{'column_field'}->{'new_columns'}}).",'LTAD'); 
                                                                                                            END;
                                                                                                             ";
                                                                                                
                                                # after update
                                                
                                                $lv->{'trg_name_temp'} = " trg_$log->{'table_name'}_after_upd ";
                                                
                                                $lv->{'trg'}->{$lv->{'trg_name_temp'}}    =           "                                              
                                                                                                                        CREATE TRIGGER $lv->{'trg_name_temp'} AFTER UPDATE ON $log->{'table_name'}
                                                                                                                        FOR EACH ROW
                                                                                                                        BEGIN
                                                                                                                                    INSERT INTO $lv->{'log_table'}
                                                                                                                                              (".join(',',@{$lv->{'column_field'}->{'columns'}}).",log_type_code)
                                                                                                                                    VALUES
                                                                                                                                              (".join(',',@{$lv->{'column_field'}->{'new_columns'}}).",'LTUD'); 
                                                                                                                        END;
                                                                                                                        ";
                                                                                                
                                                # before delete
                                                
                                                $lv->{'trg_name_temp'} = " trg_$log->{'table_name'}_before_del ";
                                                
                                                $lv->{'trg'}->{$lv->{'trg_name_temp'}}    =           "                                               
                                                                                                                        CREATE TRIGGER  $lv->{'trg_name_temp'}  BEFORE DELETE ON $log->{'table_name'}
                                                                                                                        FOR EACH ROW
                                                                                                                        BEGIN
                                                                                                                                    INSERT INTO $lv->{'log_table'}
                                                                                                                                              (".join(',',@{$lv->{'column_field'}->{'columns'}}).",log_type_code)
                                                                                                                                    VALUES
                                                                                                                                              (".join(',',@{$lv->{'column_field'}->{'old_columns'}}).",'LTDL'); 
                                                                                                                        END;
                                                                                                                        ";
                                                                                                                        
                                                                                                            
                                                # trigger log enable
                                                
                                        
                                                
                                                for(keys %{$lv->{'trg'}}){
                                                           
                                                           # delete trigger 
                                                           
                                                           $dbh->do("DROP TRIGGER IF EXISTS $_");                                                             
                                                           
                                                           # insert trigger 
                                                            
                                                           $dbh->do($lv->{'trg'}->{$_});                                                            
                                                } # end
                                               
                                                        
                        } # end relations
                        
                        print $lv->{'content'};
                        
                        return 1;
            
            } # end of action

    
            # set column query
            
            sub set_column_query(){
                    
                        my $param = shift @_;
                    
                        my $lv;
                    
                    
                        $lv->{'col_info'} = $param->{'dbh'}->selectall_hashref("SHOW COLUMNS FROM $param->{'table_name'}","1");
                
                     
                        
                        $lv->{'columns'} = [];
                                                
                        # column info
                        
                        for(sort keys %{$lv->{'col_info'}}){                                    
                                    
                                    $lv->{'col'} = $lv->{'col_info'}->{$_};
                                    
                                    push(@{$lv->{'columns'}},$lv->{'col'}->{'Field'});
                                    
                        } # each column
                        
                        # column
                        
                        @{$lv->{'new_columns'}} = map { "new.".$_ } @{$lv->{'columns'}};
                        
                        @{$lv->{'old_columns'}} = map { "old.".$_ } @{$lv->{'columns'}};
                        
                        return { 'columns'     => $lv->{'columns'},
                                 'new_columns' => $lv->{'new_columns'},
                                 'old_columns' => $lv->{'old_columns'}
                        };
                        
            } # end