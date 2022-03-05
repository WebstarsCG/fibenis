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
						 
			  'FT_FT'=>function($param){
						
							$lv = [];
							
							$lv['result'] = [];
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
									
									$inline_value     = $param['sv'];
									
									if(@$_GET['exit_data']){
										 
										 $lv['field'] = (@$_GET['field'])?@$_GET['field']:'sn';
										 
										 if(@$_GET['field']){
									
											  $lv['where']      = (@$_GET['query'])?" AND id=$_GET[query] ":"";
										 }else{
											  $lv['where']      = (@$_GET['query'])?" AND sn LIKE '%$_GET[query]%' ":"";
										 }
										 
										 $lv['query']   =  "SELECT id, sn FROM entity_attribute WHERE 1=1 $lv[where]";
										 
										 $lv['query_result'] = $param['rdsql']->exec_query($lv['query'],'0');
										 
										 while($row_data = $param['rdsql']->data_fetch_object($lv['query_result'])){
					 
												 array_push($lv['result'],array( 'id'   =>$row_data->id,
																 'name' =>$row_data->sn,
																 'col_field'=>@$_GET['col_field'],
																 'row_field'=>@$_GET['row_field'],
																 'key_id'=>@$_GET['key_id'],
																 
																 ));										       
										 }
											 
										 return json_encode($lv['result']);
									}
									
									
									if(@$_GET['check_data']){
										 
										 $lv['field'] = (@$_GET['field'])?@$_GET['field']:'sn';
									
										 $lv['where']      = (@$_GET['query'])?" AND $lv[field]='$_GET[query]'  ":"";
										 
										 $lv['query']   =  "SELECT id, sn FROM entity_attribute WHERE 1=1 $lv[where]";
										 
										 $lv['query_result'] = $param['rdsql']->exec_query($lv['query'],'0');
										 
										 $no_row = $param['G']->get_one_column([
															'field'   =>' count(*) ',
															'table'=>'entity_attribute',
															'manipulation'=>" WHERE 1=1 $lv[where]  "
															]);
						 
										 # one column
										 
										 return json_encode([['id'=>$no_row,'col_field'=>@$_GET['col_field'] ]]);
									}
									
									
									if(@$_GET['new_entry']){
									
										 $set_new_data="INSERT INTO
													 entity_attribute(entity_code,sn,user_id,line_order)
													 VALUES ('PG','$_GET[query]', $param[user_id],1)";
														 
										 $param['rdsql']->exec_query($set_new_data,'setdata--->');
										 
										 $last_id =  $param['rdsql']->last_insert_id('entity_attribute');
										 
										 return json_encode([['id'=>$last_id,'col_field'=>@$_GET['col_field'] ]]);
									}
									
									
								}else{
									
									return 0;		
								}
						
						
					},
					     
					
		)
?>