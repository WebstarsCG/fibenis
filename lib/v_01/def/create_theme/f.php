<?PHP
    
    $LAYOUT    = 'layout_full';
    
    $F_SERIES	=	array(
				'title'	=>'Theme',
				
				'data'	=>   array(
						     '1' =>array('field_name'=>'File name',
                                                               
                                                               'type'=>'text',
							       
							       'field_id'=>'ea_value',
                                                               
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECSN',           // attribute code
							       
							       'is_mandatory'=>1,
							       
							       'allow'     => 'w50[_]',
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
                                                   
                                                    '2' =>array('field_name'=>'Name',
                                                               
                                                               'type'=>'text',
                                                               
							       'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECLN',           // attribute code
							       
							       'allow'     => 'x1000',
							       
							       'input_html'=>'class="w_200"',
							       
							       'is_mandatory'=>1,
                                                               
                                                               ),
						   
						   
						   '3' =>array('field_name'=>'Description',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
							       'type'=>'textarea',
                                                               
                                                               'child_table'         => 'eav_addon_text', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECDT',           // attribute code
							       
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_300"'
                                                               
                                                               ),
						  
						   
				    
                                ),
                                    
				'table_name'    => 'entity_child',
				
				'key_id'        => 'id',
                                
				'is_user_id'       => 'user_id',
				
				'after_add_update' => 1,
				
				'default_fields'   => array('entity_code' => "'TH'"),
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=create_theme', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1,
                                
				'page_code'	=> 'FECA',
				
                                
			);
	
	  
    $F_SERIES['after_add_update']=function ($key_id){
        
        global $LIB_PATH,$USER_ID,$rdsql;
	
	$theme = $_POST['X1'];
	
	$theme_name = $_POST['X1'];
	
	if (!file_exists(get_config('theme_path').'/'.$theme)) {
	
		mkdir(get_config('theme_path').'/'.$theme.'/blend/source', 0777, true);
		
	}
	
	$ins = "INSERT INTO entity_child_base (entity_code,token,sn,ln,is_active,user_id)
		VALUES ('TH','$theme','$theme_name','$theme_name',1,$USER_ID)";
	
	$exe = $rdsql->exec_query($ins,"error");
	
    } # end
     
?>