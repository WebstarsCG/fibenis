<?PHP
		
		$P_V['user_id'] = $USER_ID;
		
		
		$E = new Export($rdsl);
		
		if(@$_POST['ADD']){
				
							   
			$DB_INFO =  array(
					  
								//array(
								//	'table' =>'data_postal_code',
								//	'fields'=> ''
								// ),
								//
								array(
									'table' =>'entity',
									'fields'=> ''
								 ),
								 
								array(
								       'table' =>'entity_attribute',
								       'fields'=> 0
								),
								
								array(
									'table' =>'entity_key_value',
									'fields'=> 0
								), 
								
								array(
									'table' =>'finance_year',
									'fields'=> 0
								),
								
								array(
									'table' =>'location_info',
									'fields'=> 0
								),
								
								array(
									'table' =>'location_type',
									'fields'=> 0
								),
								
								array(
									'table' =>'page_info',
									'fields'=> 0
								),
								
								array(
									'table' =>'status_map',
									'fields'=> 0
								),
								
								array(
									'table' =>'status_permission',
									'fields'=> 0
								),
								
								array(
									'table' =>'user_permission',
									'fields'=> 0
								),
								
								array(
									'table' =>'user_role',
									'fields'=> 0
								),
								
								array(
									'table' =>'user_role_permission',
									'fields'=> 0
								)
							); 
														
			$return_query = $E->data_table_to_sql($DB_INFO);
		
		}
		
		
		$options 	= array("filename"=>"../lib_v2/template/data_export.html", "debug"=>0,"loop_context_vars"=>1);
					
		$T 	 	= new Template($options);
		
		
		
		$T->AddParam('return_query',$return_query);
		
		
		$PAGE_INFO = $T->Output();
		
		
		
		
	
	
	
	
	class Export{
		
			 
			protected $rdsql;	 
			 
			function data_table_to_sql($db_info){
				
				
						$l_v=array();
					 	
						global $rdsql;
						
						$no_data = count($db_info);
						
						$l_v['get_row']='';
						
						$l_v['export_query']='';
						
						for($db_i = 0;$db_i<$no_data; $db_i++){
						
								 $l_v['table_name'] =  $db_info[$db_i]['table'];
								
								 $l_v['fields'] =  $db_info[$db_i]['fields'];
								
								 if($l_v['fields']){
								 
								 	 $l_v['get_row']=  $this-> get_row(
																array(
																	'table'  => $l_v['table_name'],
																	
																	'fields' =>  $l_v['fields']
																  )
														);
													
										$l_v['export_query'].='<br>';
													
										$l_v['export_query'].="INSERT INTO $l_v[table_name] ($l_v[fields]) VALUES  $l_v[get_row] <br><br>";	
								 
								 }// if field
								 
								 else{
								 
								 	 $select_column = "select column_name from information_schema.columns where table_name = '$l_v[table_name]' ";
									
									 $exe_column_data =  $rdsql->exec_query($select_column,"Select Colimn!");
									 
									  $all_field='';
						 
									 while($get_c_row = $rdsql->data_fetch_object($exe_column_data) ){
										 
											$all_field.=$get_c_row->column_name.',';	
									 }
									 
									  
									     $l_v['final_field'] = substr($all_field,0,-1); 
									  
										 $l_v['get_row']=  $this-> get_row(
																array(
																	'table'  => $l_v['table_name'],
																	
																	'fields' =>  $l_v['final_field']
																  )
													);
													
										$l_v['export_query'].='<br>';
													
										$l_v['export_query'].="INSERT INTO $l_v[table_name] ($l_v[final_field]) VALUES  $l_v[get_row] ;<br><br>";	
									 
											
								 }//filed is 0
								 
								 
								  
								 
								 
								
						}//for loop
						
						return  $l_v['export_query'];
						
		 }
			
			
		function get_row($data){
				
					global $rdsql;
					
					$select_data = "SELECT $data[fields] FROM $data[table] WHERE 1=1";
						
					$ex_query = $rdsql->exec_query($select_data,"Select Error!");
					 
					$split_comma = explode(',',@$data['fields']);
					
					$result='';
					
					while($get_row = $rdsql->data_fetch_object($ex_query) ){
						
							$result.='(';
							
							$FILED_COUNT =1;
							
							for($field_i=0; $field_i<count($split_comma); $field_i++){
							
								
								if($FILED_COUNT == count($split_comma) ){
									
									$result.= "'".$get_row->$split_comma[$field_i]."'";
								}
								
								else{
									$result.= "'".$get_row->$split_comma[$field_i]."',";
								}
								
								$FILED_COUNT ++;
								
							}//for
							
							
							$result.='),';
					}//while
					
					return  substr($result,0,-1);
		}//get_row
			
				
		} //class
	
		
		
		
?>