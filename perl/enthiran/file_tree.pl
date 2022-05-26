#!/usr/bin/perl -w

    use strict;
    use warnings;
    use Data::Dumper;

    use File::stat;
    use File::Spec;
    use File::Basename;
    use Path::Iterator::Rule;
    use CGI::Carp qw/fatalsToBrowser/;
  
 
   # $|=1;

    print "Content-type:text/html\n\n";
    
    my $rule = Path::Iterator::Rule->new; # match anything
    
    my $lv;
    
    my $file_counter = 1;
    
    my $def;
    
    # db
    
  
    # set
    
    $lv->{'DEBUG'} =1;
    
    $lv->{'counter'}->{'module'}     = 1;
    $lv->{'counter'}->{'module_eng'} = 1;
    $lv->{'content'}                 = '';
 
    # list interface
    
    my @DIR=('../lib/v_01/def');
        
 
    # traverse each dir
    
    for my $dir(@DIR){
    
        for my $file ( $rule->all($dir) ) {
            
            if(-d $file){
                
                   ($lv->{'filename'},$lv->{'dirs'},$lv->{'suffix'}) = fileparse($file,(".php"));            
                    $lv->{'dirs'}=~s/$dir//ig;           
                    $lv->{'dirs'}=~s/^\/|\/$//ig;
                    $lv->{'dirs'}=~s/\//__/ig;
                    
                    push(@{$def->{$lv->{'dirs'}}},$lv->{'filename'});            
                
            }else{
                
                
                    $lv->{'dirs'}= $file;   
                    $lv->{'dirs'}=~s/$dir//ig;           
                    $lv->{'dirs'}=~s/^\/|\/$//ig;
                    $lv->{'dirs'}=~s/\//__/ig;                                        
                    push(@{$def->{$lv->{'dirs'}}},'<b>'.$file.'</b>');   
                
            }
            
            $file_counter++;
            
        } # end
    }
    
    
    # each module def
    
    for my $def_name (sort keys(%{$def})){
       
        $lv->{'def_engine'} = [];
    
        $lv->{'content'}.=$lv->{'counter'}->{'module'}.") ".$def_name."<br>";
        
        $lv->{'counter'}->{'module'}++;
    }
    
    
    print "<hr>".$lv->{'content'} if($lv->{'DEBUG'});
    
    print "Setup";
    