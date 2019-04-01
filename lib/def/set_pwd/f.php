<?PHP
    
    $u_id = $_GET['default_addon'];
    
    $LAYOUT	    = 'layout_full';
                            
    $F_SERIES	=	array(
				#Title
				
				'title'	=>'Password',
				
				#Table field
                    
				'data'	=>   array(
				    
						    '3' =>array( 'field_name'=> 'User ',
                                                               
								'field_id' => 'child_comm_id',
                                                               
								'type' => 'option',
								
								'option_data'=>$G->option_builder("eav_addon_varchar","parent_id,ea_value","WHERE ea_code='COFN' AND parent_id=".$u_id),
                                                               
								'avoid_default_option' => 1,
								
								'is_mandatory'=>1,
								
								'input_html'=>'class="w_150"',
								
                                                               
                                                             ),
						   
						   
						   '1' =>array( 'field_name'=> 'Password ',
                                                               
								'field_id' => 'password',
                                                               
								'type' => 'password',
								
								'ro'   => 1,
								
								'allow'=>'x8=',
                                                               
                                                                'is_mandatory'=>1,
								
								'input_html'=>'class="w_150"',
								
                                                               
                                                             ),
						   
						   '2' =>array( 'field_name'=>'Confirm Password',
                                                               
								'field_id'=>'password',
                                                               
								'type' => 'password',
							       
								'is_mandatory'=>1,
								
								'ro'   => 1,
								
								'allow'=>'x8=',
                                                               
                                                               'input_html'=>'class="w_150" onchange="check_pwd();"',
                                                                   
                                                               ),
						   
					    ),
				
                                    
				'table_name'    => 'status_info',
				
				'key_id'        => 'id',
				
				'is_user_id'       => 'user_id',
				
				'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/set_pwd/f'],
                                
				'back_to'  => NULL,
				
				'default_fields'    => array('status_code' => "'COPW'",
							    'entity_code' => "'CO'",),
                                
				'show_query' => 1,
                               				
				'flat_message' => 'Sucesssfully Updated',
				
				'show_query'    =>0,
				
				'after_add_update'=>1,
                                
			);
    
     function after_add_update($key_id){
	
	    global $rdsql;
	    
	    $u_id = $_GET['default_addon'];
    
	    $pwd = $_POST['X2'];
	    
	    $update = $rdsql->exec_query("UPDATE user_info SET password = MD5('$pwd') WHERE is_internal = $u_id","Updation Failed");
	    
	    return null;	
		
    } 
?>