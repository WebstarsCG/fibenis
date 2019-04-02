<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $F_SERIES	=	array(
				'title'	=>'Flat DB',
				
                                'table_name'    => 'demo',
				
				'key_id'        => 'id',
                                
                                'data'	=>   array(	'1' =>array( 'field_name'	=> 'Text',
                                                               
								    'field_id' 		=> 'text_flat',
								    
								    'type' 		=> 'text',
								    
								    'is_mandatory'	=>1,
								    
							       ),
						   
							'2' =>array( 'field_name'	=> 'Text area',
                                                               
								    'field_id' 		=> 'text_area',
								    
								    'type' 		=> 'textarea',
								    
								    'input_html'	=>'class="w_200"',
                                                               
							       ),
							
							
							'3' =>array( 'field_name'	=> 'Decimal',
                                                               
								    'field_id' 		=> 'decimal_flat',
								       
								    'type' 		=> 'text',
								    
								    'allow'     	=> 'd10[.]',
								    
								    'is_mandatory'	=>0,
								    
								    'input_html'	=>'class="w_60"',
                                                               
							       ),
							
							
							'4' =>array( 'field_name'		=> 'Image',
							                                                        
								    'field_id' 			=> 'image_flat',
								       
								    'type' 			=> 'file',
								       
								    'upload_type' 		=> 'image',
								    
								    'save_file_name_prefix'	=> 'inner_',
							    
								    'save_file_name_suffix'	=> '_outer',
							    
								    'allow_ext'   		=> array('jpg','jpeg','png'),
								    
								    'max_size'    		=> 1024,
							    
								    'location'    		=> 'doc/image/',         
								       
								    'is_mandatory'		=>0,
								       
								    'input_html'		=>'class="w_200"',
							                                                        
							       ),
							
							'5' =>array( 'field_name'=> 'Documents',
							                                                        
								    'field_id' => 'documents',
								       
								    'type' => 'file',
								       
								    'upload_type' => 'docs',
								    
								    'save_file_name_prefix'=> 'inner_',
							    
								    'save_file_name_suffix'=> '_outer',
							    
								    'allow_ext'   => array('pdf'),
								    
								    'max_size'    => 1024,
							    
								    'location'    => 'doc/doc/',         
								       
								    'is_mandatory'=>0,
								       
								    'input_html'=>'class="w_200"',
							                                                        
							       ),
							
						        '6' =>array( 'field_name'	=> 'Option single',
                                                               
								    'field_id' 		=> 'option_single',
								    
								    'type' 		=> 'option',
								    
								    'option_data'	=>$G->option_builder('entity','code,sn',' WHERE is_lib = 0 ORDER by sn ASC'),
								    
								    'is_mandatory'	=>0,
								    
								    'input_html'	=>'class="w_100"',
								    
								    'avoid_default_option' => 0,
                                                            
                                                               ),
							
							'7' =>array( 'field_name'	=> 'Option multiple',
                                                               
								    'field_id' 		=> 'option_multiple',
								    
								    'type' 		=> 'option',
								    
								    'is_list' 		=> 1,
								    
								    'option_data'	=>$G->option_builder('entity','code,sn',' WHERE is_lib = 0 ORDER by sn ASC'),
								    
								    'is_mandatory'	=>0,
								    
								    'input_html'   =>  ' class="w_100"  style="height:200px !important"  ',
                
								    
							    ),
							
							'8' =>array( 'field_name'	=> 'Fiben Table',
                                                               
								    'field_id' 		=> 'fiben_table',
								   
								    'is_fibenistable'   => 1,
									
								    'type'              => 'fibenistable',
								    
								    'is_index'		=>1,
								    
								    'colHeaders'=> array(array(
											    'column'    => 'A',
											    'width'     => '50',
											    'type'      => 'text',
                                                                                    ),
										    array(
											    'column'    => 'B',
											    'width'     => '50',
											    'type'      => 'text',
                                                                                    ),
										)
                                                            
                                                               ),
							
							'9' =>array( 'field_name'	=> 'Date',
                                                               
								    'field_id' 		=> 'date_flat',
								   
								    'type'	 	=> 'date',
							       
							       ),
							
							'10' =>array( 'field_name'	=> 'Range',
                                                               
								    'field_id' 		=> 'range_flat',
								   
								    'type' 		=> 'range',
								    
							    ),
							
							'11' => array( 'field_name'   	=> 'Toggle switch',
								
								    'field_id'     	=> 'toggle_switch',
								
								    'type'         	=> 'toggle',
						      
								    'is_round'      	=> 1,  		# toggle will be in round type, by default it will be square     
						      
								    'show_status_label' => 1, 	# show labels for on & off toggle status
						      
								    'on_label'      	=> 'On',  	# shows during on status
						      
								    'off_label'     	=> 'Off', 	# shows during off status
						      
								    'is_default_on' 	=> 1,     	# set on status by default 
							    ),
							
							 '12' =>array( 'field_name'	=> 'Auto-complete', 
                                                               
								    'field_id' 		=> 'autocomplete',
								   
								    'type' 		=> 'autocomplete',
								   
								    'remote_link' 	=> 'router.php?series=ax&action=demo__flat&token=FT_AUT', 
		   
                                                               ),
							 
							'13' => array( 'field_name'   => 'Left right',
				
								    'field_id' => 'left_right',
                                                               
                                                                   
                                                                    'type'         => 'list_left_right',
                
								    'option_data'  => $G->option_builder("demo","id,text_flat","order by text_flat ASC"),
                                                                    
                                                                    'input_html'   =>  ' class="w_200" rows="2"  style="height:200px !important"  ',
                
							    ),
							
							'14' =>array( 'field_name'	=> 'Text Editor', 
                                                               
								    'field_id' 		=> 'text_editor',
								   
								    'type' 		=> 'textarea_editor',
								    
								    'input_html'	=>'class="w_100"',
								    
							    ),
							
							'15' =>array( 'field_name'	=> 'Code Editor', 
                                                               
								    'field_id' 		=> 'code_editor',
								   
								    'type' 		=> 'code_editor',
								    
								    'input_html'	=>'class="w_100"',
								   
                                                            ),

					    ),
                                    
				
				'is_user_id'       => 'user_id',
				
				# Communication
				
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?dx=demo__flat', 'BACK_NAME'=>'Back'),
                                
				'flat_message'	=> 'Successfully Added',
				
				'show_query'  => 0 	#for debugging
				
                                
			);
	
?>