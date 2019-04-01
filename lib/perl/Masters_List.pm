#!/usr/bin/perl -w


        # Package for Getting masters list

        package Masters_List;
        
        
        BEGIN{
                 #   do "begin.pl";  
        }
        
        my  %IN_DATA;
        
        # Data fetch from external file
        
        use Master_List_Data;
        
        # package
        
        sub new(){
            
            my $self=$_[0];
            
            $objref={
            'dbh'=>$_[1]||0,
            };
            
            bless $objref,$self;
            return $objref;
        }


        # Setting dbh
        
            sub set_dbh(){
                        
              print $_[0]->{'dbh'}=$_[1];
           }


        
        
         # get third column ref
        
            sub get_3_col_ref(){
                
                 # Calling Engine
                
                    my @temp=Masters_List::id_name_3_engine(@_);
                    
                 # returning reference
                 
                    return \@temp;                
            }

        # get third column ref
        
            sub get_3_col(){
                
                 # Calling Engine
                
                    my @temp=Masters_List::id_name_3_engine(@_);
                    
                 # returning reference
                 
                    return @temp;                
            }

        
        # getting id & name ref
        
            sub get_id_name_ref(){
                
                 # Calling Engine
                
                    my @temp=Masters_List::id_name_engine(@_);
                    
                 # returning reference
                 
                    return \@temp;                
            }

        
        
        # getting id & name
        
            sub get_id_name(){
                
                 # Calling Engine
                
                    my @temp=Masters_List::id_name_engine(@_);
                    
                 # returning array
                 
                    return @temp;                
            }

        
        
        # getting id ref
        
            sub get_id_ref(){
                
                 # Calling Engine
                
                    my @temp=Masters_List::id_engine(@_);
                    
                 # returning reference
                 
                    return \@temp;                
            }

        
        # getting id
        
            sub get_id(){
                
                 # Calling Engine
                
                    my @temp=Masters_List::id_engine(@_);
                    
                 # returning reference
                 
                    return @temp;                
            }
            


         # Id & name retrieve engine

            sub id_name_3_engine(){
                        
                                die "Table Parameter Missing " if(!$_[1]);
                                     
                                # Sifting Array for get object
                                
                                    my $self=shift @_;
                                                                             
                                # ID 
                                
                                    my $ID=shift @_;
                                    
                                    %IN_DATA=%{&Master_List_Data::Get($ID)};
                                
                                # PL -> Place Holders
                                
                                    my @PL=@_;                
                                
                                # Place hoder count
                                
                                    my $pl_count=1;
                                
                                # Result                		
                                
                                    my @result;
                                
                                # Order
                                
                                    my $order=($IN_DATA{'od'})?" ORDER BY ".$IN_DATA{'od'}:'';
                                
                                    my $in_query=$self->{'dbh'}->prepare("SELECT 
                                                                         $IN_DATA{'id'},
                                                                         $IN_DATA{'name'},
                                                                         $IN_DATA{'3'}
                                                                    FROM
                                                                         $IN_DATA{'tn'}
                                                                         $IN_DATA{'where'}                                                   
                                                                    $order");
                                           
                                    if(@PL){
                                                # Place Holder values
                                                
                                                for(1..scalar(@PL)){
                                                
                                                    $in_query->bind_param($pl_count,$PL[$_-1]);
                                                    
                                                    $pl_count++;  
                                                }
                                    }
                                    
                                    
                                    $in_query->execute() || die "$DBI::errstr"."SELECT 
                                                                         $IN_DATA{'id'},
                                                                         $IN_DATA{'name'},
                                                                         $IN_DATA{'3'},
                                                                    FROM
                                                                         $IN_DATA{'tn'}
                                                                         $IN_DATA{'where'}                                                   
                                                                    $order".$self->{'dbh'}->state;         
                               
                                    my $in_data=$in_query->fetchall_arrayref();
                                    
                                    push(@result,{$T_P.'ID'=>$$_[0],$T_P.'NAME'=>$$_[1], $T_P.'3'=>$$_[2]}) foreach(@$in_data);
                                
                                    return @result;
                                    
                } # end of id & name engine. 3

        
        
        # Id & name retrieve engine

            sub id_name_engine(){
                        
                                die "Table Parameter Missing " if(!$_[1]);
                                     
                                # Sifting Array for get object
                                
                                    my $self=shift @_;
                                                                             
                                # ID 
                                
                                    my $ID=shift @_;
                                    
                                    %IN_DATA=%{&Master_List_Data::Get($ID)};
                                
                                # PL -> Place Holders
                                
                                    my @PL=@_;                
                                
                                # Place hoder count
                                
                                    my $pl_count=1;
                                
                                # Result                		
                                
                                    my @result;
                                
                                # Order
                                
                                    my $order=($IN_DATA{'od'})?" ORDER BY ".$IN_DATA{'od'}:'';
                                
                                    my $in_query=$self->{'dbh'}->prepare("SELECT 
                                                                         $IN_DATA{'id'},
                                                                         $IN_DATA{'name'}
                                                                    FROM
                                                                         $IN_DATA{'tn'}
                                                                         $IN_DATA{'where'}                                                   
                                                                    $order");
                                           
                                    if(@PL){
                                                # Place Holder values
                                                
                                                for(1..scalar(@PL)){
                                                
                                                    $in_query->bind_param($pl_count,$PL[$_-1]);
                                                    
                                                    $pl_count++;  
                                                }
                                    }
                                    
                                    
                                    $in_query->execute() || die "$DBI::errstr"."SELECT 
                                                                         $IN_DATA{'id'},
                                                                         $IN_DATA{'name'}
                                                                    FROM
                                                                         $IN_DATA{'tn'}
                                                                         $IN_DATA{'where'}                                                   
                                                                    $order".$self->{'dbh'}->state;         
                               
                                    my $in_data=$in_query->fetchall_arrayref();
                                    
                                    push(@result,{$T_P.'ID'=>$$_[0],$T_P.'NAME'=>$$_[1]}) foreach(@$in_data);
                                
                                    return @result;
                                    
                } # end of id & name engine
                
                
                
                
        
        
        
        # sub for getting id
                
            sub id_engine(){
                                        
                                die "Table Parameter Missing " if(!$_[0]);
                                    
                                # Getting Object
                                
                                my $self=shift @_;
                                                
                                # ID
                                
                                my $ID=shift @_;
                                
                                %IN_DATA=%{&Master_List_Data::Get($ID)};
                                
                                # PL -> Place Holders
                                my @PL=@_;                
                                
                                # Place hoder count
                                my $pl_count=1;
                                
                                
                                my $id_query=$self->{'dbh'}->prepare("SELECT 
                                                                   $ID_DATA{'id'}
                                                                   
                                                                 FROM
                                                                   $ID_DATA{'tn'}
                                                                   $ID_DATA{'where'}                                                   
                                                                 ");
                                           
                               
                               
                               if(@PL){
                                
                                                # Place Holder values
                                                for(1..scalar(@PL)){
                                                    
                                                    $id_query->bind_param($pl_count,$PL[$_-1]);
                                                    
                                                    # Incr place count
                                                    $pl_count++;
                                                }
                                }
                              
                              
                                $id_query->execute() || die "$DBI::error";    
                               
                                my $id_data=$id_query->fetchrow_arrayref() || die "--$DBI::error";    ;
                            
                                return @{$id_data};
                                
                                
                }
                
                
        
        #######################################    To be worked out later ###########################
        
        # Get Enum values in array ref
        
                                # 0 -> table name 1 -> column
                
                sub get_enum{
                    
                    
                    my (@enum_values,%l_v);
                   
                    ($l_v{'self'},$l_v{'table'},$l_v{'column'})=@_;
                    
                    $l_v{'result'}=$l_v{'self'}->{'dbh'}->selectcol_arrayref("DESCRIBE $l_v{'table'}",{'Columns'=>[1,2]}) || die "$DBI::errstr";
                    
                    my %db_info=@{$l_v{'result'}};
                    
                    $l_v{'enum_var'}=$db_info{$l_v{'column'}};
                    
                    $l_v{'enum_var'}=~s/(\w+\W)//;
                    $l_v{'enum_var'}=~s/(\W$)//;
                
                                      
                    for(split(/,/,$l_v{'enum_var'})){
                                                      
                            $l_v{'name'}=$_;               # Capturing Real Name
                            $l_v{'name'}=~s/\W//g;                      # Replacing ' by null
                            
                            push(@enum_values,{'NAME'=>$l_v{'name'} });
                       }
                    
                
                   return \@enum_values;    		              
                    
                  
                }










1;

