<?PHP
                        
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Entity Child of Child',
				
				#Table field
                    
				'data'	=>   array(
						   
						    '10' =>array('field_name'=>'Parent',
							     
							     'field_id'=>'ec_id',
							     
							     'type'=>'option',
							     
							    'child_table'         => 'eav_addon_ec_id', // child table
							       
							    'parent_field_id'     => 'parent_id',    // parent field
										    
							    'child_attr_field_id' => 'ea_code',   // attribute code field
							    
							    'child_attr_code'     => 'ECPR',           // attribute code
							       
							     'is_mandatory'=>0,
							     
							     'option_data'=>'',
							     
							     'input_html'=>'class="w_200"',                                                               
							     
							     ),
						   
						   
						   
						    '1' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity','code,sn'," ORDER BY sn"),
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_200"',
                                                               
                                                               'avoid_default_option' => 0
                                                               
                                                               ),
                                                   
                                                  
						   
						   
						  '8' =>array('field_name'=>'Child Code',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
							       'type'=>'textarea',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECCD',           // attribute code
							       
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_100"',
                                                               
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
                                                               
                                                               'input_html'=>'class="w_150"'
                                                               
                                                               ),
                                                   
                                                   '9' =>array('field_name'=>'Long Name',
                                                               
                                                               'type'=>'textarea',
                                                               
							       'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECLN',           // attribute code
							       
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
                                                               
                                                               'input_html'=>'class="W_150"'
                                                               
                                                               ),
						   
						
                                                   
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
                                
				'is_user_id'       => 'created_by',
								
				# Communication
								
				'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Entity child' ),
                     
                                'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_child', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
                                
				# File Include
                                'after_add_update'	=>0,
				
				'page_code'	=> 'FECA',                                
				
                                
			);
    
    
    if(isset($_GET['default_addon'])){  
		
		$LAYOUT	    = 'layout_full';
		$parent_id=$_GET['default_addon'];	
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
		
		$F_SERIES['data'][10]['option_data'] = $G->option_builder('entity_child','id,entity_code'," WHERE id = $parent_id");
		$F_SERIES['data'][10]['avoid_default_option'] = 1;
		
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
    }
    
    if(isset($_GET['key'])){  
	
		$temp_id = $_GET['key'];	
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
		
		$F_SERIES['data'][10]['option_data'] = $G->option_builder('entity_child',"id,get_eav_addon_varchar(entity_child.id,'ECSN')"," WHERE entity_code =
									  (SELECT entity_code FROM entity_child WHERE
									  id=get_ec_parent_id_eav($temp_id))");
		$F_SERIES['data'][10]['avoid_default_option'] = 1;
		
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
    }
     
?>