<?PHP

   
    
     
    //$entity_code = substr($temp[0],0,2);
    
    $LAYOUT	    = 'layout_full';
                            
    $F_SERIES	=	array(
				#Title
				
				'title'	=>'Status',
				
				#Table field
                    
				'data'	=>   array(
						   
						   
						   '1' =>array( 'field_name'=> 'Detail ',
                                                               
								'field_id' => 'note',
                                                               
								'type' => 'textarea',
                                                               
                                                                'is_mandatory'=>0,
                                                               
                                                             ),
						   
						   '2' =>array(     'field_name'=>'Status',
                                                               
								    'field_id'=>'status_code',
                                                               
								    'type' => 'option',
							    
								 
								    'is_mandatory'=>1,
                                                               
								    'input_html'=>'class="w_200"'
								    
                                ),
								
							'3' =>array(     'field_name'=>'Status',
                                                               
								    'field_id'=>'parent_id',
                                                               
								    'type' => 'hidden',
							       
								 
								   
								   'ro'=>1
                                  
								    
                                ),
						   
					    ),
				
                                    
				#Table Name
				
				'table_name'    => 'status_info',
				
				#Primary Key
                                
			        'key_id'        => 'id',
				
				'default_fields'    => array(
							    'entity_code' => "'IU'",
							    'child_comm_id' => '',
							    ),
				
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
				
				'back_to'  => NULL,
				
				'show_query' => 1,
                               				
				'flat_message' => 'Sucesssfully Updated',
				
				'show_query'    =>0,
				
				'after_add_update'=>1,
				
				//'get_last_insert'=>1,				
				
				'is_cc'=>1,

				'js'=>['is_top'=>1],
				
				'is_field_id_as_token'=>1,

				'send_to_parent'=>['status_update'=>1],
                                
			);
			
	$F_SERIES['temp']['ec_id'] = $G->getCleanNum(@$_GET['default_addon']);
			
	// addon
	if(@$F_SERIES['temp']['ec_id']){
		
		
		$F_SERIES['temp']['status'] = $G->get_one_column(['table'=>'entity_child',
														  'field'=>"get_exav_addon_exa_token(".$F_SERIES['temp']['ec_id'].",'ISST')",
														  'manipulation'=>' WHERE id= '.$F_SERIES['temp']['ec_id']
														]);
														
														
		if(@$F_SERIES['temp']['status']){
		
			$F_SERIES['data'][2]['option_data']=$G->option_builder('entity_child_base',
																   'token,sn',
																  " WHERE token IN (SELECT 
																						status_code_end 
																					FROM 
																						status_map
																				   WHERE 
																	status_code_start='".$F_SERIES['temp']['status']."')
																	ORDER BY
																		sn ASC");
		}
																	
		$F_SERIES['data'][3]['attr']['value']			= 	$F_SERIES['temp']['ec_id'];
		$F_SERIES['default_fields']['child_comm_id']	=	$F_SERIES['temp']['ec_id'];
	
	} // end
			
     function after_add_update($key_id){
	
	    global $rdsql,$G,$F_SERIES;
	    
	    //$current_status = $_POST['X2'];
	    
	    $status_info = $rdsql->exec_query("SELECT status_code,get_ecb_sn_by_token(status_code),child_comm_id FROM status_info WHERE id=$key_id","GET STATUS DETAILS");
		
	    $status_info_row=$rdsql->data_fetch_row($status_info);
	    
	    $update = $rdsql->exec_query("UPDATE exav_addon_exa_token SET exa_value_token = '$status_info_row[0]' WHERE exa_token = 'ISST'  AND parent_id = '$status_info_row[2]'","Updation Failed");
	    
		if(@$F_SERIES['send_to_parent']){
			
			$temp= ['status_code'=>$status_info_row[0],
					'status_name'=>$status_info_row[1]];
			
			$F_SERIES['send_to_parent']=array_merge($F_SERIES['send_to_parent'],$temp);

		} // end

	    return null;		
    } 
	
?>
