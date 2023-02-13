<?PHP
       
	 $A_SERIES       =   array(
	 
					'FT_AUT' => function($param){
				    
								 $get = @$_GET;
								 
								$service_req = @$get['service'];
								$service = [];
								 
								 
								$service['fetch'] = function($param,$get){
									
									$lv  = [];
									
									if(@$get['query']){								  
										$lv['where'] = " WHERE sn like '%".@$get['query']."%'";
									}
									
									if(@$get['prime']){								  
										$lv['where'] = " WHERE id=$get[prime]";
									}
								   
									$lv['result']  = $param['rdsql']->exec_query("SELECT id,sn FROM entity $lv[where] ORDER BY sn",
																	"Check Query");
									$lv['info']    = [];					     
									  
									while($lv['row']=$param['rdsql']->data_fetch_array($lv['result'])){										
										array_push($lv['info'],array( 'id'   => $lv['row'][0],
																	  'name' =>$lv['row'][1]));
									}
									
									return json_encode($lv['info']); 
									 
								}; // end
								
								$service['is_there'] = function($param,$get){
									
									$rows = $param['G']->get_one_column([
												 'field'   =>' count(*) ',
												 'table'=>'entity',
												 'manipulation'=>" WHERE id=$get[cid] AND sn='$get[cv]' "
												 ]);
							      
							       return json_encode(['rows'=>$rows]); 
								   
								}; // end
								
								
								
								
								// service
								if(@$service[$service_req]){
									
									return $service[$service_req]($param,$get);
									
								} // end
								 
					
						     
						     
						     if(@$_GET['new_entry']){
				    
								$set_new_data="INSERT INTO
										       entity(sn)
										       VALUES ('$_GET[query]')";
											       
							       $param['rdsql']->exec_query($set_new_data,'setdasdasdata--->');
							       
							       $last_id =  $param['rdsql']->last_insert_id('entity_attribute');
							       
							       return json_encode([['id'=>$last_id,'col_field'=>@$_GET['query'],'ele_id'=>@$_GET['ele_id'] ]]);
						     }
						      
						      
						       
						       
					     },
					     
				// option update

				'OPT_UPD' => function($param){
					

					$get    = json_decode($param['data'],true);
					
					$get['id_csv']=implode(',',$get['id']);
			
					$query = "UPDATE demo SET option_single='$get[detail]' WHERE id IN($get[id_csv])";
		
					$param['rdsql']->exec_query($query,"Error".$query);
		
					return 1;

				}					
	)
?>