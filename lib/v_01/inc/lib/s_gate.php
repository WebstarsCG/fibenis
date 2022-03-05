<?PHP
		
	#define class
	
	$SG = new Session_Gate();
	
	class Session_Gate{
				
				protected $rdsql;	 
				 				
				function __construct(){	
				
					$this->rdsql = new rdsql();	
					$this->g 	 = new General();	
				}	
				
				//set the session variable for user_info & user_permission
				function set_session($param){
							
						   global $rdsql;	
						   
						   global $PV;
						   
						   global $COACH;
						   
						   $active ='';
						   
						   //$internal=1;
						   
						   $internal=get_config('is_internal');
						   
						   $parent  =get_config('is_parent');
						   
						   
						// Login Neutral   
						//   $communication = (@$internal==1)?',communication_id,
						//			(SELECT sn FROM user_role WHERE id=user_role_id) as user_role,
						//			(SELECT sn FROM communication WHERE id=communication_id) as user_name':',(SELECT sn FROM user_role WHERE id=user_role_id)as user_role,user_name';
						//			
			                           #$communication.= (@$parent==1)?',(SELECT parent_id FROM communication WHERE id=communication_id) as parent_id ':'';
						   
						    
						   
						         $sql_user_info="SELECT 
											id,											
											get_eav_addon_varchar(is_internal,'COEM') as email,
											get_eav_addon_varchar(is_internal,'COFN') as user_name,
											is_active,
											(SELECT sn FROM user_role WHERE id=user_role_id) as user_role,
											user_role_id,											
											is_internal,
											(SELECT home_page_url FROM user_role WHERE user_role.id=user_role_id) as home_page_url
									 FROM 
											$param[table]											
									 WHERE 1=1 
											AND is_active =1 AND id=$param[id]";
											
									
							$exe_query = $rdsql->exec_query($sql_user_info,'user detail-->');
									
							$get_user_row = $rdsql->data_fetch_object($exe_query);
							
							// session id generate
							session_commit(); //  close the current sessions
							$session_id = session_id($this->g->hashKeyGenerator($get_user_row->id,$get_user_row->email));
							session_start();
							
							//$_SESSION['communication_id']= @$get_user_row->communication_id;
							
							$_SESSION['user_role']	     = @$get_user_row->user_role;
							
							$_SESSION['user_role_id']    = @$get_user_row->user_role_id;
							
							$_SESSION['user_id']	     = @$get_user_row->id;
							
							$_SESSION['user_name'] 	     = @$get_user_row->user_name;
							
							$_SESSION['PASS_ID']	     = $session_id;
							
							$_SESSION['user_email']	     = @$get_user_row->email;
							
							$_SESSION['home_page_url']   = @$get_user_row->home_page_url;
							
							#earlier session stored check,replaced by live check
							#$this->user_role_permission(@$get_user_row->user_role_id);
							
							$_SESSION['gate']			 = @$param['gate'];
							
							// domain
							
							$_SESSION[$COACH['name']]    = $COACH['name_hash'];
							
							if($parent){							
									$_SESSION['parent_id'] = @$get_user_row->parent_id;
							}
							
							# master cookie
							
							$this->set_get_master_session($COACH['name_hash']);
							
						         return array($_SESSION['user_id'],
								      $_SESSION['user_name'],
								      $_SESSION['user_email'],
								      $_SESSION['PASS_ID'],								      
								      $_SESSION['user_role']);
				
			} //end of set the session variable 
				
		   //get permission page for accessing
		    function get_user_detail(){
            
					#session_start();
					#echo     $_SESSION['user_email'];

					if(@$_SESSION['user_id']){
						
						return array($_SESSION['user_id'],
							     $_SESSION['user_name'],
							     $_SESSION['user_email'],							     
							     $_SESSION['PASS_ID'],							     
							     $_SESSION['user_role']);  
			}           
              
           			 return NULL;
		     } // end of get user detail
		   
		   
		   function s_destroy($redirect){
		   
		   		session_destroy();
				
				header('Location:'.$redirect.'');
				
				unset($_SESSION);
		   }//end of session destroy
		  
		   //define the user permission function
		   //get the user_id
		   //and check permission page for user
		   //display the permission page
		   function user_role_permission($user_role_id){
			
						global $rdsql;
						
						$user_permission = array();
						
						if($user_role_id){
						
									$user_role_filter  = ($user_role_id)?" AND user_role_id = $user_role_id":'';
						
									$sql =  "SELECT 
											id, user_role_id,(SELECT parent_child_hash FROM ecb_parent_child_matrix WHERE id = user_permission_id) as permission, user_permission_id
										FROM 
											user_role_permission_matrix WHERE 1=1 ".$user_role_filter;
										
										$exe_query = $rdsql->exec_query($sql,"Error in user_role permission function");		
										
										
										
									while($get_perm = $rdsql->data_fetch_object($exe_query)){
										
										$temp = array();
										
										array_push($user_permission,$get_perm->permission);
										
										$_SESSION[$get_perm->permission]=1;
									}
						}
						
						return 1;
			
			} //end
		
		   
			//define the function for user to view the permission page only
			//give the permission page
			//check the session for the permission page
			//and permission page set 1 as flag
			//return the permission page flag
			function get_permission($perm){
			     
				     if(@($_SESSION[$perm])){
					     
					     return $perm=1;
				     }else{
					     
					     return $perm=0;
			             }
			    
			      return $perm;
		        }//end of get_permission


			//getpermissiondirect
			function get_permission_direct($page_code){
						
				 $lv = [];		
						
				$lv['permission_query'] = "SELECT
									id
						            FROM
									user_role_permission_matrix
						            WHERE
									user_role_id=$_SESSION[user_role_id] AND
									user_permission_id=(SELECT
												      id
									                    FROM
												       ecb_parent_child_matrix
									                    WHERE
												        parent_child_hash='$page_code')";		
			
			          		$lv['exec_query'] = $this->rdsql->exec_query($lv['permission_query'],'permission check');
									
						$lv['permission'] = $this->rdsql->data_fetch_assoc($lv['exec_query']);
									  							
						return ($lv['permission']['id'])?1:0;
						
			} // code

			

			       
			       function check_entry($perm){
						
				     if($perm!=1)
				     {
					return header('Location:index.php');
				     }
			       }//end of check permission entry
			
			// get master info
			function get_master_info($domain_hash){
			  
						global $rdsql;	
					   	
						$lv = [];
						
						if($domain_hash){
						
									
						
									$select_sql = "SELECT id,									      
											      entity_key,
											      entity_value
											FROM
											      entity_key_value
											WHERE
											     entity_code = 'MP' AND domain_hash='$domain_hash'";
									
									$exe_query = $rdsql->exec_query($select_sql,'master detail-->');
									
									
									while($master_row = $rdsql->data_fetch_object($exe_query)){
									  
											$lv[$master_row->entity_key]=$master_row->entity_value;
									 
									} // end
									
						}
						
						return $lv;						
			}
				  
			
			
			// set get master session
			function set_get_master_session($coach_match){
			  
						global $rdsql;	
					       
						$lv = array();
						
						$lv['coach_filter'] = (is_numeric($coach_match))?" coach_id=$coach_match ":" domain_hash='$coach_match'";
						
						if($coach_match){
									$select_sql = " SELECT id,									      
											      entity_key,
											      entity_value
											FROM
											      entity_key_value
											WHERE
											      entity_code = 'MP' AND $lv[coach_filter] ";
								    
									$exe_query = $rdsql->exec_query($select_sql,'master detail-->');
									
									while($master_row = $rdsql->data_fetch_object($exe_query)){
												
											$_SESSION[$master_row->entity_key] = $master_row->entity_value;	
											$lv[$master_row->entity_key]       = $master_row->entity_value;
											
									} // end
						} // coach match			
												
						return $lv;
						
			} // end
			
			///////// get session //////////////////////////////////////////////////////////////////////////////////////
			
			function get_session($key){
				  //todo-doubts
				  #$this->get_master_info();		
				  return @$_SESSION[$key];
			} // end
			
			
			// set master cookie
			function set_coach_cookie($coach_code){
			  
						global $rdsql;	
					       
						$lv = array();
						    
						$select_sql = "SELECT 
								      code,
								      ln
								FROM
								      entity_child
								WHERE
								     
									entity_code='HX'
									AND parent_id=get_entity_child_of_child_from_code('$coach_code','HX')
									AND get_ec_status(parent_id)=1
									ORDER BY line_order 
									";
					    
						$exe_query = $rdsql->exec_query($select_sql,'master detail-->');
						
						while($master_row = $rdsql->data_fetch_object($exe_query)){							   
							       
									array_push($lv,['binder' => $master_row->sn,
											'content'=> $master_row->ln
											]);
													 
						} // end
								
						setcookie($coach_code,json_encode($lv),time()+3600, "",$_SERVER["SERVER_NAME"]);								
											
						return $lv;
						
			} // end
			
			
			// get cookie			
			function get_cookie($key){				  
				 return (@$_COOKIE[$key])?@$_COOKIE[$key]:null;
			} // end
	}//class						
			
?>