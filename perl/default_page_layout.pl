

$K_SERIES->{'page'} = {
                                
                                # paper format
                                
                                paper       =>{   paper_size   => 'A4',
                                                  orientation  => 'portrait'},
                                
                                # file out name
                                
                                file_name   => '',    
                            
                                
                                
                                form        => { file   => 'perl/BAS.pdf', # source file
                                                 page   => 1,
                                                 adjust => 1,
                                                 x      => 25,
                                                 y      =>545},
                            
                                font        => 'Times-Bold', 
                            
                                font_size   => 10,                         
                                line_height => 20,
                        
                                margin      => { top    =>100,
                                                 bottom =>90,
                                                 left   =>36,
                                                 right  =>25   },
                                
                                is_header_all  =>1
                            
                        }; # format
                         