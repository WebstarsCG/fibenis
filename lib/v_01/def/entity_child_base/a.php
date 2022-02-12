<?PHP
       
	 $A_SERIES       =   array(
		
					'TKCO'=>function($param){
                                            
                                                $data = $param['data'];
                                                
                                                $result = $param['rdsql']->exec_query("SELECT count(*) as count FROM entity_child_base
                                                                                      WHERE token = '$data' ",
                                                                                      "Check Query");
                                                
                                                $temp = $param['rdsql']->data_fetch_object($result);
                                                
                                                return $temp->count;
                                                
					},
					
					
					'ECBAI'=>function($param){
						
								
								if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
									
									$inline_value     = $param['sv'];									
																					
									$param['rdsql']->exec_query("UPDATE
												entity_child_base
											   SET
												is_active=$inline_param->fv
											   WHERE
												id=$inline_param->id 
											   ",'0');
									
									# one column
									
									return $param['data'];
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
	)
?>