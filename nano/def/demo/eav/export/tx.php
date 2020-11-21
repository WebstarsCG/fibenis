<?PHP
        $key           = @$_GET['key'];
        $T_SERIES       = array(
		
							'table'	=>	'entity',
								 
							'data'=>	array(
											'code'=>array('field' => 'code'),
											'name'=>array('field' => 'sn'),
											'attributes'=>array(
															'is_child_addon' =>1,
					
															'child_data'   =>[																	
																			'1'=>array('key'=>'token','field'=>'token'),
																			'2'=>array('key'=>'name','field'=>'sn'), 
																			'3'=>array('key'=>'description','field'=>'ln'),
																			'4'=>array('key'=>'line_order','field'=>'line_order'),
																			'4'=>array( 'key'=>'input_type','field'=>"get_ecb_av_addon_varchar(id,'APIT')" ),																				   		
																		],
									
																			'table'		=> ' entity_child_base',												
																			'key_filter'	=> " AND entity_code='$key'",									
																			'show_query'	=> 1			
														),										
							),	
							
							'key_id' 		=> 'code',														
							'template'     => dirname(__FILE__).'/tx.html',
							
							// save data 
							'save_as'=> array(
			
								array('type'	 => 'xml',
									'file_name'=>"csv/entity_export_".$key."_".time(),
									'path'	 =>  '.'						
								)	
							)
							
                        );
		
		
        	    
?>