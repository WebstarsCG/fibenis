<?PHP
						
		ini_set('display_errors', 1);		
		
		error_reporting(E_ALL);
		
		$ACCESS_KEY;
		
		$PV = [];
		
		# gateaction - md5(GATE_<code>)
		$PV['GATE_CODE'] = ['AAKY' => 'e89a83384d48a4ac572bc84fc468ed9d', # add key
				    'AAKV' => '226d370c039d2ab26f7d6c776dc09952', # key verification
				    'ACKY' => '7f84cf049cd1ca1ec04c0150d4d0c356', # Check Password/User
				    'ACHP' => 'f68a5834818e3b481d2108e3fb0ea5a3', # change password
				    'AFGK' => 'db3aeab2d92092e5586b7375fd885ba0', # forget password
				    'AGTO' => '2d4a92e779d30cc823a3feffafa56c8c', # logout
				    'ACUE' => 'e9eb891ad083d2470230f6a4b61528ae'
				];
		
		if(@$_POST['request'] OR @$_GET['request']){
				
				include("config.php");

				include("../../fE7zRhHqYfSLT9CRm55cBPGHjAGuhqhhjKGSZrB.php");
					
				$CRm55cBPGH 		=  get_temp_config($temp_config);
			
				$get_db_conn 		=  get_config('db_engine').'_connection';
				
				$db_conn_info 		=  $get_db_conn();			
				
				$PV['plugin_path'] 	=  get_config('plugin_path');
				
				$PV['domain_name'] 	=  get_config('domain_name');
				
				$PV['lib_path']    	=  get_lib_path();
				
				include("../../".$PV['lib_path']."inc/lib/".get_config('db_engine').".php");
				
				include("../../".$PV['lib_path']."inc/lib/general.php");
		
				include("../../".$PV['lib_path']."inc/lib/s_gate.php");
				
				include("../../".$PV['lib_path']."comp/PHPMailer/smtp.php");
				
				# coach
				
				$COACH=[];
				
				$COACH['domain_name']		=   (get_config('is_multiple')==1)?str_replace("www.","",$_SERVER['HTTP_HOST']):'default';
				
		    
				list($COACH['id'],
				     $COACH['name']) =    explode('[C]',$G->get_one_cell(['table'        => 'entity_child',
								      'field'        => "concat(id,'[C]',get_eav_addon_vc128uniq(id,'CHCD'))",
								      'manipulation' => " WHERE get_eav_addon_varchar(id,'CHDN') ='$COACH[domain_name]' ",
						    ]));
						
					
							    
				$COACH['name_hash']     =   md5($COACH['name']);
								
				$PV['login_table'] 	= 'user_info';
				
				$PV['login_email'] 	=  "get_eav_addon_varchar(is_internal,'COEM')";
				
				$PV['login_name']  	=  "get_eav_addon_varchar(is_internal,'COFN')";
				
				$SG->set_get_master_session($COACH['id']);
				
		}	
		
		
		//sign up data
		
		if(@$_POST['action']=='AKY'){
				
				$user_name  =   $_POST['user_name'];
				
				$user_email = strtolower($_POST['user_email']);
				
				$user_mobile = strtolower($_POST['mobile']);
				
				$entryType  =   $_POST['entryType'];
				
				$password   =   md5($_POST['user_key']);
				
				$no_row = $G->table_no_rows(
				 					array(
											'table_name' =>$PV['login_table'],
									
										  	'WHERE_FILTER'=>" AND $PV[login_email]='$user_email'"
										  )
									
				 				  );
				if($no_row[0]==0){
					
					//$session = $SG->set_session();
					
						// insert user
						
						$insert_contact_query="INSERT INTO
										entity_child(entity_code,user_id)
								       VALUES
										('CO',0)";						
					
						$rdsql->exec_query($insert_contact_query,"");
						
						$contact_id = $rdsql->last_insert_id('entity_child');
						
						# insert detail
						
						$insert_contact_detail="INSERT INTO
										eav_addon_varchar(parent_id,ea_code,ea_value)
								       VALUES
										($contact_id,'COFN','$user_name'),
										($contact_id,'COEM','$user_email'),
										($contact_id,'COMB','$user_mobile')
								";						
					
						$rdsql->exec_query($insert_contact_detail,"");
					
						$set_data = "INSERT INTO
									 user_info(password,user_role_id,is_internal)
								     VALUES
									 ('$password',(SELECT id FROM user_role WHERE sn='BAS'),$contact_id)";
							
						
						$exe_set_data = $rdsql->exec_query($set_data,'set data');
						
						$last_id      = $rdsql->last_insert_id('user_info');
						
						$param	      = array('user_id'=>$last_id,'page_code'=>$PV['GATE_CODE']['AAKY'],'action_type'=>'AAKY','action'=>'Sign Up by  '.$user_email);
								 
						$G->set_system_log($param);
					
					
					$def = array('user_id' =>$last_id);
					
					$crypt_id = $G->generate_hash($def);
					
					$PROFILE_KEY = get_config('PROFILE_KEY').$last_id;
					
					$update_last_data = "   UPDATE
										user_info
								SET
										user_comm = '$crypt_id',
										is_send_welcome_mail=1
								WHERE
										id = $last_id ";
					
					$rdsql->exec_query($update_last_data,'$update_last_data');
					
					//send mail
					$def = array( 'user_name'  => $user_name,
						     'user_email' => $user_email,
						     'user_key'   => $_POST['user_key'],
						     'domain_name' => $PV['domain_name'],
						    
						   );
					$msg = custom_mail_message($def);
					
					//echo $msg['REG_MSG'];
					$MAIL=array(
								'from'    => $SG->get_session('mail_send_by').'  Admin ',					
								'to'      => $_POST['user_email'], //'ratbew@gmail.com',
								'cc'	  =>  get_config('cc_mail'),
								'bcc'	  => get_config('bcc_mail'),
								'subject' => $SG->get_session('mail_send_by').' | Registration Confirmation',					
								'message' =>$msg['REG_MSG']
											  
						);
					
					
					
					if($PV['is_smtp_mail']){
						
					    mail_send_smtp($MAIL);
					    
					    $mail_param=array('user_id'=>$last_id,'page_code'=>$PV['GATE_CODE']['AAKY'],'action_type'=>'AAKY','action'=>'Mail->Sign Up by '.$user_email.$msg['REG_MSG']);
						         
					    $G->set_system_log($mail_param);
					
					
					}
					else{
					    $send = $G->mail_send($MAIL);
					    
					     $mail_param=array('user_id'=>$last_id,'page_code'=>$PV['GATE_CODE']['AAKY'],'action_type'=>'AAKY','action'=>'Mail->Sign Up by '.$user_email.$msg['REG_MSG']);
						         
					     $G->set_system_log($mail_param);
					}
					echo 1;
					
				}//if
				
				else{
						
					echo 0;	
				}
				
				
				
				
		}
		
		
		//key verification
		if(@$_GET['action']=='KV'){
			
			$user_email = strtolower( $_GET['user_email']);
			
			$mail_crypt =  base64_encode($user_email);
			
			$no_row = $G->table_no_rows(
				 					array(
											'table_name' =>$PV['login_table'],
									
										  	'WHERE_FILTER'=>" AND $PV[login_email]='$user_email' AND is_active=1 ",
											
											//'show_query' =>1
											
										  )
									
				 				  );
			
			//echo $no_row[0];
			if($no_row[0]>0){
				
				//base64_encode
				header('Location:'.$PV['domain_name'].'?e_mail='.$mail_crypt);
				
			}
			else{
			
				$update = "UPDATE user_info SET is_active=1 WHERE $PV[login_email] = '$user_email' ";
				
				$exe_update = $rdsql->exec_query($update,'Error! KV');
				
				$param=array('user_id'=>$no_row[1],'page_code'=>$PV['GATE_CODE']['AAKV'],'action_type'=>'AAKV','action'=>'Active login user '.$user_email);
						         
				$G->set_system_log($param);
					
				
				//base64_encode
				header('Location:'.$PV['domain_name'].'?e_mail='.$mail_crypt);
			}
			
		}		
		
		
		// sign in
		if(@$_POST['action']=='CKY'){
				
				
				
				$user_email  	= strtolower($_POST['user_email']);
				
				@$password   	= md5($_POST['password']);				
				
				$user_def 	= array(
								'user_email' => $user_email,
								'password'   => @$password ,
								'user_type'  => 0
						);
				
				$PV['table_name']      = $PV['login_table'];
				
				$PV['login_key_field'] = $PV['login_email'];
				
				$PV['login_name']      = "$PV[login_name] as 'login_name'";
				
				$PV['user_key1'] = $rdsql->escape_string(stripslashes($user_email));
				 
				$PV['user_key2'] = $rdsql->escape_string(stripslashes(md5($_POST['password'])));
				
				#print_r($PV);
				
				$select_data = "SELECT
								id,
								$PV[login_key_field],
								$PV[login_name],
								is_active
						FROM
								$PV[login_table]
						WHERE
								$PV[login_key_field]='$PV[user_key1]' AND password='$PV[user_key2]'";
				
				$exe_select_data = $rdsql->exec_query($select_data,'Error! CK');
				
				$get_row =  $rdsql->data_fetch_object($exe_select_data);
				
				if(@$get_row->id){
					
					if($get_row->is_active){
						
					# echo user_role
					// page_redirect($user_role_code);
					 $session = $SG->set_session();
					 					 
					 $_SESSION['COMM_KEY'] = md5($get_row->id);
					  
					 $page_name =  $_SESSION['home_page_url'];
		         					 
					  $update_query="UPDATE user_info SET last_login= NOW() WHERE id =$get_row->id";
					  
					  $exe_up_query = $rdsql->exec_query($update_query,'Error! CK Update');

					  $param=array('user_id'=>@$get_row->id,'page_code'=>$PV['GATE_CODE']['ACKY'],'action_type'=>'ACKY','action'=>'login');
						         
					  $G->set_system_log($param);
					 
				          echo '{"status":"1","redirect_page":"'.$page_name.'"}';
					
					}else{
					
					  echo '{"status":"-2"}';
					  
					   $param=array('user_id'=>@$get_row->id,'page_code'=>$PV['GATE_CODE']['ACKY'],'action_type'=>'ACKY','action'=>'Login failed for In-active user '.$user_email);
						         
					   $G->set_system_log($param);
					
					}
				
				}else{
				      echo '{"status":"-1"}';
				      
				      $param=array('user_id'=>@$get_row->id,'page_code'=>$PV['GATE_CODE']['ACKY'],'action_type'=>'ACKY','action'=>'Login fail for invalid user '.$user_email);
						         
				      $G->set_system_log($param);
				}				 
		}
		
	
		
		
		// change password
		
		if(@$_POST['action']=='CP'){
				
			$old_pswrd  =  md5($_POST['old_pswrd']);
			
			$user_email  = strtolower($_POST['user_email']);
			
			
			
			$no_row = $G->table_no_rows(
				 					array(
											'table_name' =>$PV['login_table'],
									
										  	'WHERE_FILTER'=>" AND $PV[login_email]='$user_email' AND password='$old_pswrd' AND is_active=1"
										 )
									
				 				  );
			
			if($no_row[0]==1){
				if($old_pswrd &&  ($_POST['new_pswrd'] ==  $_POST['cnfrm_pswrd']) ){
											
					$password  	=  md5($_POST['new_pswrd']);
					
					$update_psswrd  = "UPDATE user_info SET password='$password' WHERE $PV[login_email] = '$user_email' AND is_active=1";
					
					$rdsql->exec_query($update_psswrd,'Error! CP');
					
					$param		= array('user_id'=>$no_row[1],'page_code'=>$PV['GATE_CODE']['ACHP'],'action_type'=>'ACHP','action'=>'Active login user '.$user_email);
						         
				        $G->set_system_log($param);
						
					echo '{"status":"1","message":"Successfully changed your password"}';
				}
					
			}
			else{
				
				 echo '{"status":"0","message":"Please check your old password"}';
			}
			
		}
		
		
		// forget password
		if(@$_POST['action']=='FK'){
				
				$user_email 		= strtolower($_POST['user_email']);
				
				$current_time	= date('is');
								
				$pass		= "0".$current_time;
							
				$new_key	= substr($pass,0,6);
				
				$password  	=   md5($new_key);
				
				#echo  $PV['login_table']." AND emai='$user_email'  AND is_active=1";
				$no_row = $G->table_no_rows(
				 					array(
											'table_name' => $PV['login_table'],
									
										  	'WHERE_FILTER'=>" AND $PV[login_email]='$user_email'  AND is_active=1",
											'show_query'  =>0
										 )
									
				 				  );
				
				//echo $no_row[0];
				if($no_row[0] ==1){
						
					$update_fk_pswrd = "UPDATE user_info SET password='$password' WHERE $PV[login_email] = '$user_email' AND is_active=1";
					
					$rdsql->exec_query($update_fk_pswrd,'Error! FK');
					
					
					//select data
					
					$select_info = "SELECT $PV[login_name] as user_name FROM user_info WHERE  $PV[login_email]='$user_email' AND is_active=1 ";
					$sele_exe_query = $rdsql->exec_query($select_info,'Error! Select ');
					
					$get_row = $rdsql->data_fetch_object($sele_exe_query);
					
					
					
					$def = array( 'user_name'  => $get_row->user_name,
						     'user_email' => $user_email,
						     'user_key'   => $new_key,
						     
						   );
					$msg = custom_mail_message($def);
					
					
					
					
					$param=array('user_id'=>$no_row[1],'page_code'=>$PV['GATE_CODE']['AFGK'],'action_type'=>'AFGK','action'=>'Forgot password '.$user_email);
						         
				        $G->set_system_log($param);
					
				
                                      //   echo $msg['FK_MSG'];
					$MAIL_FK=array(
								'from'    => $SG->get_session('mail_send_by').' Admin ',					
								'to'      => $user_email, //'ratbew@gmail.com',
								
								'cc'	  =>  get_config('cc_mail'),
								'bcc'	  => get_config('bcc_mail'),
								
								'subject' =>  $SG->get_session('mail_send_by').' - Forgot password',
								'message' => $msg['FK_MSG'],
							);
					
					
					
					
					if($PV['is_smtp_mail']){		
						$send = mail_send_smtp($MAIL_FK);
						
						$mail_param=array('user_id'=>$no_row[1],'page_code'=>'GATE','action_type'=>'FMAL','action'=>'Forgot password <br>'.$msg['FK_MSG']);
						         
						$G->set_system_log($mail_param);
					}
					else{
						$send = $G->mail_send($MAIL_FK);
						
						$mail_param=array('user_id'=>$no_row[1],'page_code'=>'GATE','action_type'=>'FMAL','action'=>'Forgot password <br>'.$msg['FK_MSG']);
						         
						$G->set_system_log($mail_param);
					}
						
					echo 1;
						
				}
				else{
					echo 0;	
				}
				
	
		}
		
		
		if(@$_POST['action']=='GTO'){
				
			//echo $_GET['uid'];
			
			$param=array('user_id'=>$_POST['uid'],'page_code'=>$PV['GATE_CODE']['AGTO'],'action_type'=>'AGTO','action'=>'Logout ');
						         
			$G->set_system_log($param);
		        get_out();
		}
		
		function get_out(){
		        
			global $PV;
			
			$USER_ID 	= 0;			
			$USER_NAME 	= '';
			
			session_start();
			
			session_destroy();
						
			header('Location:'.$PV['DOMAIN_NAME'].'/index.php');
			return $USER_ID=0;
			
		} // get out
	
	
		if(@$_POST['action']=='CUE'){
			
			$user_email      =  @$_POST['user_email'];
					
			$is_ext          =  @$_POST['is_ext'];
			
			$no_row = $G->table_no_rows(
							array(
									'table_name' => $PV['login_table'],
							
									'WHERE_FILTER'=>" AND $PV[login_email]='$user_email'  AND is_active=1"
								 )
							
						  );
			
			if($no_row[0]){
			  echo 1;
			}else{
			  echo 0;		
			}
		}
		
?>