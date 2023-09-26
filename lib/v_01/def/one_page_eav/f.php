<?PHP
	
	include($LIB_PATH."def/mop_v2_eav/t_map.php");

	$F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Entity Child of Child',
				
				#Table field
                    
				'data'	=>   array(
						   
						    '1' =>array('field_name'=>'Parent',
							     
								'field_id'=>"ec_id",
							     
							        'child_table'          => 'eav_addon_ec_id', // child table 
								'parent_field_id'     => 'parent_id',         // parent field
											 
								'child_attr_field_id' => 'ea_code',   	      // attribute code field
								'child_attr_code'     => 'ECPR',          // attribute code
							     
								'type'=>'option',
								
								'is_mandatory'=>0,
								
								'option_data'=>'',
								
								
								
								'input_html'=>'class="w_200"  onchange="" ',                                                               
							     
							     ),
						   
						   
						   
						  '2' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity','code,sn'," WHERE code IN ($T_SERIES[op_code]) ORDER BY sn"),
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_200"',
                                                               
                                                               'avoid_default_option' => 0
                                                               
                                                               ),
						  
						   '3' =>array('field_name'=>'Menu Name',
                                                               
                                                               	'field_id'=>"ea_value",
							     
							        'child_table'          => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',         // parent field
											 
								'child_attr_field_id' => 'ea_code',   	      // attribute code field
								'child_attr_code'     => 'ECSN',          // attribute code
							     
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                               
                                                               ),

                                                   
                                                    '8' =>array('field_name'=>'Hide in Page Menu',
                                                               
                                                               'field_id'=>'exa_value',
                                                               
                                                               'type'=>'option',
							       
								    'is_mandatory'      => 0,
								    'option_data'       => '<option value=0>No</option><option value=1>Yes</option>',
								    	'avoid_default_option'=>1,							    
								    //child table
									    
								    'child_table'        => 'exav_addon_num', // child table 
								    'parent_field_id'    => 'parent_id',         // parent field
											     
								    'child_attr_field_id' => 'exa_token',   	      // attribute code field
								    'child_attr_code'    => 'OPSS',          // attribute code
								    'attr'		 => ['class'=>'w_50'],
                                                               
									
								    'filter_out'=>function($data_in){ return ($data_in)?$data_in:0;} 
                                                               
                                                               ),
						    
						   
						 '4' =>array('field_name'=>'Heading',
                                                               
                                                               'field_id'=>"ea_value",
							     
							        'child_table'          => 'eav_addon_varchar', // child table 
								'parent_field_id'     => 'parent_id',         // parent field
											 
								'child_attr_field_id' => 'ea_code',   	      // attribute code field
								'child_attr_code'     => 'ECLN',          // attribute code
							     
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0
                                                               
                                                        ),
						   
						   
						   
						   
						   '5' =>array('field_name'=>'Sub Heading',
                                                               
                                                                'field_id'=>"ea_value",
							     
							        'child_table'          => 'eav_addon_text', // child table 
								'parent_field_id'     => 'parent_id',         // parent field
											 
								'child_attr_field_id' => 'ea_code',   	      // attribute code field
								'child_attr_code'     => 'ECDT',          // attribute code
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="W_150"'
                                                               
                                                               ),
						   
						
                                                   
						   '6' =>array(   'field_name'=> 'Background Image ',
                                                               
                                                            'field_id' => "get_eav_addon_varchar(id,'ECIA')",
                                                               
                                                            'type' => 'file',
                                                               
							    'upload_type' => 'image',   
      
							    'allow_ext'   => array('jpg','jpeg','png'),  

							    'location'    => '',          // attribute code
                                                               
                                                            'is_mandatory'=>0,
							
							    'input_html'=>'class="w_200"',
							       
                                                        ),
						   
						   
                                                   '7' => array( 'field_name'=> 'Line Order', 
                                                               
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
                                
				'is_user_id'       => 'user_id',
								
				# Communication
								
				'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child_eav', 'b_name' => 'Add Entity child' ),
                     
                                'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_child_eav', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
				
				'default_fields'=>['is_active'=>1],
                                
				# File Include
                                'after_add_update'	=>0,
				
				'page_code'	=> 'FECA',
				
				'show_query'=>0,
				
                                
			);
		
	if(isset($_GET['key'])){  
			
		$temp_sec_id = $_GET['key'];
			
                $F_SERIES['data'][2]['avoid_default_option'] = 1;
		
		$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECSN') as sn"," WHERE entity_code='CH'");
		$F_SERIES['data'][1]['avoid_default_option'] = 1;
		
		// coach name
		
		$temp_coach_name = $G->get_one_column(['field'=>"get_coach_code(id)",
						       'table'=>'entity_child',
						       'manipulation'=>" WHERE id=$temp_sec_id"
						      ]);
		
		$F_SERIES['data'][6]['location']   = "$COACH[path]$temp_coach_name/images/";
		
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
	}
	
	if(isset($_GET['default_addon'])){
	    
		$coach_code = $_GET['default_addon'];
	    
		$coach_id = $G->get_one_column([    'field'        => 'parent_id',
						    'table'        => 'eav_addon_vc128uniq',
						    'manipulation' => " WHERE ea_code='CHCD' AND  md5(ea_value)=md5('$coach_code')"
		]);
	
		
                $F_SERIES['data'][2]['avoid_default_option'] = 1;
		
		$F_SERIES['data'][1]['option_data']          = $G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECSN') as sn"," WHERE id = $coach_id");
		$F_SERIES['data'][1]['avoid_default_option'] = 1;
		
		$F_SERIES['data'][6]['location']   = "$COACH[path]$coach_code/images/";
		
                $F_SERIES['back_to']['is_back_button'] = 1;
		$F_SERIES['back_to']['back_link']= "?d=one_page_eav&default_addon=$coach_code";
                $F_SERIES['add_button']['is_add'] = 0;
	}
	
	$F_SERIES['before_add_update']=function($param){
	
		global $F_SERIES,$SG;	
		
		$lv = [];
		
		$lv['entity_code'] = $param['X2'];
		$img_size          =  $SG->get_cookie('section_bg_img_size');
	
		$F_SERIES['data'][6]['image_size']     = json_decode($img_size,TRUE);	
		$F_SERIES['data'][6]['save_file_name_prefix'] = strtolower($lv['entity_code']).'_';
		
	} // end

    
?>