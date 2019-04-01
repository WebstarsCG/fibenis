<?PHP
       
	 $A_SERIES       =   array(
					'FT_AUT' => function($param){
				    
						      if(@$_GET['exit_data']){
							     
							     if(@$_GET['search_key']){
						      
										 $where= " WHERE $_GET[search_key] like '%".@$_GET['query']."%'";
										
								       }
								       
								      $data    = $param['data'];
							       
							               $result  = $param['rdsql']->exec_query("SELECT id,sn FROM entity $where ORDER BY sn",
														"Check Query");
								       $info    = [];					     
									  
									  while($row=$param['rdsql']->data_fetch_array($result)){
										
										 array_push($info,array( 'id'   => $row[0],
														   'name' =>$row[1]
											     ));
									  }
									  
									return json_encode($info);  
							       
						      } // if exit				     
					     
						      if(@$_GET['check_entry']){
							       
							       if(@$_GET['search_key']){
							     
								      $lv['where'] = " AND  $_GET[search_key] like '%".@$_GET['query']."%'";						      
								 }
											
							       $no_row = $param['G']->get_one_column([
												 'field'   =>' count(*) ',
												 'table'=>'entity',
												 'manipulation'=>" WHERE 1=1 $lv[where]  "
												 ]);
							      
							       return json_encode([['id'=>$no_row,'query_data'=>@$_GET['query'],'ele_id'=>@$_GET['ele_id'] ]]);   
							      
						     }
						     
						     if(@$_GET['new_entry']){
				    
								$set_new_data="INSERT INTO
										       entity(sn)
										       VALUES ('$_GET[query]')";
											       
							       $param['rdsql']->exec_query($set_new_data,'setdasdasdata--->');
							       
							       $last_id =  $param['rdsql']->last_insert_id('entity_attribute');
							       
							       return json_encode([['id'=>$last_id,'col_field'=>@$_GET['query'],'ele_id'=>@$_GET['ele_id'] ]]);
						     }
						      
						      
						       
						       
					     },
					     
					
                                )
?>