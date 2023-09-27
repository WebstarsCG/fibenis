<?PHP
    
    $page_img_size_auto =  $SG->get_cookie('page_img_size_auto');
                      
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'General',
				
				#Table field
                    
				'data'	=>   array('1' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity','code,sn'," ORDER by sn ASC "),
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_150"',
                                                               
                                                               'avoid_default_option' => 0
                                                               
                                                               ),
						   
						   
						    '2' =>array( 'field_name'=> 'Parent',
                                                               
                                                               'field_id' => 'ec_id',
							       
							       	'child_table'         => 'eav_addon_ec_id', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECPR',           // attribute code    
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>'',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_150"',
                                                               
                                                               'avoid_default_option' => 0
                                                               
                                                               ),
                                                   
                                                   
						   '3' =>array('field_name'=>'Code',
                                                               
                                                                'field_id' => 'ea_value',
							       
							       	'child_table'         => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECCD',           // attribute code    
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_100"',
                                                               
                                                               //'hint'   => 'Four Letter Code',
                                                               
                                                               //'allow'  => 'w4'
                                                               ),
						   
				   
						   '4' =>array('field_name'=>'Short Name',
                                                               
                                                                'field_id' => 'ea_value',
							       
							       	'child_table'         => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECSN',           // attribute code    
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                               
                                                               ),
                                                   
                                                    '5' =>array('field_name'=>'Long Name',
                                                               
                                                                'field_id' => 'ea_value',
							       
							       	'child_table'         => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECLN',           // attribute code    
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               ),
						   
						   
						   '6' =>array('field_name'=>'Detail',
                                                               
                                                                'field_id' => 'ea_value',
							       
							       	'child_table'         => 'eav_addon_text', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECDT',           // attribute code    
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="W_150"'
                                                               
                                                               ),
						   
						
						   '7' =>array(   'field_name'=> 'Image ',
                                                               
                                                             'field_id' => 'ea_value',
							       
							       	'child_table'         => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECIA',           // attribute code    
                                                               
                                                            'type' => 'file',
                                                               
							    'upload_type' => 'image',   
      
							    'allow_ext'   => array('jpg','jpeg','png'),  

							    'location'    => 'doc/user_profile/',          // attribute code
                                                               
                                                            'is_mandatory'=>0,
							
							    'input_html'=>'class="w_200"',
							       
                                                        ),
						   
						   '8' =>array(   'field_name'=> 'Image A',
                                                               
                                                             'field_id' => 'ea_value',
							       
							       	'child_table'         => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECIB',           // attribute code    
                                                               
                                                            'type' => 'file',
                                                               
							    'upload_type' => 'image',
							    
							    //'save_file_name_suffix'=> '_outer',
      
							    'allow_ext'   => array('jpg','jpeg','png'),  

							    'location'    => 'doc/user_profile/',          // attribute code
                                                               
                                                            'is_mandatory'=>0,
                                                               
                                                            'input_html'=>'class="w_200"',
							    
							    //'image_size_auto' => json_decode($page_img_size_auto,TRUE),
                                                               
                                                        ),
						   
						   	
                                                   '9' => array( 'field_name'=> 'Line Order', 
                                                               
                                                                'field_id' => 'line_order',
                                                               
                                                                'type' => 'text',
                                                                
                                                                'is_mandatory'=>0,
                                                                
                                                                'allow'        => 'd3',
                                                                
                                                                'input_html'=>' class="w_50"  ',
								
                                                                ),
						   
						   
				    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child',
				
				'default_fields'    => array(),
				
				#Primary Key
                                
			        'key_id'        => 'id',
                                
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
				
				
								
				# Communication
								
				'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Entity child' ),
                     
                                'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_child', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
                                
				# File Include
                                'after_add_update'	=>0,
				
				'page_code'	=> 'FECA',       
				
				'is_cc'=>1
				
				
                                
			);
    
    
	if(@$_GET['default_addon']){	    
	    
		    $F_SERIES['back_to']['is_back_button']=0;
	    
	} // end
    
    

    
     
?>