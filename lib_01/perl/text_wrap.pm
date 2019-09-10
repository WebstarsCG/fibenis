#!/usr/bin/perl -w
    
    # package:-
    
        package text_wrap;
    
    # System module:-
    
        use strict;
        
        use Text::Wrap;
        
        use Carp;
     
        # Function of wrapping:-
    
        # 0-> text
        # 1-> Width
        # 2-> nostrict
    
        sub der_wrap {
        
            
            # Declaring Variables:-
            
                my %v;
                
                $v{text}=$_[0];
                
                $v{width}=$_[1];
                
                $v{nostrict}=$_[2];
        
                Carp::shortmess('Missing required text or width parameter.') if (!defined($v{text}) || !defined($v{width}));
            
                $v{result}='';
            
                for (split(/\n/,$v{text})) {
        
                    $v{result}= _wrap($_,$v{width},$v{nostrict});
                    
                }
                
                               
                return  $v{result};
            
        }
        
    # Function of inner Wrapping:-
    
        # 0-> text
        # 1-> Width
        # 2-> nostrict

        sub _wrap {
            
        # Declaring Variables:-
            
            my %v;
                
            $v{text}=$_[0];
                
            $v{width}=$_[1];
                
            $v{nostrict}=$_[2];
                
            my @result;
            
            $v{line}='';
            
            $v{nostrict}=defined($v{nostrict}) && $v{nostrict} == 1 ? 1 : 0;
            
            for (split(/ /,$v{text})){
                
                $v{spc} = $v{line} eq '' ? 0 : 1;
              
                $v{len} = length($v{line});
              
                $v{newlen} = $v{len} + $v{spc} + length($_);
              
                if ($v{len} == 0 && $v{newlen} > $v{width}) {
                
                    push @result, $v{nostrict} == 1 ? $_ : substr($_,0,$v{width}); # kutt ned bredden
                
                    $v{line}='';
                
                }elsif ($v{len} != 0 && $v{newlen} > $v{width}) {
                
                    push @result, $v{nostrict} == 1 ? $v{line} : substr($v{line},0,$v{width});
                
                    $v{line} = $_;
                
                }else{
                
                    $v{line} .= (' ' x $v{spc}).$_;
                
                }
              
            }
        
        push @result, $v{nostrict} eq 1 ? $v{line} : substr($v{line},0,$v{width}) if $v{line} ne '';
        
        return \@result;
        
    }
        

1;

