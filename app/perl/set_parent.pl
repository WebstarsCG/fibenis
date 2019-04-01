#! /usr/bin/perl -w
    
    # action
    
    sub action(){
	
            my $param  = shift @_;
            
            my $dbh    = $param->{'dbh'};
            
            my $cdbh   = $param->{'cdbh'};
            
            my $global = $param->{'global'};
            
            my $req    = $param->{'req'};
            
            my $lv;
                            
            # content
            
            $lv->{'content'} = '';
            
            $lv->{'intent'}->{2}="&nbsp;&nbsp;&nbsp;";
            
            $lv->{'counter'}->{'unmatched'}  = 0;
            
            # column name
            
            $lv->{'column_type'}->{$_} = sub(){ return "'".$_[0]."_".$_[1]."'"; } for(('TEXT','VARCHAR','CHAR'));
            $lv->{'column_type'}->{$_} = sub(){ return "'NANA'"; } for(('ENUM'));
            $lv->{'column_type'}->{$_} = sub(){ return 0; } for(('TINYINT','SMALLINT','INT','BIGINT','MEDIUMINT','DECIMAL'));
            $lv->{'column_type'}->{$_} = sub(){ return 'now()'; } for(('DATETIME','DATE','TIME','TIMESTAMP'));
                                                                 
                  
            
            # each realtion
            
            $lv->{'relation_info'} = $cdbh->selectall_hashref("SELECT
                                                                id,
                                                                child_table,
                                                                child_field,
                                                                parent_table,
                                                                parent_field,
                                                                parent_action
                                                            FROM
                                                                parent",1);
            
                                            
            # each relation
            
            for(sort keys %{ $lv->{'relation_info'} }){
                
                        $lv->{'relation'} = $lv->{'relation_info'}->{$_};
                        
                        # iteration val
                        
                        $lv->{'q_columns'} = [];
                        $lv->{'q_values'} = [];
                        
                        # check un matches
                        
                        $lv->{'parent_child_unmatch_query'} = "         SELECT
                                                                                    count(*) as counter,$lv->{'relation'}->{'child_field'} as child_field
                                                                        FROM
                                                                                    $lv->{'relation'}->{'child_table'} 
                                                                        WHERE
                                                                                   $lv->{'relation'}->{'child_field'}
                                                                                    NOT IN (    SELECT
                                                                                                            $lv->{'relation'}->{'parent_field'}
                                                                                                FROM
                                                                                                            $lv->{'relation'}->{'parent_table'})
                                                                        GROUP BY
                                                                                    child_field
                                                                        ";
            
                        $lv->{'unmatched_info'}             = $dbh->selectall_hashref($lv->{'parent_child_unmatch_query'},2);
                                                
                        $lv->{'unmatched_counter'}          = scalar(keys %{$lv->{'unmatched_info'}});
                        
                        
                        # unmatched counter
                        
                        if($lv->{'unmatched_counter'}){
                                    
                                    # build dummy query
                                    
                                    $lv->{'content'}.="<b> $lv->{'relation'}->{'parent_table'}</b><br>";
                                        
                                    # set column char                
                                    
                                    $lv->{'col_result'} = $dbh->column_info(undef,
                                                                            $global->{'db_name'},
                                                                            $lv->{'relation'}->{'parent_table'},
                                                                            '');
                                    
                                    $lv->{'col_info'}   = $lv->{'col_result'}->fetchall_hashref('COLUMN_NAME');
                                                        
                                    # column info
                                    
                                    for(sort  {$lv->{'col_info'}->{$a}->{'ORDINAL_POSITION'} <=> $lv->{'col_info'}->{$b}->{'ORDINAL_POSITION'}} keys %{$lv->{'col_info'}}){				
                                            
                                                $lv->{'col'} = $lv->{'col_info'}->{$_};				
                                            
                                                $lv->{'content'}.=$lv->{'intent'}->{2}."$lv->{'col'}->{'ORDINAL_POSITION'}) $lv->{'col'}->{'COLUMN_NAME'} ($lv->{'col'}->{'TYPE_NAME'})<br>";
                                                
                                                # columns
                                                
                                                push(@{$lv->{'q_columns'}},$lv->{'col'}->{'COLUMN_NAME'});
                                                
                                                # value 'mysql_is_pri_key'
                                                
                                                if ($lv->{'col'}->{'mysql_is_pri_key'}){

                                                            push(@{$lv->{'v_columns'}},'[[PRIMARY_ID]]');
                                                            
                                                }else{ # other than primary
                                                                
                                                            push(@{$lv->{'v_columns'}},
                                                                 $lv->{'column_type'}->{$lv->{'col'}->{'TYPE_NAME'}}->('[[PRIMARY_ID]]',$lv->{'col'}->{'COLUMN_NAME'})
                                                            );
                                                            
                                                } # end
                                                
                                    } # end
                                    
                                    # unmatched id
                                    
                                    $lv->{'content'}.="<br>Unmatched Id: $lv->{'relation'}->{'parent_table'}-$lv->{'relation'}->{'parent_field'}<br>";
                                    
                                    for(sort {$a <=> $b} keys %{$lv->{'unmatched_info'}}){
                                               
                                               $lv->{'counter'}->{'unmatched'}++;
                                                
                                               $lv->{'content'}.=$lv->{'intent'}->{2}.$lv->{'counter'}->{'unmatched'}.") $_<br>";
                                               
                                               $lv->{'parent_id'} = $_;
                                               
                                               # fields
                                               
                                               $lv->{'parent_query_field_text'} = join(',',@{$lv->{'q_columns'}});
                                               
                                               # values
                                               
                                               $lv->{'parent_query_value_text'} = join(',',@{$lv->{'v_columns'}});
                                               
                                               # replace with [[PRIMARY_ID]]-id
                                               
                                               $lv->{'parent_query_value_text'}=~s/(\[\[PRIMARY_ID\]\])/$lv->{parent_id}/ieg;
                                               
                                                $lv->{'parent_add_query'} = "INSERT INTO $lv->{'relation'}->{'parent_table'}
                                                                            ($lv->{'parent_query_field_text'})
                                                                            VALUES
                                                                            ($lv->{'parent_query_value_text'})
                                                                           ";
                                                                           
                                                                           
                                                
                                                $dbh->do($lv->{'parent_add_query'}) || return $lv->{'parent_add_query'};
                                                
                                    } # end
                                    
                                    
                                    # parent action
                                    
                                    if($lv->{'relation'}->{'parent_action'}){
                                                
                                                $dbh->do("  UPDATE
                                                                        $lv->{'relation'}->{'parent_table'}
                                                                        $lv->{'relation'}->{'parent_action'}
                                                         "); 
                                    }
                        } # end
                        
                       # print Dumper();
                        
                        
                      
                    
            } # each relation
            
            # get column info
            
            print $lv->{'content'};
	    
	    return 1;
    
    } # end of action
    

    
    