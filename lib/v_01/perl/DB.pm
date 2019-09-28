#!/usr/bin/perl -w


        # Package for Getting masters list

        package DB;
        
        use Data::Dumper;
        
        BEGIN{
                 #   do "begin.pl";  
        }
                
        # package
            
            sub new(){
                
                my $self=$_[0];
                
                $objref={
                'dbh'=>$_[1]->{'dbh'} || 0,                
                'tables'=>[],
                'seqs'=>[],
                'constraint_keys'=>[],
                'primary'=>[]                
                };
                
                foreach my $key (%{$_[1]}){
                    $objref->{$key} = $_[1]->{$key};    
                }
                
                bless $objref,$self;
                return $objref;
            }


            # Setting dbh
        
            sub set_dbh(){
                        
                    $_[0]->{'dbh'}=$_[1];
                    
            } # end


            # insert
            
            sub insert(){
                      
                        my $self  = shift @_;                      
                        my $param = shift @_;                      
                        my $lv;                      
                      
                        # each keys
                        
                        foreach my $key (keys(%{$param->{'data'}}) ){
                          
                                      $lv->{'fields'}.=$key.',';
                                      $lv->{'values'}.="'".$param->{'data'}->{$key}."',";
                          
                        } # key
                          
                        # check values
                        
                        if($lv->{'values'}){
                          
                          chop($lv->{'fields'});
                          chop($lv->{'values'});
                          
                        } # end
                        
                        
                        # insert
                        
                        $lv->{'query'} = "INSERT INTO ".$param->{'table'}."(".$lv->{'fields'}.") VALUES (".$lv->{'values'}.")";
                        
                        $self->{'dbh'}->do($lv->{'query'}) || return 0;
                        
                        return 1;
                        
            } # insert
            
            
            sub selectall_arrayref(){
                      
                        my $self  = shift @_;                      
                        my $param = shift @_;                      
                        my $lv;
                        
                        $param->{'where'}= ($param->{'where'})?" WHERE ".$param->{'where'}:'';
                        $param->{'order'}= ($param->{'order'})?" ORDER BY ".$param->{'order'}:'';
                      
                          
                      
                        # each keys
                        
                        for(@{$param->{'columns'}}){
                          
                                      $lv->{'fields'}.=$_.',';                                      
                          
                        } # key
                          
                        # check values
                        
                        if($lv->{'fields'}){                          
                            chop($lv->{'fields'});                                                    
                        } # end
                    
                        # insert
                        
                        $lv->{'query'} = "SELECT $lv->{'fields'} FROM $param->{'table'} $param->{'where'}  $param->{'order'} ";
                        
                        return $self->{'dbh'}->selectall_arrayref($lv->{'query'}) || 0;
                        
            } # insert
            
            # row hashref
            
            sub selectrow_hashref(){
                      
                        my $self  = shift @_;                      
                        my $param = shift @_;                      
                        my $lv;
                        
                        $param->{'where'}= ($param->{'where'})?"WHERE ".$param->{'where'}:'';
                        $param->{'order'}= ($param->{'order'})?"ORDRE BY ".$param->{'order'}:'';
                      
                          
                      
                        # each keys
                        
                        for(@{$param->{'columns'}}){
                          
                                      if($_=~m/(.*?)(\s+)as(\s+)(.*?)/ig){                           
                                        $lv->{'fields'}.=$_.',';
                                      }else{
                                        $lv->{'fields'}.=$_.' as '.$_.',';
                                      }
                          
                        } # key
                          
                        # check values
                        
                        if($lv->{'fields'}){                          
                            chop($lv->{'fields'});                                                    
                        } # end
                    
                        # insert
                        
                        $lv->{'query'} = "SELECT $lv->{'fields'} FROM $param->{'table'} $param->{'where'}  $param->{'order'} ";
                        
                        return $self->{'dbh'}->selectrow_hashref($lv->{'query'}) || 0;
                        
            } # insert
            
            
            # auto serial number
            
            sub set_sequence_number(){
                
                my $self  = shift @_;                      
                my $param = shift @_; 
                
                my $lv;
                
                $lv->{'index'} = 0;
                $lv->{'counter'}=$param->{'start_seq'} || 1;
                
                for my $row (@{$param->{'data'}}){
                
                    $param->{'data'}->[$lv->{'index'}]->[$param->{'seq_binder'}]=$lv->{'counter'};    
                    
                    $lv->{'index'}++;
                    $lv->{'counter'}++;
                } # end
                
                return $param->{'data'};
                
            } # end
            
            
            
            # get db tables
            
            sub get_db_tables(){
                
                my $self  = shift @_;
                
                my $param = shift @_;
                
                $param->{'member'} = 'table';
                
                return $self->get_db_member($param);
            
            } # end
            
            
            # get db member
            
            sub get_db_member(){
                
                my $self  = shift @_;
                
                my $param = shift @_;
                
                my ($lv,$key);
                
                    $lv->{'member'} = [];
                
                    $key =   {
                                'table'=>{  'column_name'   =>  ' table_name ',
                                            'table_name'    =>  ' information_schema.tables ',
                                            'where_filter'  =>  " table_catalog='$self->{'db_name'}' AND ".
                                                                " table_schema ='$self->{'schema_name'}' AND ".
                                                                " table_type <> 'VIEW' ",
                                            'order_by'      =>  " ORDER BY table_name",
                                            
                                            'result'        =>sub(){ return $_[0]->[0]; }
                                },
                                                                
                                'seq'=>  {      'column_name'   => 'sequence_name',
                                                'table_name'    => 'information_schema.sequences ',
                                                'where_filter'  => "sequence_catalog='$self->{'db_name'}' AND sequence_schema ='$self->{'schema_name'}'",
                                                'result'        =>sub(){ return $_->[0]; }
                                },
                        
                              
                                # constraint key
                            
                                #'constraint_key'    => { 'column_name'   => 'constraint_name,concat(column_name,constraint_name)',
                                #                         'table_name'    => 'information_schema.key_column_usage',
                                #                         'where_filter'  => "constraint_catalog='$param->{'db_name'}' and constraint_schema='$param->{'schema_name'}' and table_name='".$param->{'table'}."'"                            
                                #                    },
                                #
                                
                                'primary'  => { 'column_name'   => ' constraint_name,table_name ',
                                                        'table_name'    => ' information_schema.table_constraints ',
                                                        'where_filter'  => "  table_catalog='$self->{'db_name'}'  AND constraint_type='PRIMARY KEY'  ",
                                                        'result'        =>  sub(){ return { 'constraint'=>$_[0]->[0],
                                                                                            'table'     =>$_[0]->[1]
                                                                                         };
                                                                                }
                                                        },
                                
                                
                                'foreign'  => { 'column_name'   => ' constraint_name,table_name ',
                                                        'table_name'    => ' information_schema.table_constraints ',
                                                        'where_filter'  => "  table_catalog='$self->{'db_name'}'  AND constraint_type='FOREIGN KEY'  ",
                                                        'result'        =>  sub(){ return { 'constraint'=>$_[0]->[0],
                                                                                            'table'     =>$_[0]->[1]
                                                                                         };
                                                                                }
                                                        },
                              
                        
                    }; # variable
                    
                    # member
                    
                    $lv->{'member'}      = $key->{$param->{'member'}};
                    
                    $lv->{'members'}     = $param->{'member'}.'s';
                    
                    #print "SELECT ". $lv->{'member'}->{'column_name'}." FROM ". $lv->{'member'}->{'table_name'}." WHERE  ". $lv->{'member'}->{'where_filter'}.$lv->{'member'}->{'order_by'};
                    
                    #print Dumper();
            
                    $lv->{'member_info'} = $self->{'dbh'}->selectall_arrayref("SELECT ". $lv->{'member'}->{'column_name'}." FROM ". $lv->{'member'}->{'table_name'}." WHERE  ". $lv->{'member'}->{'where_filter'}.$lv->{'member'}->{'order_by'}."");        
                    
                    # for each member
                    
                    $lv->{'counter'}->{'member'} = 1;
                    
                    for my $member_info (@{$lv->{'member_info'}}){                        
                        
                        push(@{$lv->{'members'}},$lv->{'member'}->{'result'}->($member_info));
                        
                    } # each member
                
                    # set to member
                    
                    $self->{$lv->{'members'}} = $lv->{'members'};
                    
                    return \@{$lv->{'members'}}; 
                    
            } # end of table
             

            # trigger effect
            
            sub table_inner_action(){
                
                    my $self  = shift @_;                      
                    my $param = shift @_;                      
                   
                    my $lv;
                    
                    # lv action                    
                    
                    $lv->{'action'}->{'trigger'} = sub(){
                        
                            my $self  = $self;
                            my $param = $param;
                            my $lv;
                            
                            $lv->{'table'}->{'counter'}=1;
                        
                            $lv->{'key'} = ($param->{'off'}==1)?" DISABLE ":" ENABLE ";
                            
                            $lv->{'key_term'} = ($param->{'off'}==1)?" Disabled ":" Enabled " if($param->{'debug'});
                                
                            $lv->{'query_prefix'} = " ALTER TABLE ";
                            
                            $lv->{'query_suffix'} =  $lv->{'key'}." TRIGGER ALL ";
                            
                            print "Trigger $lv->{'key_term'} for: <br>" if($param->{'debug'});
                        
                            # each table
                            
                            for my $table_name (@{$self->{'tables'}}){
                                
                                    # query
                                    
                                    $lv->{'query'} = $lv->{'query_prefix'}.$table_name.$lv->{'query_suffix'};                                
                                    
                                    $self->{'dbh'}->do($lv->{'query'}) || return 0;
                                    
                                    print $lv->{'table'}->{'counter'}.") $table_name<br>" if($param->{'debug'});
                                    
                                    $lv->{'table'}->{'counter'}++;
                                
                            } # each table
                            
                            return 1;
                            
                        
                    }; # trigger action
                    
                    # unset primary key
                    
                    $lv->{'action'}->{'unset_primary'} = sub(){
                        
                            my $self  = $self;
                            my $param = $param;
                            my $lv;
                            
                            $lv->{'action'}->{'counter'}=1;
                            
                            $lv->{'query_prefix'} = " ALTER TABLE ";
                            
                            $lv->{'query_suffix'} =  $lv->{'key'}." DROP CONSTRAINT  ";
                        
                            # each table                           
                            
                            for my $primary (@{$self->{'primarys'}}){
                                
                                    # query
                                    
                                                                      
                                    $lv->{'query'} = $lv->{'query_prefix'}.$primary->{'table'}.$lv->{'query_suffix'}.$primary->{'constraint'};                                
                                    
                                    print $lv->{'action'}->{'counter'}.") $lv->{'query'}<br>" if($param->{'debug'});
                                    
                                    $self->{'dbh'}->do($lv->{'query'}) || return 0;
                                    
                                    $lv->{'action'}->{'counter'}++;
                                
                            } # each table
                            
                            return 1;
                        
                    }; # unset primary
                    
                    
                    # unset primary key
                    
                    $lv->{'action'}->{'set_primary'} = sub(){
                        
                            my $self  = $self;
                            my $param = $param;
                            my $lv;
                            
                            $lv->{'action'}->{'counter'}=1;
                            
                            $lv->{'query_prefix'} = " ALTER TABLE ";
                            
                            $lv->{'query_suffix'} =  $lv->{'key'}." ADD PRIMARY KEY  ";
                        
                            # each table                           
                            
                             for my $table_name (@{$self->{'tables'}}){
                                
                                    # query                                    
                                                                      
                                    $lv->{'query'} = $lv->{'query_prefix'}.$table_name.$lv->{'query_suffix'}."($param->{default_key})";                                
                                    
                                    print $lv->{'action'}->{'counter'}.") $lv->{'query'}<br>" if($param->{'debug'});
                                    
                                    $self->{'dbh'}->do($lv->{'query'}) || return 0;
                                    
                                    $lv->{'action'}->{'counter'}++;
                                
                            } # each table
                            
                            return 1;
                        
                    }; # set primary
                    
                    # sequence action
                    
                    $lv->{'action'}->{'update_sequence'} = sub(){
                        
                            my $self  = $self;
                            my $param = $param;
                            my $lv;
                            
                            $lv->{'action'}->{'counter'}=1;
                        
                            # each table
                            
                            for my $member (@{$self->{'seqs'}}){
                                
                                    # query
                                    
                                   @{$lv->{'seq'}} = split(/_id_seq/,$member);
                                    
                                    $lv->{'query'} = " SELECT setval('$member',(SELECT id FROM $lv->{'seq'}->[0] ORDER BY id DESC LIMIT 1)) ";
                                    
                                   # print $lv->{'query'}."<br>" if($param->{'debug'});
                                    
                                    $self->{'dbh'}->do($lv->{'query'}) || return 0;
                                    
                                    print $lv->{'action'}->{'counter'}.") $member<br>" if($param->{'debug'});
                                    
                                    $lv->{'action'}->{'counter'}++;
                                
                            } # each table
                            
                            return 1;
                        
                    }; # sequence action
                    
                    
                    # reset sequence action
                    
                    $lv->{'action'}->{'reset_sequence'} = sub(){
                        
                            my $self  = $self;
                            my $param = $param;
                            my $lv;
                            
                            $lv->{'action'}->{'counter'}=1;
                        
                            # each table
                            
                            for my $member (@{$self->{'seqs'}}){
                                
                                    # query
                                    
                                   @{$lv->{'seq'}} = split(/_id_seq/,$member);
                                    
                                    $lv->{'query'} = " SELECT setval('$member',1) ";
                                    
                                   # print $lv->{'query'}."<br>" if($param->{'debug'});
                                    
                                    $self->{'dbh'}->do($lv->{'query'}) || return 0;
                                    
                                    print $lv->{'action'}->{'counter'}.") $member<br>" if($param->{'debug'});
                                    
                                    $lv->{'action'}->{'counter'}++;
                                
                            } # each table
                            
                            return 1;
                        
                    }; # sequence action
                    
                    # table rows
                    
                    # lv action                    
                    
                    $lv->{'action'}->{'table_rows'} = sub(){
                        
                            my $self  = $self;
                            my $param = $param;
                            my $lv;
                            
                            $lv->{'table'}->{'counter'}=1;
                            
                            $lv->{'table_info'}={};
                
                            print "Trigger $lv->{'key_term'} for: <br>" if($param->{'debug'});
                        
                            # each table
                            
                            for my $table_name (@{$self->{'tables'}}){
                                
                                    # query
                                    
                                    $lv->{'query'} = 'SELECT count(*) FROM '.$table_name;
                                    
                                    $lv->{'result'} = $self->{'dbh'}->selectrow_arrayref($lv->{'query'}) || return 0;
                                    
                                    print $lv->{'table'}->{'counter'}.") $table_name:$lv->{'result'}->[0]<br>" if($param->{'debug'});
                                    
                                    $lv->{'table'}->{'counter'}++;
                                    
                                    $lv->{'table_info'}->{$table_name}=$lv->{'result'}->[0];
                                    
                            } # each table
                            
                            return $lv->{'table_info'};
                            
                        
                    }; # trigger action
                    
                    
                    
                    return $lv->{'action'}->{$param->{'action'}}->($self,$param);                     
                    
            } # table inner action
            
            
            
            
            
            
            
        # ea_to_enum


1;

