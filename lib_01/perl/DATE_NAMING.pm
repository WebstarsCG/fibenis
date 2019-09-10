#!/usr/bin/perl -w 

    package DATE_NAMING;
    
        sub date_naming(){
            
                    my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
            
                    ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
            
                    $year = 1900 + $yearOffset;
            
                    my $theTime = "$months[$month]_$dayOfMonth";
            
                    my $p_year      =   '_'.$year.'_';
            
                    my $p_hour      =   $hour.'_';
            
                    my $p_minute    =   $minute.'_';
                    
                    my $naming  =   {   theTime =>  $theTime,
                                     
                                        p_year  =>  $p_year, 
                                        
                                        p_hour  =>  $p_hour,
                                        
                                        p_minute=>  $p_minute,
                                        
                                        second =>  $second, 
                                        
                                   };
                    
                    return $naming;
                    
        }
    1;