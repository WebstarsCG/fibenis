#!/usr/bin/perl -w


        # Package for Getting masters list

        package Dbh;
        
        
        BEGIN{
                 #   do "begin.pl";  
        }
        
        # Data fetch from external file
        
        use DB;
        
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
            





1;

