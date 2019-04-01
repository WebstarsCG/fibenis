#!/usr/bin/perl -w                               
    
    
    # Kangiten
    
        package KG;                                                     ;
    
    # System Module
    
        #use strict;
    
        use PDF::Reuse;
        
        use PDF::Reuse::Util;
        
    # User Module
    
        use text_wrap;
            
    # Declaring Global variables
    
        my $PAGE={  A4=>{   portrait=>{width=>596,
                                      height=>842,
                                      top=>162
                                      },
                          
                                landscape=>{width=>842,
                                      height=>596,
                                      top=>162}},
                        
                    A3=>{   portrait=>{width=>842,
                                     height=>1191},
                          
                                landscape=>{width=>1191,
                                      height=>842}},
                        
                    Letter=>{portrait=>{width=>612,
                                     height=>792},
                          
                                landscape=>{width=>792,
                                      height=>612}}
                        
                     };
        
       # my $inr_symbol = prTTFont('../fonts/Rupee.ttf');

        
        my $PAGE_NO=1;
        
    # Creating PDF File Function
    
        # 0->Page_setup
        # 1->title_hash
        # 2->data_info
        
        # c_v->creating variable
        # ar_ref->Array reference
        
        sub create(){
            
            my %c_v;
           
        # Receiving parameter
            
            $c_v{page}=$_[0];
                
            $c_v{head}=$_[1];
                
            $c_v{data}=$_[2];
            
        # Create the pdf file
        
            prFile($c_v{page}->{file_name});
                
        # get  the tempelate file
            
            prForm($c_v{page}->{form}->{file},$c_v{page}->{form}->{page});
            
            $c_v{y_data}=&header_text($c_v{head},$c_v{page});
            
        # get the size of width & height
            
            ($c_v{width},$c_v{height},$c_v{top})=&checking($c_v{page});
            
            $c_v{x}=$c_v{page}->{margin}->{left};
                
            $c_v{y}=$c_v{height}-$c_v{page}->{margin}->{top};
            
            $c_v{page_data_counter} = 0;
            
            $c_v{page_data_rows}    = scalar(keys %{$c_v{data}});
            
            for(0..scalar(keys %{$c_v{data}})-1){
                    
                $c_v{st_var}=$_;
                
                $c_v{page_data_counter}++;
                
                $c_v{'current_row'} = $c_v{data}->{$c_v{st_var}};
                    
                $c_v{y_data}=&header($c_v{page},$c_v{data}->{$c_v{st_var}},$c_v{y_data});
                
                $c_v{y_data} -=$c_v{data}->{$c_v{st_var}}->{line_height}||$c_v{page}->{line_height};
                    
        # call the header function
            
                $c_v{x}=$c_v{data}->{$c_v{st_var}}->{left_xaxis}||$c_v{page}->{margin}->{left};
            
                $c_v{len}=scalar(@{$c_v{data}->{$c_v{st_var}}->{data}})-1;
                        
        # Min row check
        
                $c_v{'min_row'} = $c_v{data}->{$c_v{st_var}}->{min_row};
            
                if($c_v{'min_row'}){
                   
                   $c_v{'current_row_need'} = (($c_v{len}+1)*$c_v{'min_row'});
                   
                   if(($c_v{y_data}-$c_v{'current_row_need'}) <= ($c_v{'page'}->{'margin'}->{'bottom'})){
                    
                        prPage();                                           # create new page
                        
                        $c_v{st_var}=$_;
                                      
                        $c_v{page}->{form}->{'file'} = ($c_v{page}->{form}->{'inner'})?$c_v{page}->{form}->{'inner'}:$c_v{page}->{form}->{file};              
                                      
                        prForm($c_v{page}->{form}->{file},$c_v{page}->{form}->{page});
                        
                        $c_v{y_data}=($c_v{height}-$c_v{top});
                    
                        $c_v{y_data}=&header_text($c_v{head},$c_v{page});    
                   }
                
                } # end
                
                
                
        
                #get the inner arrays
                 $c_v{row_counter}=0; 
            
                for(0..$c_v{len}){
                  
        # get the starting point of xaxis of data information
                
                    $c_v{ar_ref}=$c_v{data}->{$c_v{st_var}}->{data}->[$_];              # get the inner array reference at data_info
                    
                    $c_v{row_counter}++; # row counter
                    
                    $c_v{data_rows} = scalar(@{$c_v{data}->{$c_v{st_var}}->{data}});
                
                    my @data_in;
                    
                    
                    if(ref($c_v{ar_ref}) ne 'HASH'){    # simple
                        
                        @data_in = @{$c_v{ar_ref}};
                        
                        $c_v{'font'} = 'data_text_font';
                        
                        
                    }else{                              # in data
                        
                        @data_in = @{$c_v{ar_ref}->{'data'}};
                        
                        $c_v{'font'} = $c_v{ar_ref}->{'font'};
                        
                    } # end
                
                                
                    $c_v{initial}=0;                         # initializing parameter
                    
                    $c_v{store_2}=0;
                    
                    $c_v{y_data}-=5;
                    
                   
                    
                    $c_v{x} = $c_v{x}+($c_v{data}->{$c_v{st_var}}->{'data_left_margin'} || 0);
                                                                                
                    
                    # check the detail for next page
                    
                    if ( (scalar(@data_in)==2) && ($c_v{y_data}<($c_v{page}->{'margin'}->{'bottom'} || 100)) ){          
                    
                        prPage();                                           # create new page
                                      
                        $c_v{page}->{form}->{'file'} = ($c_v{page}->{form}->{'inner'})?$c_v{page}->{form}->{'inner'}:$c_v{page}->{form}->{file};              
                                      
                        prForm($c_v{page}->{form}->{file},$c_v{page}->{form}->{page});
                        
                        $c_v{y_data}=($c_v{height}-$c_v{top});
                    }    
                    
        # get the inner array datas
            
                    for(@data_in){
                        
                        
                    
                        # Get the text which to be present in innner array of data_info
        
                        prFont($c_v{data}->{$c_v{st_var}}->{$c_v{'font'}}||$c_v{page}->{font});
                
                        prFontSize($c_v{data}->{$c_v{st_var}}->{data_text_font_size}||$c_v{page}->{font_size});
                        
                        $c_v{data_value}=$c_v{data}->{$c_v{st_var}}->{header}->{$c_v{initial}};                        
                        
                        $c_v{store_2}=&text_wrap($c_v{x},$_,$c_v{store_2},$c_v{y_data},$c_v{data_value},$c_v{page});
                        
                       # $c_v{store_2}=&text_wrap($c_v{x},"RC:".$c_v{row_counter}.'-DR'.$c_v{data_rows},$c_v{store_2},$c_v{y_data},$c_v{data_value},$c_v{page});                        
                                                
                        $c_v{x}+=$c_v{data}->{$c_v{st_var}}->{header}->{$c_v{initial}}->{d_width};                        
                        
                        ++$c_v{initial};                        
                        
                    }   # end of for(@data_in)
                    
                    
                    if($c_v{store_2} eq 0){
                        
                        $c_v{store_2}=$c_v{y_data}-(($c_v{data}->{$c_v{st_var}}->{line_height})?$c_v{data}->{$c_v{st_var}}->{line_height}:20);
                    
                    }
                    
                    $c_v{y_data}= $c_v{store_2};     # get the next line(Yaxis) of data
                    
                    $c_v{x}=$c_v{data}->{$c_v{st_var}}->{left_xaxis}||$c_v{page}->{margin}->{left};
                    
                    $c_v{rt_xaxis}=$c_v{data}->{$c_v{st_var}}->{left_xaxis}||570;
                    
                    if($c_v{data}->{$c_v{st_var}}->{line_data} eq 1){
                    
                        prAdd("q $c_v{x} $c_v{y_data} m $c_v{rt_xaxis} $c_v{y_data} l S Q");
                        
                        $c_v{y_data}-=$c_v{data}->{$c_v{st_var}}->{line_height}||20;
                        
                    }
                    
                    # image addition
                    
                    if($c_v{data}->{$c_v{st_var}}->{is_img}){
                    
                        prImage({ file   => $c_v{data}->{$c_v{st_var}}->{src},
                                  'x'    => $c_v{x},
                                  'y'    => $c_v{y_data},
                                  'size' => (($c_v{'current_row'}->{'scale'})?$c_v{'current_row'}->{'scale'}:1)
                                });
                    }
                    
        # check if data would cross the bottom
                
                    if (($c_v{y_data}) < $c_v{page}->{margin}->{bottom}){
                        
                            # if data exists
                        
                            if (  ($c_v{page_data_counter} <  $c_v{page_data_rows}) ||
                                  ($c_v{row_counter} != $c_v{data_rows})
                            ){
                                            
                                    prPage(); # create new page
                                                  
                                    $c_v{page}->{form}->{'file'} = ($c_v{page}->{form}->{'inner'})?$c_v{page}->{form}->{'inner'}:$c_v{page}->{form}->{file};              
                                                  
                                    prForm($c_v{page}->{form}->{file},$c_v{page}->{form}->{page});
                                                     
                            # set the start line(Yaxis) of next page
                
                                    $c_v{y_data}=$c_v{height}-($c_v{page}->{margin}->{top});
                                    
                                    # Header function added for data case
                                    
                                    $c_v{y_data}=&header_text($c_v{head},$c_v{page}) if($c_v{page}->{'is_header_all'});
                            
                            } # data exisits        
                                
                                # build row header, if data exisits
                                
                                if($c_v{row_counter} < $c_v{data_rows} ){
                                
                                    
                                    $c_v{y_data}=&header($c_v{page},$c_v{data}->{$c_v{st_var}},$c_v{y_data});
                                    $c_v{y_data} = $c_v{y_data}-15;
                                    
                                
                                } # check header write
                        
                       
                        
                    } # end of if loop
                    
                } # end of for loop
                         
            } # end of for loop
            
            prEnd();
                
        } # end of creating function
        
   
    
    # Creating Title_data Function
    
        # 0->Page_setup
        # 1->title_hash
        
        # h_v-> Header Variable
        # ul-> Upper Line
        # ll-> Lower Line
        # rt_xaxis-> right xaxis
        
        sub header(){
            
            my %h_v;
            
    # Receiving parameter
            
            $h_v{y_data}=$_[2];
                
            $h_v{page}=$_[0];           
                
            $h_v{data}=$_[1];
                
    # get the size of width & height     
            
            ($h_v{width},$h_v{height})=&checking($h_v{page});
                       
    # Set the page width
                    
            prMbox(0,0,$h_v{width},$h_v{height});
            
            if($h_v{data}->{header}->{0}->{title} ){
                    
    # points of axis of header-text
                
                $h_v{x}=$h_v{data}->{left_xaxis}||$h_v{page}->{margin}->{left};       
                        
                $h_v{y}=$h_v{y_data};   
                        
                $h_v{ul}=$h_v{y};        # upper line yaxis
                  
                $h_v{rt_xaxis}=$h_v{data}->{right_xaxis}||($h_v{width})-($h_v{page}->{margin}->{right});     # horizontal line of right xaxis
                
                $h_v{y_data}-=$h_v{data}->{line_height};
                
    # Draw the horizontal line
               
                prAdd("q $h_v{x} $h_v{ul} m $h_v{rt_xaxis} $h_v{ul} l S Q");        # draw upper horizontal line
                
    # length of title_hash
                
                $h_v{len}=scalar(keys %{$h_v{data}->{header}})-1;
            
    # Font Details
                
            # Text of title_hash
            
                $h_v{store_2}=0;
                
                $h_v{y_data}-=5;
                           
                for(0..$h_v{len}){
                    
                    prFont($h_v{data}->{title_text_font}||$h_v{page}->{font});
                    
                    prFontSize($h_v{data}->{title_text_font_size}||$h_v{page}->{font_size});
                                
                    $h_v{string}=$h_v{data}->{header}->{$_}->{title}||' ';
                    
                    $h_v{data_value}=$h_v{data}->{header}->{$_};
                    
                    $h_v{align}='left';
                    
                    $h_v{store_2}=&text_wrap($h_v{x},$h_v{string},$h_v{store_2},$h_v{y_data},$h_v{data_value},$h_v{page},$h_v{align});
                    
                    $h_v{x}+=$h_v{data}->{header}->{$_}->{h_width};
                    
                }   # end of for(@data_in)
                
                if($h_v{store_2} eq 0){
                        
                        $h_v{store_2}=$h_v{y_data}-(($h_v{data}->{line_height})?$h_v{data}->{line_height}:20);
                    
                    }
                
                $h_v{y_data}= $h_v{store_2};     # get the next line(Yaxis) of data
                             
                $h_v{x}=$h_v{data}->{left_xaxis}||$h_v{page}->{margin}->{left};
                                    
                prAdd("q $h_v{x} $h_v{y_data} m $h_v{rt_xaxis} $h_v{y_data} l S Q"); 
             
            }else{
               
               return $h_v{y_data};
                
            }
           
            return $h_v{y_data};
            
        } # end of header function
    
    
    
    # Function of Checking Width& height
    
        # 0 -> Page_setup
        
        sub checking(){
            
            my %ch_v;
            
            $ch_v{page}=$_[0];
            
            if($ch_v{page}->{paper}){
                
        # get the original paper_size & orientation
                
                $ch_v{paper}=$ch_v{page}->{paper}->{paper_size};
                
                $ch_v{orient}=$ch_v{page}->{paper}->{orientation};
                            
                if($ch_v{page}->{paper}->{paper_size}){
                    
                    if($ch_v{page}->{paper}->{orientation}){
                        
        # get the width & height base on given paper & orientation size
                        
                        $ch_v{width}=$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{width};
                            
                        $ch_v{height}=$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{height};
                    
                    }else{
                        
        # get the given width & height
                        
                        $ch_v{width}=$ch_v{page}->{width};
                            
                        $ch_v{height}=$ch_v{page}->{height};
                        
                    }
                    
        # set orientation is portrait
                        
                    $ch_v{orient}='portrait';
                        
                    $ch_v{width}=$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{width};
                        
                    $ch_v{height}=$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{height};
                    
                }else{
                        
        # get the given width & height
                        
                    $ch_v{width}=$ch_v{page}->{width};
                            
                    $ch_v{height}=$ch_v{page}->{height};
                        
                }
                
        # set orientation is portrait & paper_size is A4
                
                $ch_v{paper}='A4';
                    
                $ch_v{orient}='portrait';
                    
                $ch_v{width}=$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{width};
                            
                $ch_v{height}=$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{height};
                
            }else{
                        
        # get the given width & height
                        
                $ch_v{width}=$ch_v{page}->{width};
                            
                $ch_v{height}=$ch_v{page}->{height};
                        
            }
            
        # return the value of width & height
            
            return($ch_v{width},$ch_v{height},$PAGE->{$ch_v{paper}}->{$ch_v{orient}}->{top});
            
        } # End of paper size checking Function
        

    
    # Function of text modifying:-
    
        sub text_wrap(){
            
            my %tm_v;
            
            $tm_v{x}=$_[0];
            
            $tm_v{data}=$_[1];
            
            $tm_v{store}=$_[2];
            
            $tm_v{y_data}=$_[3];
            
            $tm_v{data_value}=$_[4];
            
            $tm_v{page}=$_[5];
                       
            $tm_v{align}=$_[6] || $tm_v{data_value}->{align};
            
            $tm_v{offset} = $tm_v{data_value}->{offset}||100;
            
            $tm_v{font} = $tm_v{data_value}->{font};
            
            $tm_v{line_height} = $tm_v{data_value}->{line_height} || 11;
            
            $tm_v{space}=0;
            
            $tm_v{res}=&text_wrap::der_wrap($tm_v{data},$tm_v{offset},1);
            
            $tm_v{length}=$#{$tm_v{res}};
            
            $tm_v{y_axis}=$tm_v{y_data};
    
            for(0..$tm_v{length}){
                
                prFont($tm_v{data_value}->{font}) if($tm_v{data_value}->{font});
                
                prFontSize($tm_v{data_value}->{font_size}) if($tm_v{data_value}->{font_size});
        
                prText($tm_v{x},$tm_v{y_axis},$tm_v{res}->[$_],$tm_v{align});
                      
                $tm_v{y_axis}=$tm_v{y_axis}-$tm_v{line_height};
                
            }
            
            $tm_v{store_1}=$tm_v{y_axis};
                                                                        
            if($tm_v{store_1} < $tm_v{store} || $tm_v{store} == 0){
                            
                $tm_v{store}=$tm_v{store_1};
                            
            }
                      
            $tm_v{store_1}=0;
           
            return $tm_v{store};
            
        }
        
    # Function of Heading:-
    
        sub header_text(){
            
            my %ht_v;
            
            $ht_v{data}=$_[0];
            
            $ht_v{page}=$_[1];
            
            ($ht_v{width},$ht_v{height})=&checking($ht_v{page});
            
            $ht_v{x}=$ht_v{page}->{margin}->{left};
                
            $ht_v{y}=$ht_v{height}-$ht_v{page}->{margin}->{top};
            
            for(0..scalar(keys %{$ht_v{data}})-1){
                    
                $ht_v{st_var}=$_;
                   
                $ht_v{x}=$ht_v{data}->{$ht_v{st_var}}->{left_xaxis}||$ht_v{page}->{margin}->{left};
            
                $ht_v{len}=scalar(@{$ht_v{data}->{$ht_v{st_var}}->{data}})-1;
                        
        #get the inner arrays
            
                for(0..$ht_v{len}){
                    
                    $ht_v{x}=$ht_v{data}->{$ht_v{st_var}}->{left_xaxis}||$ht_v{page}->{margin}->{left};
                    
        # get the starting point of xaxis of data information
                
                    $ht_v{ar_ref}=$ht_v{data}->{$ht_v{st_var}}->{data}->[$_];              # get the inner array reference at data_info
                
                    my @data_in=@{$ht_v{ar_ref}};
                                
                    $ht_v{initial}=0;                         # initializing parameter
                    
                    $ht_v{store_2}=0;
                    
        # get the inner array datas
            
                    for(@data_in){
                    
        # Get the text which to be present in innner array of data_info
        
                        prFont($ht_v{data}->{$ht_v{st_var}}->{header}->{$ht_v{initial}}->{font}||$ht_v{page}->{font});
                
                        prFontSize($ht_v{data}->{$ht_v{st_var}}->{header}->{$ht_v{initial}}->{font_size}||$ht_v{page}->{font_size});
                                       
                       # prText($ht_v{x},$ht_v{y},$_);
                        
                        $ht_v{store_2}=&text_wrap($ht_v{x},$_,$ht_v{store_2},$ht_v{y},
                                                  $ht_v{data}->{$ht_v{st_var}}->{header}->{$ht_v{initial}},
                                                  $ht_v{page});
                        
                        $ht_v{x}+=$ht_v{data}->{$ht_v{st_var}}->{header}->{$ht_v{initial}}->{d_width};      # width size of text of data
                    
                        ++$ht_v{initial};
                        
                    }   # end of for(@data_in)
                    
                    # text wrap
                    if($ht_v{store_2} eq 0){
                        
                        $ht_v{store_2}=$ht_v{y}-(($ht_v{data}->{$ht_v{st_var}}->{line_height})?$ht_v{data}->{$ht_v{st_var}}->{line_height}:20);                    
                    }
                    
                    #
                    $ht_v{y}-=$ht_v{data}->{$ht_v{st_var}}->{line_height}||$ht_v{page}->{line_height};     # get the next line(Yaxis) of data
                    
                }
                            
            } # end of for loop
            
            return $ht_v{y};
            
        }

    #Edit Log
    # $tm_v{y_axis}=$tm_v{y_axis}-10 : $tm_v{y_axis}=$tm_v{y_axis}-15;
    # Page margin hard coded 

1;