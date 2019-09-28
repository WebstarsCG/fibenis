<?PHP
                        
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Entity Child',
				
				#Table field
                    
				'data'	=>   array('1' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity','code,sn'," ORDER by sn ASC "),
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_200"',
                                                               
                                                               'allow'     => 'x50',
							       
                                                               'avoid_default_option' => 0
                                                               
                                                               ),
                                                   
                                                   
						   '8' =>array('field_name'=>'Child Code',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECCD',           // attribute code
							       
							       
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_50"',
                                                               
                                                               'allow'     => 'w4[1,2,3,4,5,6,7,8,9,0]',
                                                               
                                                               //'hint'   => 'Four Letter Code',
                                                               
                                                               //'allow'  => 'w4'
                                                               ),
						   
				   
						   '2' =>array('field_name'=>'Short Name',
                                                               
                                                               'type'=>'text',
							       
							       'field_id'=>'ea_value',
                                                               
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECSN',           // attribute code
							       
							       'is_mandatory'=>1,
							       
							       'allow'     => 'x50',
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
                                                   
                                                    '9' =>array('field_name'=>'Long Name',
                                                               
                                                               'type'=>'text',
                                                               
							       'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECLN',           // attribute code
							       
							       'allow'     => 'x1000',
							       
							       'input_html'=>'class="w_200"',
							       
							       'is_mandatory'=>0,
                                                               
                                                               ),
						   
						   
						   '5' =>array('field_name'=>'Description',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
							       'type'=>'textarea',
                                                               
                                                               'child_table'         => 'eav_addon_text', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECDT',           // attribute code
							       
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_300"'
                                                               
                                                               ),
						   
												
//						   '3' => array( 'field_name'=> 'Status', 
//                                                               
//                                                                'field_id' => 'status_code',
//                                                               
//                                                                'type' => 'option',
//                                                                
//                                                                'option_data'=>$G->option_builder('entity_attribute','code,sn'," WHERE entity_code='PP'  ORDER BY sn ASC"),
//                                                               
//                                                                'is_mandatory'=>1,
//                                                                
//                                                                'input_html'=>'class="W_150"'
//                                                                
//                                                                ),
						   
                                                   
                                                   '4' => array( 'field_name'=> 'Line Order', 
                                                               
                                                                'field_id' => 'line_order',
                                                               
                                                                'type' => 'text',
                                                                
                                                                'is_mandatory'=>0,
                                                                
                                                                'allow'        => 'd5[.]',
                                                                
                                                                'input_html'=>' class="w_50"  '
                                                                
                                                                ),
				    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child',
				
				#Primary Key
                                
			        'key_id'        => 'id',
                                
				# Default Additional Column
                                
				'is_user_id'        => 'created_by',
								
				# Communication
				
				//'button_name'=>'Test',		
				                     
                                'back_to'  	    => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_child', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
                                
				#1
				//'is_save_form'	=>1,
				
				
				
				
                                
			);
    
    if(isset($_GET['default_addon'])){  
	
		$default_addon = $_GET['default_addon'];
		$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn',"WHERE code = (SELECT code FROM entity WHERE id = $default_addon)");
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
		$LAYOUT	    = 'layout_full';
	}
	
    
     
?>