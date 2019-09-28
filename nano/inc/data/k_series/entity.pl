#!/usr/bin/perl -w 
            
    # variable
    
                my $PV;
                
                
    # settings
    
                $PV->{'current_time'} = time;
                
                $PV->{'file_name'}    = "csv/sample_pdf_$PV->{current_time}.pdf";
                
                $PV->{'empty_dash'}   = '-';
                
    # page settings
                            
                do "perl/default_page_layout.pl";
                
    # file name
    
                $K_SERIES->{'page'}->{'file_name'} = $PV->{'file_name'};
                
    
    # header data
                
                $K_SERIES->{'header'}  = {
                                                   
                    0=>{
                        
                            left_xaxis  =>250,   # print start x position                         
                            line_height =>25,    # line height of the row
                            
                            
                                
                                # column definition
                                                            
                                header      =>{
                                                0=>{font       =>'Helvetica-Bold',
                                                    font_size  =>12,
                                                                                              
                                                    
                                                } # column
                                },
                                
                                data=>[
                                       ['Entity Details']
                                ],
                                
                    },
                    
                   
                }; # end of data


    # body data
                
    $K_SERIES->{'data'} ={
                          
                          
                          
            0=>{
                                line_height =>  12,   
                                
                                line_data    => 1,
                                
                                
                                # title format
                                title_text_font             => 'Helvetica-Bold',                    
                                title_text_font_size        => 10,
                                
                                # data format
                                data_text_font              => 'Tahoma',                    
                                data_text_font_size         =>  9,                    
                                data_left_margin            =>  0,
                                
                                # format definition for 3 columns
                                
                                header=>{
                                 
                                                0=>{
                                                    #font       => 'Helvetica',
                                                    
                                                    h_width    => 210,
                                                    d_width    => 210,
                                                    title      => 'Code1'
                                                    
                                                },
                                                
                                                1=>{
                                                   # font       => 'Helvetica',
                                                    
                                                    h_width    => 300,
                                                    d_width    => 300,
                                                    offset     => 90, 
                                                    align      => 'left',
                                                    title      => 'Name'
                                                },
                                                    
                                }, # end of header
                                
                                # data for 2 columns
                                    
                                data=> [ 
                                        ["Title\nTest:","Data"],
                                        ["Title1","Data1"],
                                ],                                        
            },
    
            
        };   
      
      
       #Array of Array fetch
       $K_SERIES->{'data'}->{0}->{'data'}=$K_SERIES->{'req'}->{'d'}->selectall_arrayref({'table'=>'entity_child_base',
                                                                                         'columns'=>['token',
                                                                                                     'sn'                                                                                   
                                                                                                     ],
                                                                                                     
                                                                                            'where' => "",
                                                                                                     
                                                                                          'order' => 'id' 
                                                                       
                                                                       });
       
       # hash ref        
        $PV->{'master'} = $K_SERIES->{'req'}->{'d'}->selectrow_hashref({'table'=>'entity_key_value',
                                                                                         'columns'=>['entity_value as title'                                                                         
                                                                                                     ],
                                                                                          'where' => qq/ entity_code='MP' AND entity_key='title' / 
                                                                       });
        
        print Dumper($K_SERIES->{'data'}->{0}->{'data'});
        
        # set row      
        $K_SERIES->{'header'}->{0}->{'data'}->[0]->[0]=$PV->{'master'}->{'title'};
        
        
        