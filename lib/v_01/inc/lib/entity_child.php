<?PHP

	class EntityChild extends General {
	
		function insert($param){
			 
			 $lv =[
			        'ent_child_id'=>[],
					'table_type'=> [	
									'bool'=>['data'=>['exav'=>[],'eav'=>[]]],													
									'date'=>['data'=>['exav'=>[]]],
									'decimal'=>['data'=>['exav'=>[]]],
									'ec_id'=>['data'=>['exav'=>[],
									                   'eav'=>[]],
													   'field_name'=>'ec_id'],
									'exa_token'=>['data'=>['exav'=>[],
									                   'eav'=>[]],
													   'field_name'=>'exa_value_token'],
													   
									'num'=>['data'=>['exav'=>[]]],
									'text'=>['data'=>['exav'=>[]]],
									'varchar'	=>	['data'=>['exav'=>[],'eav'=>[]]],
									'vc128uniq'=>['data'=>
														 ['exav'=>[],
														 'eav'=>[]]
														 ],
									'vc32'=>['data'=>
														 ['ectv'=>[]
														 ]
											],	
								],
								
					'counter'=> ['accept'=>0,'reject'=>0,'row'=>0]
								  
					
				];
			 
				$lv['user_id'] = @$param['user_id'] ?? ($this->getUserId() ?? 1);

				$lv['table']	   =  (@$param['table']) ?? 'entity_child';

             foreach($param['table_data'] as $fields){

				$lv['counter']['row']++;
									 
			    $lv['is_exist'] = (@$param['pre_check'])?@$param['pre_check']([	'cols'	=>$fields,
				 																'g' 	=> $this,
																				'rdsql'	=>$this->rdsql,
																				'key_id'=>$param['key_id'],
																				'row'   =>$lv['counter']['row']
																			]):0;
				
				if($lv['is_exist']==0){


				
					
					// insert entity code
					$lv['ins_ec_query'] ="INSERT INTO $lv[table](entity_code,created_by,user_id)
																	  VALUES('$param[entity_code]',$lv[user_id],$lv[user_id])";
																		  
					$this->rdsql->exec_query($lv['ins_ec_query'],"Error in ec insertion ".$lv['ins_ec_query']);
									
					// get last insert id
					$lv['entity_child_id'] = $this->rdsql->last_insert_id('entity_child'); 										
											
					// traverse each column
					foreach($param['table_fields'] as $col_token => $col){
						
						$lv['col_field_value']= (@$col['default']) ?? ($fields[$col['idx']]);
						
						$lv['col_field_value']= (@$col['pre_check'])?$col['pre_check'](['col_value'=>$lv['col_field_value'],
																						'g' => $this,
																						'rdsql'=>$this->rdsql,
																						'rows'=>$fields,
																						'user_id'=>$lv['user_id'],
																						'key_id'=>$param['key_id']
																					   ]):$lv['col_field_value'];
						
						
						if(@$col['filter_in']){
							$lv['col_field_filtered_value']=(@$col['filter_addon'])?$col['filter_in']($lv['col_field_value'],$col['filter_addon']):$col['filter_in']($lv['col_field_value']);
						}else{
							$lv['col_field_filtered_value']= $lv['col_field_value'];
						}

						$lv['ec_type'] = (@$col['is_core'])?'eav':((@$col['is_temp'])?'ectv':'exav');
						
						array_push($lv['table_type'][$col['addon_type']]['data'][$lv['ec_type']], 
								  "($lv[entity_child_id],'$col_token','$lv[col_field_filtered_value]',$lv[user_id])");
								  
					  	array_push($lv['ent_child_id'],$lv['entity_child_id']);
					
					} // each column 
						
					$lv['counter']['accept']++;
						
				}else{
					
					$lv['counter']['reject']++;
					
				} // end if exist case
						   
			} //end of each data traverse
			
			// ec info
			   
			$ec_map = ['eav'	=> ['parent_field'=>'parent_id',
									'child_token_field'=>'ea_code',
									'child_value_field'=>'ea_value'
									],
									
						'exav'	=> ['parent_field'=>'parent_id',
									'child_token_field'=>'exa_token',
									'child_value_field'=>'exa_value'],
									
						'ectv'	=> ['parent_field'=>'parent_id',
									'child_token_field'=>'ect_token',
									'child_value_field'=>'ect_value']
						];
			   
			foreach($lv['table_type'] as $table_type_name=>$table_type_addon){
				
				foreach($ec_map as $ec_type=>$ec_map_info){
					
					//type exists check
					if(@$lv['table_type'][$table_type_name]['data'][$ec_type]){
					
						if(count($lv['table_type'][$table_type_name]['data'][$ec_type])>0){
						
							$lv['items'] 		=	implode(",",$lv['table_type'][$table_type_name]['data'][$ec_type]);
							
							//$lv['escaped_string_items'] = $this->rdsql->escape_string($lv['items']);
								 
							$lv['token_field'] 		= 	$ec_map_info['child_token_field'];
								 
							$lv['value_field']		= 	$lv['table_type'][$table_type_name]['field_name'] ?? $ec_map_info['child_value_field'];
							
							$lv['ins_ec_value_query']    = 	" INSERT INTO ".$ec_type."_addon_".$table_type_name.
															" (parent_id,$lv[token_field],$lv[value_field],user_id) VALUES $lv[items]";
																					  
							$this->rdsql->exec_query($lv['ins_ec_value_query'],"Error in ec value insertion ".$lv['ins_ec_value_query']);										
						}//end if
						
					} // element exists
					
				}//end each ec_type
								
			} //end each field insertion
			

			if(@$param['get_qa']){
				return $lv['counter'];
			}else{
				if(count($param['table_data'])>1){				
					return $lv['ent_child_id'];				
				}else{
					return $lv['entity_child_id'];
				}	
			}							
				
		} //end	


		function generateSerialNum($param){
	
			$lv=[];
			
			$lv['serial_num']=$this->get_one_column(['field'=>'IFNULL(exa_value,0)','table'=>'exav_addon_num',
																 'manipulation'=>" WHERE exa_token='$param[token]' ORDER BY parent_id DESC LIMIT 0,1"]);
																 
								if($lv['serial_num']){				
									$lv['serial_num']=$lv['serial_num']+1;				
								}else{
									$lv['temp_serial_num']=$this->get_one_column(['field'=>'entity_value','table'=>'entity_key_value', 
																		  'manipulation'=>" WHERE entity_code='$param[entity_code]' AND entity_key='$param[entity_key]'"]);
									$lv['serial_num']=$lv['temp_serial_num']+1;		
								}
								
						 $lv['snum_insert_query']= "INSERT INTO
																exav_addon_num(parent_id,exa_token,exa_value,user_id)
															VALUES
																($param[key_id],'$param[token]',$lv[serial_num],$param[user_id])";
																
							$this->rdsql->exec_query($lv['snum_insert_query'],'Q'); 
								
								
						return ($lv['serial_num']);
						
			
		} 
	
} // end of class


	$EC = new EntityChild();	

?>