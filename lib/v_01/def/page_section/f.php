<?PHP
    
    $temp_id = @$_GET['default_addon'];
    
    $LAYOUT    = 'layout_full';
    
    $F_SERIES	=	array(
				'title'	=>'Page Section',
				
				'data'	=>   array(
						   
						    '1' =>array('field_name'=>'Parent',
							     
							     'field_id'=>'ec_id',
							     
							     'type'=>'option',
							     
							    'child_table'         => 'eav_addon_ec_id', // child table
							       
							    'parent_field_id'     => 'parent_id',    // parent field
										    
							    'child_attr_field_id' => 'ea_code',   // attribute code field
							    
							    'child_attr_code'     => 'ECPR',           // attribute code
							       
							    'is_mandatory'=>0,
							     
							    'option_data' => $G->option_builder('entity_child',"id,get_eav_addon_varchar(entity_child.id,'ECSN')",
												 "WHERE id=$temp_id"),
							    
							    'avoid_default_option' => 1,
						
							     
							    'input_html'=>'class="w_200"',                                                               
							     
							),
						   
						 
						    '2' =>array('field_name'=>'Heading',
                                                               
                                                               'type'=>'text',
							       
							       'field_id'=>'ea_value',
                                                               
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECSN',           // attribute code
							       
							       'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                               
                                                               ),
                                                   
                                                   '9' =>array('field_name'=>'Sub Heading',
                                                               
                                                               'type'=>'textarea',
                                                               
							       'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECLN',           // attribute code
							       
							       'is_mandatory'=>0,
                                                               
                                                               ),
						   
						   '5' =>array('field_name'=>'Detail',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
							       'type'=>'code_editor',
                                                               
                                                               'child_table'         => 'eav_addon_text', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECDT',           // attribute code
							       
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
						   
						    '4' => array( 'field_name'=> 'Line Order', 
                                                               
                                                                'field_id' => 'line_order',
                                                               
                                                                'type' => 'text',
                                                                
                                                                'is_mandatory'=>0,
                                                                
                                                                'allow'        => 'd3',
                                                                
                                                                'input_html'=>' class="w_50"  '
                                                                
                                                                ),
				    
                                ),
                                    
				'table_name'    => 'entity_child',
				
				'key_id'        => 'id',
                                
				'is_user_id'       => 'user_id',
				
				'default_fields'   => array('entity_code' => "'SC'"),
								
				'add_button' => array( 'is_add' =>0,'page_link'=>'f=', 'b_name' => 'Add' ),
                     
                                'back_to'  => array( 'is_back_button' =>0, 'back_link'=>'?d=', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
                                
				'page_code'	=> 'FECA',
				
                                
			);
    
   
    if(@$_GET['key_id']){
	
	$temp_id = $_GET['key_id'] ;
	
	$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity_child',"id,get_eav_addon_varchar(entity_child.id,'ECSN')",
								  "WHERE id=get_ec_parent_id_eav($temp_id)");
    
    }
    
    
    if(@$_GET['default_addon']){
	
	$temp = $_GET['default_addon'] ;
	
	$no_row = $G->table_no_rows( array('table_name'=>'eav_addon_ec_id',
                                           'WHERE_FILTER'=>"AND ea_code = 'ECPR' AND ec_id=$temp AND
					   parent_id IN (SELECT id FROM entity_child WHERE entity_code = 'SC')"
                                           ));
	
	$line_order= $no_row[0]+1;	
	
	$F_SERIES['data']['4']['input_html'] = 'class="w_50" value='.$line_order;
	
	if((@$_GET['key'])&&(!isset($_GET['menu_off']))){
	    
	     header('Location:?f=page_section&menu_off=1&default_addon='.$temp.'&key='.$_GET['key']);
	}
		
    }
    
    
    
    


?>