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
                                                               
                                                               'input_html'=>'class="w_100"',
                                                               
                                                               'avoid_default_option' => 0
                                                               
                                                               ),
                                                   
                                                   
						   '8' =>array('field_name'=>'Child Code',
                                                               
                                                               'field_id'=>'code',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_100"',
                                                               
                                                               //'hint'   => 'Four Letter Code',
                                                               
                                                               //'allow'  => 'w4'
                                                               ),
						   
				   
						   '2' =>array('field_name'=>'Short Name',
                                                               
                                                               'field_id'=>'sn',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                               
                                                               ),
                                                   
                                                    '9' =>array('field_name'=>'Long Name',
                                                               
                                                               'field_id'=>'ln',
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               ),
						   
						   
						   '5' =>array('field_name'=>'Description',
                                                               
                                                               'field_id'=>'detail',
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="W_150"'
                                                               
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
                                                                
                                                                'allow'        => 'd3',
                                                                
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
				
				'button_name'=>'Test',		
				                     
                                'back_to'  	    => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_child', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
                                
				#1
				'is_save_form'	=>1,
				
				
				
				
                                
			);
    
    if(isset($_GET['default_addon'])){  
	
		$default_addon = $_GET['default_addon'];
		$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn',"WHERE code = (SELECT code FROM entity WHERE id = $default_addon)");
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
	}
     
?>