<?PHP

	$where = "WHERE id NOT IN(SELECT is_internal FROM user_info) AND entity_code='CO'";
	
	$F_SERIES = array(
	
		'title' => 'User Information',
	
		'table_name' => 'user_info',
	
		'key_id' => 'id',
	
		'data' => array( 
	
			'1' => array(		'field_name' => 'User Name',
				
						'field_id' => 'is_internal',
				
						'type' => 'option',
				
						'option_data' => $G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'COFN')", " $where "),
				
						'is_mandatory' => 1,
				
						//'avoid_default_option' => $default,
				
						'input_html'=>' class="w_200" onclick="JavaScript:change_roles(this);"'
			),
			
			'2' => array(		'field_name'=> 'User Role',
				
						'field_id' => 'user_role_id',
				
						'type' => 'option',
						
						'option_data' => $G->option_builder('user_role', 'id,ln', " WHERE sn <> 'SAD' "),
				
						'is_mandatory' => 1,
						
						'input_html'=>' class="w_200"'
			),
	
			'3' => array(		'field_name' => 'Password',
				     
						'field_id' => 'password',
				     
						'type' => 'password',
				     
						'is_mandatory' => 1,
				     
						'filter_in'   => function($data_in){ 
                                
						             return md5($data_in);
                                                }
		        
				),
			
//			'4' => array(		'field_name' => 'Retype Password',
//				     
//						'field_id' => 'password',
//				     
//						'type' => 'password',
//				     
//						'is_mandatory' => 1,
//						
//						'input_html'=> "  onchange='check_password(this);'",
//				     
//						'filter_in'   => function($data_in){ 
//                                
//						             return md5($data_in);
//                                                }
//						
//				),
	
			
	
		),
	
		#'no_edit' => array('password'),
	
		'is_user_id' => 'user_id',
		
		"deafult_value"=>array('is_active'            => 1,
					'is_mail_check'        => 0,
					'is_send_mail'         => 0,
					'is_send_welcome_mail' => 0
				),

		'js' => array('is_top' => 1, 'top_js' => 'js/f_series/user_neutral'),
		
		//'js'=> ['is_bottom'=>1,'bottom_js'=>$LIB_PATH.'def/user_neutral/f'],
	
		'back_to' => array('is_back_button' => 1, 'back_link' => '?d=user_neutral', 'BACK_NAME' => 'Back'),
	
		'prime_index' => 1,
			
		'cascade_action' => 0,
	
		'after_add_update' => 1,
	
		
	);
	
		
	// alert
	
	$F_SERIES['alert']=array(
				
		'is_after_add' 	=> 1, # message trigger

		'mail'         	=> array(
		
					// columns 
					'data' => array(),
		
					),
						
					'to'		=> '',
					//'cc'		=> '<cc mail id>',
				        //'bcc'		=> '<bcc mail id>',					
                                        'subject'	=> get_config('domain_name').' - Login Information',
					'message' 	=> ''
	);
	
	
	// after_add_update
	
	function after_add_update($key_id){
		
		global $F_SERIES,$rdsql;
		
		$lv = [];
		
		$query_result 	= $rdsql->exec_query("SELECT
								get_eav_addon_varchar(is_internal,'COFN') as user_name,
								get_eav_addon_varchar(is_internal,'COEM') as user_email
							FROM
								user_info
							WHERE
								id=$key_id","0");
		
		$result 	= $rdsql->data_fetch_object($query_result);		
		
		$F_SERIES['alert']['to']        =  $result->user_email;
		
		$F_SERIES['alert']['bcc']       =  get_config('bcc_email');
		
		$F_SERIES['alert']['subject']	=  get_config('title').' - Login Information';
		
		$F_SERIES['alert']['message'] = custom_mail_message([   'user_name'  => $result->user_name,
										'user_email' => $result->user_email,
										'user_key'   => $_POST['X3'],
										'domain_name'=> get_config('domain_name'),
										'msg_code'   => 'WEL']);		
	} // end

?>
