<?PHP

    $default_addon = $_GET['default_addon'];
    
    $temp = explode(':',$default_addon);
    
    $status_code = $temp[0];
    
    $entity_child_id=$temp[1];
     
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
							       
								    'option_data'=>$G->option_builder('entity_child_base','token,sn',
												      "WHERE token IN (SELECT status_code_end FROM status_map
												      WHERE status_code_start='$status_code') ORDER BY sn ASC"),
								 
								    'is_mandatory'=>1,
                                                               
								    'input_html'=>'class="w_200"'
								    
                                                               ),
						   
					    ),
				
                                    
				#Table Name
				
				'table_name'    => 'status_info',
				
				#Primary Key
                                
			        'key_id'        => 'id',
				
				'default_fields'    => array(
							    'entity_code' => "'IU'",
							    'child_comm_id' => "'$entity_child_id'",
							    ),
				
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
				
				'back_to'  => NULL,
				
				'show_query' => 1,
                               				
				'flat_message' => 'Sucesssfully Updated',
				
				'show_query'    =>0,
				
				'after_add_update'=>1,
                                
			);
    
     function after_add_update($key_id){
	
	    global $rdsql;
	    
	    //$current_status = $_POST['X2'];
	    
	    $status_info = $rdsql->exec_query("SELECT status_code,entity_code,child_comm_id FROM status_info WHERE id=$key_id","GET STATUS DETAILS");
		
	    $status_info_row=$rdsql->data_fetch_row($status_info);
	    
	    $update = $rdsql->exec_query("UPDATE exav_addon_exa_token SET exa_value_token = '$status_info_row[0]' WHERE exa_token = 'ISST'  AND parent_id = '$status_info_row[2]'","Updation Failed");
	    
	    return null;	
		
    } 
?>