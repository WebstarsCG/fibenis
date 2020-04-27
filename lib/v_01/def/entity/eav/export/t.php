<?PHP
		$key        	= @$_GET['key'];
	
	 
        $T_SERIES       = array(
		
								'table'	=>	'entity',
								 
								'data'=>	array(
													'code'=>array('field' => 'code'),
													'name'=>array('field' => 'sn'),
													'attributes'=>array(
																			'is_child_addon' =>1,
					
																			'child_data'   =>array(
																	
																				   '1'=>array('key'=>'token','field'=>'token'),
																				   '2'=>array('key'=>'name','field'=>'sn'), 
																				   '3'=>array('key'=>'description','field'=>'ln'),
																				   '4'=>array('key'=>'input_type','field'=>"get_ecb_av_addon_varchar(id,'APIT')"),
																				   '5'=>array('key'=>'class','field'=>"get_ecb_av_addon_varchar(id,'APCL')"),
																				   '6'=>array('key'=>'html','field'=>"get_ecb_av_addon_varchar(id,'APIH')"),
																				   '7'=>array('key'=>'mandatory','field'=>"get_ecb_av_addon_varchar(id,'APMA')"), 
																				   '8'=>array('key'=>'hint','field'=>"get_ecb_av_addon_varchar(id,'APHT')"),
																				   '9'=>array('key'=>'hide','field'=>"get_ecb_av_addon_varchar(id,'APHD')"),
																				   '10'=>array('key'=>'read_only','field'=>"get_ecb_av_addon_varchar(id,'APRO')")
																					),
									
																			'table'=> ' entity_child_base',
												
																			'key_filter'=>" AND entity_code='$key'",
									
																			'show_query'=>1
			
																		),
										
												),	
								
								
								'key_id' => 'code',
								
								'key_filter'=> '',
								
								
								
				  
								'template'       => dirname(__FILE__).'/t.html',
								
								// save data 
								'save_as'=> array(
										
													array('type'	 => 'xml',
														  'file_name'=>'entity_export',
														 'path'	 =>  dirname(__FILE__)
													
													  )	
												)

                        );
		
		
        	    
?>