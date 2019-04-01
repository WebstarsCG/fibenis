<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $F_SERIES	=	array(
				'title'	=>'EAV DB',
				
                                'table_name'    => 'entity_child',
				
				'key_id'        => 'id',
				
				'default_fields'    => array('entity_code' => "'DE'"),
				
                                'data'	=>   array(	'1' =>array( 'field_name'	=> 'Text',
                                                               
								    'field_id' 		=> 'exa_value',
								    
								    'type' 		=> 'text',
								    
								    'child_table'         => 'exav_addon_varchar', 	// child table
							       
								    'parent_field_id'     => 'parent_id',    		// parent field
										       
								    'child_attr_field_id' => 'exa_token',   		// attribute code field
							       
								    'child_attr_code'     => 'DETX',           		// attribute code
							       
								    'is_mandatory'	=>1,
								    
							       ),
						   
							'2' =>array( 'field_name'	=> 'Text area',
                                                               
								    'field_id' 		=> 'exa_value',
								    
								    'type' 		=> 'textarea',
								    
								    'child_table'         => 'exav_addon_text', 	
							       
								    'parent_field_id'     => 'parent_id',    		
										       
								    'child_attr_field_id' => 'exa_token',   		
							       
								    'child_attr_code'     => 'DETA',           		
								    
								    'input_html'	=>'class="w_200"',
                                                               
							       ),
							
							
							'3' =>array( 'field_name'	=> 'Decimal',
                                                               
								    'field_id' 		=> 'exa_value',
								       
								    'type' 		=> 'text',
								    
								    'allow'     	=> 'd10[.]',
								    
								    'child_table'         => 'exav_addon_decimal', 	
							       
								    'parent_field_id'     => 'parent_id',    		
										       
								    'child_attr_field_id' => 'exa_token',   		
							       
								    'child_attr_code'     => 'DEDC',
								    
								    'is_mandatory'	=>0,
								    
								    'input_html'	=>'class="w_60"',
                                                               
							       ),
							
							
							'4' =>array( 'field_name'		=> 'Image',
							                                                        
								    'field_id' 			=> 'exa_value',
								       
								    'type' 			=> 'file',
								       
								    'upload_type' 		=> 'image',
								    
								    'save_file_name_prefix'	=> 'inner_',
							    
								    'save_file_name_suffix'	=> '_outer',
							    
								    'allow_ext'   		=> array('jpg','jpeg','png'),
								    
								    'max_size'    		=> 1024,
							    
								    'location'    		=> 'doc/image/',
								    
								    'child_table'         	=> 'exav_addon_varchar', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEIM',
								       
								    'is_mandatory'		=>0,
								       
								    'input_html'		=>'class="w_200"',
							                                                        
							       ),
							
							'5' =>array( 'field_name'=> 'Documents',
							                                                        
								    'field_id' => 'exa_value',
								       
								    'type' => 'file',
								       
								    'upload_type' => 'docs',
								    
								    'save_file_name_prefix'=> 'inner_',
							    
								    'save_file_name_suffix'=> '_outer',
							    
								    'allow_ext'   => array('pdf'),
								    
								    'max_size'    => 1024,
							    
								    'location'    => 'doc/doc/',
								    
								    'child_table'         	=> 'exav_addon_varchar', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEDU',
								       
								    'is_mandatory'		=>0,
								       
								    'is_mandatory'=>0,
								       
								    'input_html'=>'class="w_200"',
							                                                        
							       ),
							
						        '6' =>array( 'field_name'	=> 'Option single',
                                                               
								    'field_id' 		=> 'exa_value_token',
								    
								    'type' 		=> 'option',
								    
								    'option_data'	=>$G->option_builder('entity_child_base','token,sn',
													     'WHERE entity_code IN (SELECT code FROM entity WHERE is_lib = 0)
													      ORDER by sn ASC'),
								    
								    'is_mandatory'	=>0,
								    
								    'input_html'	=>'class="w_100"',
								    
								    'child_table'         	=> 'exav_addon_exa_token', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEOS',
								       
								    'is_mandatory'		=>0,
								    
								    'avoid_default_option' => 0,
                                                            
                                                               ),
							
							'7' =>array( 'field_name'	=> 'Option multiple',
                                                               
								    'field_id' 		=> 'exa_value',
								    
								    'type' 		=> 'option',
								    
								    'is_list' 		=> 1,
								    
								    'option_data'  => $G->option_builder("entity","code,sn","WHERE is_lib = 0 order by sn ASC"),
                                                                    
								    'is_mandatory'	=>0,
								    
								    'input_html'	=>'class="w_100"',
								    
								    'child_table'         	=> 'exav_addon_text', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEOM',
								    
								    'is_mandatory'	=>0,
								    
								    'input_html'   =>  ' class="w_100"  style="height:200px !important"  ',
                
							    ),
							
							'8' =>array( 'field_name'	=> 'Fiben Table',
                                                               
								    'field_id' 		=> 'exa_value',
								   
								    'is_fibenistable'   => 1,
									
								    'type'              => 'fibenistable',
								    
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
										),
								    
								    'child_table'         	=> 'exav_addon_text', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEFT',
                                                            
                                                               ),
							
							'9' =>array( 'field_name'	=> 'Date',
                                                               
								    'field_id' 		=> 'exa_value',
								   
								    'type'	 	=> 'date',
								    
								    'child_table'         	=> 'exav_addon_date', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEDT',
							       
							       ),
							
							'10' =>array( 'field_name'	=> 'Range',
                                                               
								    'field_id' 		=> 'exa_value',
								   
								    'type' 		=> 'range',
								    
								    'child_table'         	=> 'exav_addon_varchar', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DERG',
							    
							    ),
							
							'11' => array( 'field_name'   	=> 'Toggle switch',
								
								    'field_id'     	=> 'exa_value',
								
								    'type'         	=> 'toggle',
						      
								    'is_round'      	=> 1,  		     
						      
								    'show_status_label' => 1, 	
						      
								    'on_label'      	=> 'On',  	
						      
								    'off_label'     	=> 'Off', 	
						      
								    'is_default_on' 	=> 1,
								    
								    'child_table'         	=> 'exav_addon_num', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DETS',
							    
								    
							    ),
							
							 '12' =>array( 'field_name'	=> 'Auto-complete', 
                                                               
								    'field_id' 		=> 'exa_value',
								   
								    'type' 		=> 'autocomplete',
								   
								    'remote_link' 	=> 'router.php?series=ax&action=demo__eav&token=FT_AUTT',
								    
								    'child_table'         	=> 'exav_addon_varchar', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'exa_token',   		
							       
								    'child_attr_code'     	=> 'DEAU',
		   
                                                               ),
							 
							'13' => array( 'field_name'   => 'Left right',
				
								    'field_id' => 'exa_value',
                                                               
                                                                    'type' => 'option',
                                                                   
                                                                    'child_table'         => 'exav_addon_text', // child table
                                                                   
                                                                    'parent_field_id'     => 'parent_id',    // parent field
                                                                                           
                                                                    'child_attr_field_id' => 'exa_token',   // attribute code field
                                                                   
                                                                    'child_attr_code'     => 'DELR',           // attribute code
                                                                   
								    'type'         => 'list_left_right',
                
								    'option_data'  => $G->option_builder("entity","code,sn","WHERE is_lib = 0 order by sn ASC"),
                                                                    
                                                                    'input_html'   =>  ' class="w_200" rows="2"  style="height:200px !important"  ',

							    ),
							
							'14' =>array( 'field_name'	=> 'Text Editor', 
                                                               
								    'field_id' 		=> 'exa_value',
								   
								    'type' 		=> 'textarea_editor',
								    
								    'child_table'         => 'exav_addon_text', // child table
                                                                   
                                                                    'parent_field_id'     => 'parent_id',    // parent field
                                                                                           
                                                                    'child_attr_field_id' => 'exa_token',   // attribute code field
                                                                   
                                                                    'child_attr_code'     => 'DETE',           // attribute code
                                                                   
								    'input_html'	=>'class="w_100"',
								    
							    ),
							
							'15' =>array( 'field_name'	=> 'Code Editor', 
                                                               
								    'field_id' 		=> 'exa_value',
								   
								    'type' 		=> 'code_editor',
								    
								    'child_table'         => 'exav_addon_text', // child table
                                                                   
                                                                    'parent_field_id'     => 'parent_id',    // parent field
                                                                                           
                                                                    'child_attr_field_id' => 'exa_token',   // attribute code field
                                                                   
                                                                    'child_attr_code'     => 'DECE',           // attribute code
                                                                   
								    'input_html'	=>'class="w_100"',
								   
                                                            ),

					    ),
                                    
				
				'is_user_id'       => 'user_id',
				
				# Communication
				
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?dx=demo__eav', 'BACK_NAME'=>'Back'),
                                
				'flat_message'	=> 'Successfully Added',
				
				'show_query'  => 0
				
                                
			);
	
?>