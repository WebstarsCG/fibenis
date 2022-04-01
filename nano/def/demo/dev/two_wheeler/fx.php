<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $F_SERIES	=	array(
								'title'	=>'Two Wheeler',
				
                                'table_name'    => 'entity_child',
				
								'key_id'        => 'id',
				
								'gx'=>1,
				
								'default_fields'    => array('entity_code' => "'TW'"),
				
                                'data'	=>   array(
				
				'20'=>array('field_name'=>'Basic',
												'type'      => 'heading'
														),
							
							'1' =>array( 'field_name'	=> 'Two Wheeler Name',
                                                               
								    'field_id' 		=> 'exa_value',
								    
								    'type' 		=> 'text',
								    
								    'child_table'         => 'exav_addon_varchar', 	// child table
							       
								    'parent_field_id'     => 'parent_id',    		// parent field
										       
								    'child_attr_field_id' => 'exa_token',   		// attribute code field
							       
								    'child_attr_code'     => 'TWNA',           		// attribute code
								    
								    'allow' => 'x50',
							       
								    'is_mandatory'	=>1,
								    
							       ),
						   
						
							
							
							'3' =>array( 'field_name'	=> 'Two Wheeler Price',
                                                               
								    'field_id' 		=> 'exa_value',
								       
								    'type' 		=> 'text',
								    
								    'allow'     	=> 'c4,2',
								    
								    'child_table'         => 'exav_addon_decimal', 	
							       
								    'parent_field_id'     => 'parent_id',    		
										       
								    'child_attr_field_id' => 'exa_token',   		
							       
								    'child_attr_code'     => 'TWPR',
								    
								    'is_mandatory'	=>1,
								    
								    'input_html'	=>'class="w_60"',
                                                               
							       ),
							
							

					    ),
                                    
				
				'is_user_id'       => 'user_id',
				
				'is_field_id_as_token'=>1,
				
				# Communication
				
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?dx=demo__eav', 'BACK_NAME'=>'Back'),
                                
				//'flat_message'	=> 'Successfully Added',
				
				'prime_index'=>2,
				
				'show_query'  => 0,
				
				'avoid_trans_key_direct'=>0,
				
				//'is_save_form' => 1,
				
				'divider'     => 'accordion'
			);
	
?>