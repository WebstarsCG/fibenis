<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $new_option     = '<option value=-1 class="clr_green">+ Add New</option>';
    
    # get parent id
    $default_addon='';
    
    if(@$_GET['default_addon']){
	$default_addon = @$_GET['default_addon'];
    }
    
    $PARAM      = @$_GET;
    
    $PARAM['code'] = ((@$PARAM['code'])?@$PARAM['code']:'CX');
    
    
    $F_SERIES	=	array(
				#Form Title
				
				'title'	=>'Contact',
				
				#Table field
                    
				'data'	=>   array(
						   
						   '0'  => ['field_name'=>'Basic',
								 'type'=>'heading'					 
							    ],
						   
						   '7' =>array( 'field_name'=> 'Entity Code',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
							       
							       'option_data' => $G->option_builder('entity',"code,sn"," WHERE code='$PARAM[code]'"),
                                                               
							       'avoid_default_option' => 1,
							       
                                                               'input_html'=>'class="w_100"'
                                                               
                                                               ),
						
						      '8' =>array( 'field_name'=> 'Parent ',
                                                               							       
								'field_id' => 'ec_id',
							       
							       	'child_table'         => 'eav_addon_ec_id', // child table 
								'parent_field_id'     => 'parent_id',    // parent field
											
								'child_attr_field_id' => 'ea_code',   // attribute code field
								'child_attr_code'     => 'ECPR',           // attribute code   
                                                               
                                                               'type' => 'option',
							       
							                                    
							       'avoid_default_option' => 1,
							       
                                                               'input_html'=>'class="w_100"'
                                                               
                                                               ),
						
						
						   '1' =>array( 'field_name'=> 'Organization ',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'text',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXFN',           // attribute code
							       
							       'input_html'=>'class="w_200"',
							       
							       'allow'		=> 'w128[ .]',
                                                               
							       'is_mandatory'=>1,
                                                               
                                                               ),
						   
						     
						    '2' =>array( 'field_name'=> 'Residential Address Line 1 ',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'textarea',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXRA',           // attribute code
							       
							       'input_html'=>'class="w_200"',
                                                               
							       'is_mandatory'=>1,
							       
							       'allow'		=> 'x1028',
                                                               
                                                               ),
						    
						    '3' =>array( 'field_name'=> 'Residential Address Line 2 ',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'textarea',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXRB',           // attribute code
							       
							       'input_html'=>'class="w_200"',
                                                               
							       'is_mandatory'=>0,
							       
							       'allow'		=> 'x1028',
                                                               
                                                               ),
						   
						   
						   
						    '4' =>array( 'field_name'=> 'Landline ',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'text',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXLD',           // attribute code
							       
							       'input_html'=>'class="w_100"',
                                                               
							       'is_mandatory'=>0,
							       
							       'allow' => 'x32',
                                                               
                                                               ),
						    
						    '5' =>array( 'field_name'=> 'Mobile ',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'text',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXMB',           // attribute code
							       
							       //'input_html'=>'class="w_100"',
							       
							       'input_html'=> "class='w_100'",
                                                               
							       //'is_mandatory'=>1,
							       
							       'allow' => 'x32',
                                                               
                                                               ),
						    
						    '6' =>array( 'field_name'=> 'Email ',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'text',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXEM',           // attribute code
							       
							       'input_html'=>"class='w_200' ",
							       
							       'allow'		=> 'x128[@]',
                                                               
							       'is_mandatory'=>0,	
                                                               
                                                               ),
						    
						    
						     '9' =>array( 'field_name'=> 'Google Map',
                                                               
                                                               'field_id' => 'ea_value',
                                                               
                                                               'type' => 'textarea',
							       
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'CXGM',           // attribute code
							       
							       'input_html'=>"class='w_200' maxlength=500",
							       
							       'allow'		=> '',
                                                               
							       'is_mandatory'=>0,	
                                                               
                                                               )
						   
						
					    
					    ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child',
				
				#Primary Key
                                
			        'key_id'        => 'id',
				
				//'deafult_value'    => array('entity_code' => "'CX'", 'is_active' => "1"),
				
				//'deafult_value'    => array('entity_code' => "'CX'"),
				
				'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/contact_eav/f'],
				
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>0, 'back_link'=>'?d=contact_eav', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1,
				
                                
				//'flat_message'	=> 'Successfully Added',
				
				# File Include
				
				'before_add_update' => 0,
				
				'show_query'    =>0,
				
				'divider'       => 'tab',

				'is_cc'			=>1,
				
                                
			);
    
    # edit case     
    if(@$_GET['key']){
	
	    $temp_id 				=   $_GET['key'];
       
	    $F_SERIES['data'][8]['option_data'] =   $G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECSN')"," WHERE entity_code='$PARAM[code]' AND id=get_ec_parent_id_eav($temp_id)");
						      
    } // end
    
    # default addon    
    if($default_addon){
	
	$LAYOUT	    = 'layout_full';
    
    
	$F_SERIES['data'][8]['option_data'] 	=   $G->option_builder( 'entity_child',
								        "id,get_eav_addon_varchar(id,'ECSN') as sn",
									" WHERE id=$default_addon AND  entity_code='$PARAM[code]'"
								    );
    } // end
							                           
?>