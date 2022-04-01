<?PHP

    include_once($LIB_PATH."/inc/lib/f_addon.php");
             
																           
	$F_SERIES	=	array(

		'title'	=>'RO UPS',
		
		'gx'=>1,

		'data'  => array(),
									
		'table_name'=> 'entity_child',
									
		'key_id'  => 'id',
									
		'is_user_id' => 1,
		
		'is_created_by' =>1,

		'add_button' => array( 'is_add' =>1),

		'back_to'  => array( 'is_back_button' =>1),
									
		'prime_index' => 1,
		
		 //'js'=> ['is_top'=>1,'top_js'=>'fx'],

       
         'button_name' =>'Add Call',
		'default_fields' =>array('entity_code' => 'RU'),
		
		'aviod_trans_key_direct'=>0,
		//'show_query'=>1,
		'is_field_id_as_token'=>1,

		);


		// default addon				

		@$F_SERIES['temp'] =f_addon(['g'		   => $G,
									'rdsql'		   => $rdsql,
									'f_series'     	   => ['data'=>$F_SERIES['data']],
									'default_addon'	   => json_encode(['en'=>'RU'])
		]);

		$F_SERIES['data']  = @$F_SERIES['temp']['data'];
								
								
				if(@$_POST['key']){
				
					$F_SERIES['data'][7]['is_hide']=0;
				}
								
				$F_SERIES['after_add_update'] = function($key_id){

							global $USER_ID,$F_SERIES,$rdsql,$G,$SG;
		
							$lv = [];
							$lv['map'] = ['rust'=>'X6',
										  'rucm'=>'X8'
										 ];
										 
							if(empty($_POST['key'])){			
					
								// status log			
								$lv['test_status_log_query']	=	"INSERT INTO
																		status_info(status_code,entity_code,child_comm_id,note,user_id)
																	VALUES
																		('RUSTNW','RU',$key_id,'Ticket Raise',$USER_ID)";			
								
								$rdsql->exec_query($lv['test_status_log_query'],'Query');
								
											
								// serial no
								$lv['srno']=$G->get_one_column(['field'=>'IFNULL(exa_value,0)','table'=>'exav_addon_num',
																 'manipulation'=>" WHERE exa_token='RUSNO' ORDER BY parent_id DESC LIMIT 0,1"]);
																 
								if($lv['srno']){				
									$lv['srno']=$lv['srno']+1;				
								}else{
									$lv['temp_srno']=$G->get_one_column(['field'=>'entity_value','table'=>'entity_key_value', 
																		  'manipulation'=>" WHERE entity_code='RU' AND entity_key='serial_num_start'"]);
									$lv['srno']=$lv['temp_srno']+1;		
								}
					
								// serial no. query
								$_SESSION['test_no'] = $lv['srno'];
								$lv['test_sno_query']= "INSERT INTO
																exav_addon_num(parent_id,exa_token,exa_value,user_id)
															VALUES
																($key_id,'RUSNO',$lv[srno],$USER_ID)";
																
								$rdsql->exec_query($lv['test_sno_query'],'Q'); 
								
							}//end of empty key
								
						else if(@$_POST['key'] && @$_POST['UPDATE']){
						
							$lv['rust'] = $_POST[$lv['map']['rust']];
							$lv['rucm'] = $_POST[$lv['map']['rucm']];
				
								// status log
								$lv['test_status_log_query']	=	"INSERT INTO
																		status_info(status_code,entity_code,child_comm_id,note,user_id)
																	VALUES
																		('$lv[rust]','RU',$key_id,'".$rdsql->escape_string($lv['rucm'])."',$USER_ID)";			
								
								$rdsql->exec_query($lv['test_status_log_query'],'Query');
					}
				}//End of After Add Update function
				
				?>              