<?PHP
		
		$key			=	$_GET['key'];
	//	$wm             =   @$_GET['wm'];
		
		$key_code		=   get_csv_to_quoted_text($key);
	    
		
	
		$T_SERIES       = array(
								
									
								'table'	=>	'entity_child',
								 
								'data'=>	array(
													'id'=>array('field'=>'id'),
													'code'=>array('field' => 'entity_code'),
													'line_order'=>array('field' => 'line_order'),
										     	//	'mode'=>array('field' => "'".$wm."'"),
													
													'varchar'=>array(
															'is_child_addon' =>1,
															
															'child_data'   =>[				
																			'1'=>array('key'=>'token','field'=>'exa_token'),
																			'2'=>array('key'=>'value','field'=>'exa_value'),
																		//	'3'=>array('key'=>'email','field'=>'get_user_internal_email(user_id)'),
																			'3'=>array('key'=>'user_id','field'=>'user_id'),



																		],
									
																			'table'		=> ' exav_addon_varchar',												
																			'key_filter'	=> " AND parent_id = '[[parent.id]]'",									
																			'show_query'	=> 0		
														),
													
												),	
								  
								
								'key_id' => '',
								

								'key_filter'=> " AND entity_code IN ($key_code)",
								
								'show_query'=>1,
								
								'template'       => dirname(__FILE__).'/t.html',
								
								
								// save data 
								'save_as'=> array(
										
													array('type'	 => 'xml',
																'file_name'=>"csv/entity_child_export_".str_replace(',','_',$key)."_".time(),
															'path'	 =>  '.'
													
															)	
												)

);

	function get_csv_to_quoted_text($key){
		  
			$key			=	$_GET['key'];
			
			return implode(",",array_map('array_to_string',explode(',',$key)));
		
			
	  }
	  
	  function array_to_string($a){
			
		return "'$a'";
	  }		
        	    
?>