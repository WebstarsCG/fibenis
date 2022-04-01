<?PHP

    include_once($LIB_PATH."/inc/lib/f_addon.php");
             
				
													           
								$F_SERIES	=	array(
								
														'title'	=>'Product',
												
														'data'  => array(),
																						
														'table_name'    => 'entity_child',
																						
														'key_id'        => 'id',
																						
														'is_user_id'    => 1,
		
														'add_button'   => array( 'is_add' =>1),
											
														'back_to'  	  => array( 'is_back_button' =>1),
																						
														'prime_index'  => 1,
														
														'default_fields'  =>array('entity_code' => 'PR')
								                    );
								
								
								// default addon				
									
								@$F_SERIES['temp']  =f_addon(['g' => $G,
																	'rdsql'		   => $rdsql,
																	'f_series'     	   => ['data'=>$F_SERIES['data']],
																	'default_addon'	   => json_encode(['en'=>'PR'])
															]);
				
								$F_SERIES['data']   = @$F_SERIES['temp']['data'];
								
				
				
				 
?>