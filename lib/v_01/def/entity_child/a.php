<?PHP
       
	 
        $A_SERIES       =   array(
		
		
					'ECIU'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
									
									$inline_value     = $param['sv'];									
													
									$param['rdsql']->exec_query("UPDATE
												entity_child
											   SET
												detail='$inline_value'
											   WHERE
												id=$inline_param->id AND
												md5(sn)='$inline_param->key'
											   ",'0');
									
									# one column
									
									return $param['G']->get_one_columm(array('table'        => 'entity_child',
												      'field'        => 'count(*)',
												      'manipulation' => "WHERE
																id=$inline_param->id AND
																md5(sn)='$inline_param->key'"
											));
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
					# active inactive
					
					
					'ECAI'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
									
									$inline_value     = $param['sv'];									
																					
									$param['rdsql']->exec_query("UPDATE
												entity_child
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
					
					// entitychild, external attribute
					
					'ECAV'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode(urldecode($param['data']));
									
									$inline_value     = $param['sv'];									

									//echo "DELETE FROM 
									//					eav_addon_varchar											   
									//				WHERE
									//					parent_id=$inline_param->id AND
									//					ea_code='$inline_param->ea_code'
									//				";
									$param['rdsql']->exec_query("DELETE FROM 
														eav_addon_varchar											   
													WHERE
														parent_id=$inline_param->id AND
														ea_code='$inline_param->ea_code'
													",'D');
									
									
													
									$param['rdsql']->exec_query("INSERT
													eav_addon_varchar
														(parent_id,ea_code,ea_value,user_id)
													VALUES
														($inline_param->id,'$inline_param->ea_code','$inline_value',$param[user_id])																									
													",'I');
									
									# one column
									
									//return 1;
									
									return $param['G']->get_one_columm(array('table'        => 'eav_addon_varchar',
												      'field'        => 'count(*)',
												      'manipulation' => "WHERE
																parent_id=$inline_param->id AND
																ea_code='$inline_param->ea_code'"
											));
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
					'ECLI'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
									
									$inline_value     = $param['sv'];									
																					
									$param['rdsql']->exec_query("UPDATE
												entity_child
											   SET
												line_order=$inline_value
											   WHERE
												id=$inline_param->id 
											   ",'0');
									
									# one column
									
									return $param['data'];
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
					'SEUR'=>function($param){
						
							$temp = [];
							
							$temp['decrypt'] = json_decode($param['G']->decrypt($_GET['req'],$_GET['trans_key']),true);
							
							if(($param['user_id']==$temp['decrypt']['user_id'])&&($param['pass_id']==$temp['decrypt']['pass_id'])){
								
								$temp['temp']    = $param['G']->decrypt($temp['decrypt']['data'],$temp['decrypt']['trans_key']);
								
								$temp['ext'] = strtolower(pathinfo($temp['temp'], PATHINFO_EXTENSION));
								
								$temp['type_temp'] = [	'pdf'=>'application',
											'jpeg'=>'image',
											'png'=>'image',
											'html'=>'text',
											'jpg'=>'image',
											'csv'=>'text'];
								
								function data_uri($file, $mime){
									
									ob_end_clean();																    
									header("content-type: $mime");							   
									return file_get_contents($file);
									
							    };
							       
								$temp['mime_pre'] = $temp['type_temp'][$temp['ext']].'/'.$temp['ext'];
							    
								$temp['op'] = data_uri($temp['temp'],$temp['mime_pre']);
							    
								return $temp['op'];
						
							}else{
								
								header('HTTP/1.0 401 Unauthorized');
								exit;
							}
							
						      
					     },
         
         

                            );
	
	
	
	
	
    
?>