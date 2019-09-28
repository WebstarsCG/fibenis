<?PHP
       
	 
        $A_SERIES       =   array(
		
		
					'UNIA'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = $param['data'];
									
																		
													
									$param['rdsql']->exec_query("UPDATE
												user_info
											   SET
												is_active=0
											   WHERE
												id IN ($inline_param)
											   ",'0');
									
									# one column
									
									return 1;
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
					'UNIB'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = $param['data'];
									
																		
													
									$param['rdsql']->exec_query("UPDATE
												user_info
											   SET
												is_active=1
											   WHERE
												id IN ($inline_param)
											   ",'0');
									
									# one column
									
									return 1;
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
					// Welcome Message
					
					'UWEL'=>function($param){
						
						
						
						
							$current_time	= date('is');
								
							$pass		= "0".$current_time;
											
							$new_key	= substr($pass,0,6);
								
							$password  	=   md5($new_key);
							
							$def = array( 'user_name'  => $_GET['user_name'],
								      'user_email' => $_GET['user_email'],
								      'user_key'   => $new_key,				      
								      'domain_name' =>  get_config('domain_name'),
								      
								     );
							$msg = custom_mail_message($def);
							#echo $msg['REG_MSG'];
							$MAIL=array(
												'from'    => $SG->get_session('mail_send_by').'  Admin ',					
												'to'      => $_GET['user_email'], //'ratbew@gmail.com',
												'cc'	  =>  get_config('cc_mail'),
												'bcc'	  => get_config('bcc_mail'),
												'subject' => $SG->get_session('mail_send_by').' - Registration information',					
												'message' =>$msg['REG_MSG']
															  
										);
							//select mail
							$id = $G->get_one_columm($param=array('field' =>'id', 'table'=>'user_info', 'manipulation'=>" WHERE user_comm = '$_GET[comm_id]'"));
							
							$mail_param=array('user_id'=>$id,'page_code'=>'AWSM','action_type'=>'AJAX','action'=>'Registration information  By admin <br>'.$msg['REG_MSG']);
											 
							$G->set_system_log($mail_param);
							
							/*$mail_param=array('user_id'=>$id,'page_code'=>'AACT','action_type'=>'AWSM','action'=>'Registration information  By admin <br>'.$msg['REG_MSG']);
											 
							$G->set_system_log($mail_param);*/
							
							if($P_V['is_smtp_mail']){
								
								mail_send_smtp($MAIL);
							    
								$mail_param=array('user_id'=>$id,'page_code'=>'AWSM','action_type'=>'AJAX','action'=>'Mail send WSM');
											     
								$G->set_system_log($mail_param);
									    
							}
							else{
							
							  $send = $G->mail_send($MAIL);
							  
							  $mail_param=array('user_id'=>$id,'page_code'=>'AWSM','action_type'=>'AJAX','action'=>'Mail send WSM');
											 
							  $G->set_system_log($mail_param);
							}
							
							$update = "UPDATE user_info SET password='$password',is_active =1, is_send_welcome_mail=1 WHERE user_comm = '$_GET[comm_id]'";
									
							$rdsql->exec_query($update,'Error! WSM');
							
							
							echo "Successfully mail send";
						
						
		}
					
					

        ); # end
	
	
	
	
	
    
?>