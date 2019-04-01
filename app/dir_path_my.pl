#!/usr/bin/perl -w

    use strict;
    use warnings;
    use Data::Dumper;
    use DBI;
    use DBD::Pg;
    use Digest::MD5 qw(md5 md5_hex);
    use File::stat;
    use File::Spec;
    use File::Basename;
    use Path::Iterator::Rule;
    use CGI::Carp qw/fatalsToBrowser/;
    
    # page variable ##############################################################################################
    
    my $USER_ROLE_ID  = 2;
    my $SUPER_USER_ID = 2;
    
    ##############################################################################################
 
   # $|=1;

    print "Content-type:text/html\n\n";
    
    my $rule = Path::Iterator::Rule->new; # match anything
    
    my $lv;
    
    my $file_counter = 1;
    
    my $def;
    
    # db
    
    my $global={"db_name" => "fibenis_base",
                "host"    => "localhost",
                "user"    => "root",
                "pass"    => ""                
                };
    
    #my $global={"db_name" => "fiben_wt20",
    #            "host"    => "db112b.pair.com",
    #            "user"    => "fiben_74",
    #            "pass"    => "enA4a35i"                
    #            };
    #
    
    # set
    
    $lv->{'DEBUG'} =1;
    
    $lv->{'counter'}->{'module'} = 1;
    $lv->{'counter'}->{'module_eng'} = 1;
    $lv->{'content'}             = '';
    $lv->{'def_permission'}           = [];
    $lv->{'update_permission_matrix'} = [];
    
    my $dbh     =  DBI->connect('DBI:mysql:dbname='.$global->{'db_name'}.';host='.$global->{'host'}.'',$global->{'user'},"$global->{'pass'}",{RaiseError=>1}) || &E_MESSAGE("DB error");
    
    # engine
    
    $lv->{'engine_id'}=$dbh->selectall_hashref("SELECT id,token FROM entity_child_base WHERE entity_code='EG' and token IN ('d','f','a','dx','fx','ax','t','tx')","2");
        
    # list interface
    
    my @DIR=('../lib/def/',
             'def'
             );
        
    # traverse each dir
    
    for my $dir(@DIR){
    
        for my $file ( $rule->all($dir) ) {
            
            print $file_counter.")".$file."<br>" unless(-d $file);
            
            ($lv->{'filename'},$lv->{'dirs'},$lv->{'suffix'}) = fileparse($file,(".php"));
            
            $lv->{'dirs'}=~s/$dir//ig;           
            $lv->{'dirs'}=~s/^\/|\/$//ig;
            $lv->{'dirs'}=~s/\//__/ig;
                        
            if ($lv->{'suffix'} eq ".php"){
                
                push(@{$def->{$lv->{'dirs'}}},$lv->{'filename'});            
            }
            
        } # end
    }
    
           
    $dbh->do("DELETE FROM entity_child_base WHERE entity_code='DF'");
    $dbh->do("DELETE FROM user_role_permission_matrix ");
    
    # each module def
    
    for my $def_name (sort keys(%{$def})){
       
        $lv->{'def_engine'} = [];
    
        $lv->{'content'}.='<hr>'.$lv->{'counter'}->{'module'}.")<b>".$def_name."</b><br>";
        
        $lv->{'temp_def_name'}=$def_name;
        $lv->{'temp_def_name'}=~s/\_/ /ig;
        $lv->{'temp_def_name'}=~s/(\s)(\w)/$1.ucfirst($2)/ieg;        
        $lv->{'temp_def_name'}= ucfirst($lv->{'temp_def_name'});
        
        # insert module fedinations
        
        $lv->{'insert_module'} = "INSERT INTO
                                            entity_child_base(entity_code,sn,ln,created_by,user_id)
                                        VALUES
                                            ('DF','$def_name','$lv->{temp_def_name}',$SUPER_USER_ID,$SUPER_USER_ID) ";
                                            
        $dbh->do($lv->{'insert_module'}) || die "Error";
        
        $lv->{'last_insert_id'} = $dbh->last_insert_id(undef,undef,'entity_child_base',undef);
                
        
                
        for my $engine (@{$def->{$def_name}}){
                        
            $lv->{parent_child_hash} =md5_hex($def_name.'__'.$lv->{'engine_id'}->{$engine}->{'token'});
            
            $lv->{'content'}.=$lv->{'counter'}->{'module_eng'}.")".$def_name."__".$engine."=".$lv->{parent_child_hash}."<br>";
            
            if ($lv->{'engine_id'}->{$engine}->{'id'}) {            
            
                $lv->{'temp_content'}="($lv->{'last_insert_id'},
                                              $lv->{'engine_id'}->{$engine}->{'id'},
                                              '$lv->{parent_child_hash}',
                                              $SUPER_USER_ID
                                              )";
                
                print $lv->{'insert_module_engine_query'} = "INSERT INTO
                                                             ecb_parent_child_matrix(ecb_parent_id,ecb_child_id,parent_child_hash,user_id)
                                                        VALUES
                                                            $lv->{'temp_content'}";
                                                
                $dbh->do($lv->{'insert_module_engine_query'});
                              
                push(@{$lv->{'def_permission'}},$dbh->last_insert_id(undef,undef,'ecb_parent_child_matrix',undef));
            
            } #end
                
            $lv->{'counter'}->{'module_eng'}++;
            
        } # each key        
        
        $lv->{'counter'}->{'module'}++;
        
    } # each module
    
    # into super admin
    
    $lv->{'update_permission'} = "UPDATE
                                        user_role_permission
                                    SET
                                        user_permission_ids='".join(',',@{$lv->{'def_permission'}})."'
                                    WHERE
                                        user_role_id=$USER_ROLE_ID";
                                        
    $dbh->do($lv->{'update_permission'});                                        

    
    # permission matrix
    
    for my $permission_matrix (@{$lv->{'def_permission'}}){
       
            push(@{$lv->{'update_permission_matrix'}},"($USER_ROLE_ID,$permission_matrix,$SUPER_USER_ID)");
        
    } # end
    
    $lv->{'user_permission_matrix_query'}=join(',',@{$lv->{'update_permission_matrix'}}); 
    
    $lv->{'permission_matrix_query'} = "INSERT INTO
                                            user_role_permission_matrix(user_role_id,user_permission_id,user_id)
                                        VALUES
                                             $lv->{'user_permission_matrix_query'}
                                        ";
    # empty super admin info
    
    $dbh->do("DELETE FROM user_role_permission_matrix WHERE user_role_id=$USER_ROLE_ID");
    
    $dbh->do($lv->{'permission_matrix_query'});
    
    print "<hr>".$lv->{'content'} if($lv->{'DEBUG'});
    
    print "Setup";
    