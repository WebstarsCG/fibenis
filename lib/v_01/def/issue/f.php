<?PHP

    $LAYOUT	    = 'layout_basic';
                            
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Issue',
				
				#Table field
                    
				'data'	=>   array(
						   
						   
						   '1' =>array( 'field_name'=> 'Name ',
							       
							       'field_id' => 'exa_value',
                                                               
                                                               'type' => 'text',
							       
							       'child_table'         => 'exav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'exa_token',   // attribute code field
							       
							       'child_attr_code'     => 'ISNA',           // attribute code
							       
							       'is_mandatory'=>1,
							       
							       'allow'	=> 'x1028',
							       
							       'input_html'=>'class="w_200"'
                                                               
                                                               ),
						   
						   '2' =>array( 'field_name'=> 'Description ',
                                                               
                                                               'field_id' => 'exa_value',
                                                               
                                                               'type' => 'textarea',
                                                               
							       'child_table'         => 'exav_addon_text', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'exa_token',   // attribute code field
							       
							       'child_attr_code'     => 'ISDS',           // attribute code
                                                               
                                                               'is_mandatory'=>1,
							       
							       'allow'	=> 'x1028',
							       
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
						   
						   
						   '3' =>array( 'field_name'=> 'Raised On',
                                                               
                                                               'field_id' => 'exa_value',
                                                               
                                                               'type' => 'date',
							       
							       'set'  => array('min_date'=>'-0D','max_date'=>'0D'),
							       
                                                               'child_table'         => 'exav_addon_date', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'exa_token',   // attribute code field
							       
							       'child_attr_code'     => 'ISRO',           // attribute code
							       
							       'default_date'=>date("d-m-Y"),
                                                      
							       'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_100"' ,
							       
                                                               ),
						   

						    
						    '4' =>array( 'field_name'=> 'Priority ',
                                                               
                                                               'field_id' => 'exa_value_token',
                                                               
                                                               'type' => 'option',
							       
							       'option_data' => $G->option_builder('entity_child_base','token,sn'," WHERE entity_code='IP'  ORDER BY line_order ASC"),
                                                               
							       'child_table'         => 'exav_addon_exa_token', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'exa_token',   // attribute code field
							       
							       'child_attr_code'     => 'ISPI',           // attribute code
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_100"'
                                                               
                                                               ),
						   
					
						     '5' =>array(   'field_name'=> 'Document ',
                                                               
                                                            'type' => 'file',
                                                               
							    'upload_type' => 'docs',
							    
							    'allow_ext'   => array('jpg','jpeg','png','pdf'),  

							    'location'    => 'media/',          // attribute code
								
								'save_file_name_prefix'=> 'issue_',  
                                                            
							    'field_id' => 'exa_value',
                                                               
								'child_table'         => 'exav_addon_varchar', // child table
							       
							    'parent_field_id'     => 'parent_id',    // parent field
										       
							    'child_attr_field_id' => 'exa_token',   // attribute code field
							       
							    'child_attr_code'     => 'ISSO',           // attribute code
                                                               
								'input_html'=>'class="w_200"',
							    
							    'max_size'    => 2048,
							    
							    'save_file_name_prefix'=> 'issue_',
							    
							    'hint'	  => "Upload file less than 2 MB",
							    
							       
                                                        ),
						   
					    
					    ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child',
				
				#Primary Key
                                
			        'key_id'        => 'id',
				
				
				# Default Additional Column
                                
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=issue', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1,
				
				'deafult_value'    => array('entity_code' => "'IS'"),
                                
				# File Include
				
				'page_code'	=> 'ISUE',
				
				'show_query'    =>0,
				
				'is_user_id'       => 'user_id',
				
				//'before_add_update'=>1,
				
				'after_add_update'=>1,
				
                                
			);
    
    if(isset($_GET['key'])){
	
	$F_SERIES['after_add_update'] = 0;
    }
    
    
    function after_add_update($key_id){
    		
		global $rdsql,$USER_ID;
		
		$Insert_status = $rdsql->exec_query("INSERT INTO exav_addon_exa_token (parent_id,exa_token,exa_value_token,user_id)
									VALUES
						     ($key_id,'ISST','IUOP',$USER_ID)","Insertion Of Issue Status Failed");
		
		$Insert_status_info = $rdsql->exec_query("INSERT INTO status_info (status_code,entity_code,child_comm_id,user_id)
									VALUES
						     ('IUOP','IU',$key_id,$USER_ID)","Insertion Of Status info Failed");
			
    }
    

?>	