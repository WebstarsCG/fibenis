<?PHP
    
	$temp_start=microtime(true);

	# Var
		$COACH=[];     // coach
	
		$C;	       // content
		
		$MENU_OFF=0;   // menu_off
		
		$PAGE_CONTENT; // final content variable passes to main stream
		
		$PV;	       // page variable
		
		$SHOW_DOOR;    // closed access
		
		$THEME_ROUTE;  // Theme Route		

	# Config & Header
		
		@$session_off 	    	=  0;
				
		$DEFAULT_ADDON          =  (@$_GET['default_addon'])?@$_GET['default_addon']:'';
		
		$LIB_PATH               =  get_lib_path();
		
		$THEME_ROUTE		=  get_config('theme_path').'/'.get_config('theme');		
						
		$PV['is_open']		=  get_config('is_open');		
							
	# include header
		
		include($LIB_PATH.'/inc/lib/header.php');
		
	# coach
	
		$COACH['domain_name']	=   (get_config('is_multiple')==1)?str_replace("www.","",$_SERVER['HTTP_HOST']):'default';
		 
		if(!isset($_SESSION['COACH_ID_'.$COACH['domain_name']])){
		    
		    list($COACH['id'],
			 $COACH['name']) =    explode('[C]',$G->get_one_cell(['table'        => 'entity_child',
							  'field'        => "concat(id,'[C]',get_eav_addon_vc128uniq(id,'CHCD'))",
							  'manipulation' => " WHERE get_eav_addon_varchar(id,'CHDN') ='$COACH[domain_name]' ",
		 		        ]));
		    
		    $_SESSION['COACH_ID_'.$COACH['domain_name']]       = $COACH['id'];
		    $_SESSION['COACH_NAME_'.$COACH['domain_name']]     = $COACH['name'];
		    
		}else{		    
		    $COACH['name'] = $_SESSION['COACH_NAME_'.$COACH['domain_name']];
		    $COACH['id'] = $_SESSION['COACH_ID_'.$COACH['domain_name']];
		} 
				
		$COACH['name_hash']     =   md5($COACH['name']);
		
		$COACH['path']          =  ((get_config('coach_path'))?get_config('coach_path'):"template/");
		
		$COACH['filter']        =  (get_config('is_multiple')==1)? " AND id=$COACH[id] " :"";
		
		$COACH['terminal_path'] =  $COACH['path'].$COACH['name'];
		
		$COACH['theme_route']   =  $THEME_ROUTE;
		
			
	# Home & Key URL setup	
	
		@$PARAM	 		= array_keys($_GET);
		
		# for closed access
	
		
		$COACH['step_in']       = ((!get_config('is_open')) && (!get_config('avoid_gate')))?'gate':'home';
		
		$PAGE 	 		= (@$PARAM[0])?@$PARAM[0]:$COACH['step_in'] ;
                		
		# id to page setup
		
                if($PAGE=="id"){                
                    $PAGE               = ($PAGE=="id")?@$_GET['id']:$COACH['step_in'] ;		
                }
                
		# Closed Access		
		
		$IS_HOME 		= ((($PAGE==$COACH['step_in']) || ($PAGE==''))?1:'');
		
		
		#if(($SHOW_DOOR) && (!$IS_HOME)){  $PAGE=$COACH['step_in'] ; }
		
			
		$SHOW_DOOR              = ( (get_config('access_key')==@$PARAM[0]) &&
					    (get_config('avoid_gate')))?1:0;
		
		# PAGE used in content.php
		
		include($LIB_PATH.'/engine/'.$ENGINE.'/inner.php');
				
		if(($IS_HOME) && (strcmp(get_config('access_key'),'never')==0)){
		    $CONTENT[$PAGE]['title']='';
		}
		
		$IS_APP = (@$_GET[$PAGE] && is_file($LIB_PATH."/inc/".$PAGE.".php"))?1:0;
     				
		# Content Stream
				
		# checking for series content
		if($IS_APP){
		    
				# flag
				
				$PV['is_page'] = 0;
		
				# page code
				
				$PAGE_CODE = $PAGE_NAME.'__'.$PAGE;
								
				# process series content	
				
				include($LIB_PATH."/inc/".$PAGE.".php");	
				
				# Check Layout
				
				$LAYOUT = (@$LAYOUT)?$LAYOUT:'layout_basic';
				
				if($USER_ID){							
					
					   // space for additional info	
				}
														    
				# custom theme pages
										
				if(@get_config('custom_theme_pages')[$PAGE_ID.'_'.$PAGE_NAME]){
										    
				    $THEME_ROUTE = get_config('custom_theme_pages')[$PAGE_ID.'_'.$PAGE_NAME]; 
				}
		
				# Layout Content	
				
				$L = new Template(array("filename" => $THEME_ROUTE."/template/layout/$LAYOUT.html",
							"debug"    => 0));
				
				# Title
				$PV['page_title'] = @$PAGE_TITLE;
				$L->AddParam('PAGE_TITLE',@$PAGE_TITLE);						
				
				# contnet from series to sub-stream
			
				$L->AddParam('PAGE_INFO',$PAGE_INFO);
		
				# for additional info check layout
			
				if( ($LAYOUT!='layout_basic') && ($LAYOUT!='layout_full')) {
						
						// user info
				
						if($USER_ID && $session_off!=1 ){
						
								# params
								# commented 20sep2018
								//$L->AddParam(array(													
								//		'USER_COMM_KEY'		=> $USER_COMM_KEY,
								//		//'USER_ROLE_NAME'	=> $get_row->user_role_name,
								//		'USER_NAME'		=> $USER_NAME,																									
								//		'USER_ID'		=> $USER_ID,
								//));
						}
										
						// side menu
				
						if(@$CONTENT[$PAGE]['side_menu']){
							
							$L->AddParam('menu_name',@$CONTENT[$PAGE]['menu_name']);
							
							$L->AddParam('side_menu',@$CONTENT[$PAGE]['side_menu']);
						}
				}
								
				// processed content substream
												
				$PAGE_CONTENT = $L->Output();
				
				outer_action();
				
	
		}else{ // open page
				
				$PV['page_cached'] = $COACH['terminal_path']."/cache/$PAGE.html";
				
				if(is_file($PV['page_cached'])){
				
				    $PV['page_cached_template'] = new Template(array("filename" =>$PV['page_cached']));
				    $PV['page_cached_template']->EchoOutput();    
						    
				}else{
				    
				    $PV['is_page']  = 1;
								   
				    $PV['layout']   = (@$CONTENT[$PAGE]['layout'])?$CONTENT[$PAGE]['layout']:'layout_full';
									    
				    $C 		= new Template(array("filename" => $THEME_ROUTE."/template/layout/".$PV['layout'].".html",
									 "debug"   => 0));
						    
				    $C->AddParam('PAGE_ID',$PAGE);
	    
				    $C->AddParam('PAGE_TITLE',$CONTENT[$PAGE]['title']);
				    
				    $C->AddParam('PAGE_INFO',$CONTENT[$PAGE]['page_content']);
				    
				    if(@$CONTENT[$PAGE]['side_menu']){
				      
					$C->AddParam('side_menu',@$CONTENT[$PAGE]['side_menu']);		
				    }
				    
				    $C->AddParam('PARENT_KEY_CODE',@$CONTENT[$PAGE]['parent_key_code']);
				    $C->AddParam('PARENT_NAME',@$CONTENT[$PAGE]['parent_name']);
	    
				    $C->AddParam('PARENT_RIGHT_IMAGE',@$CONTENT[$PAGE]['parent_right_image']);
				    $C->AddParam('PARENT_HEADER_IMAGE',@$CONTENT[$PAGE]['parent_header_image']);
				    
				    $C->AddParam('PAGE_RIGHT_IMAGE',@$CONTENT[$PAGE]['page_right_image']);
				    $C->AddParam('PAGE_HEADER_IMAGE',@$CONTENT[$PAGE]['page_header_image']);				
				    
				    $PAGE_CONTENT = $C->Output();
				    
				    outer_action();
				}
		
		} // end of content stream
			
		
		function outer_action(){
		    
			global $PV,$THEME_ROUTE,$COACH,$IS_HOME,$LIB_PATH,
			       $CONTENT,$MENU_OFF,$G,$PAGE,$PAGE_CONTENT,$SG,$PASS_ID,
			       $DEFAULT_ADDON,$SHOW_DOOR,$USER_ROLE,$USER_ID,$USER_NAME;
			

			    // Header & footer		
		
				$PV['header_footer'] =  array(  'page_title'   => get_config('title'),                                                            
                                                               // 'lib_path'     => $LIB_PATH,
								'theme_route'  => $THEME_ROUTE,
								'terminal_path'=> $COACH['terminal_path'],
                                                                'is_home'      => $IS_HOME,
                                                                'current_year' => date("Y")
                                                            );
				
				// core header
				
				$PV['core_header']  = new Template(array("filename" => $LIB_PATH."/template/header.html",
								         "debug"    => 0));
				
				$PV['core_header']->AddParam(array( 'lib_path'      => $LIB_PATH,   
								    'is_page'       => $PV['is_page']) );
							    							      				
				// header				
				
				$H		    = new Template(array("filename" => $THEME_ROUTE."/template/header.html",
							                 "debug"    => 0));
								
				$H->AddParam($PV['header_footer']);
				
				$H->AddParam(array(
						    'core_header'        => $PV['core_header']->Output(),
						       
						    'theme_blend'        => get_config('theme_blend'),						
						    'coach_theme_blend'  => @$PV['MASTER']['theme_blend'],
						    
						    'default_title'      => @$PV['MASTER']['meta_title'],
						    'default_keywords'   => @$PV['MASTER']['meta_keywords'],
						    'default_description'=> @$PV['MASTER']['meta_description'],
						    
						    'page_title'         => @$CONTENT[$PAGE]['page_title'],
						    'page_keywords'      => @$CONTENT[$PAGE]['page_keywords'],
						    'page_description'   => @$CONTENT[$PAGE]['page_description'],
						    
						    'parent_title'       => @$CONTENT[$PAGE]['parent_title'],
						    'parent_keywords'    => @$CONTENT[$PAGE]['parent_keywords'],
						    'parent_description' => @$CONTENT[$PAGE]['parent_description'],
						    
						    'primary_mail'       => $SG->get_cookie('primary_mail'),
						    //'is_page'            => $PV['is_page'],
						    
						    'page_content_title' => $CONTENT[$PAGE]['title']
                                                )
					    );
					    
			
				// Footer	
			
				$F 		= new Template(array("filename" => $THEME_ROUTE."/template/footer.html",
							     "debug"    => 0));
			
				$F->AddParam($PV['header_footer']);
                                
                         
				
				$F->AddParam(array('PAGE_ID'        => $PAGE,
                                                   'default_footer' => @$PV['MASTER']['default_footer'],
						   'IS_USER'       => (($USER_ID)?1:0)					         
					    ));				
				// email:
				
				if(@$_GET['e_mail']){		     
						$F->AddParam('SIGN_EMAIL',base64_decode($_GET['e_mail'])); 
				}
				
				if(@$_GET['e_mail_su']){                    		    
						$F->AddParam('SIGNUP_EMAIL',base64_decode($_GET['e_mail_su']));                
				}

		
		# Template
				
				$TD =   new Template(array("filename"          => $LIB_PATH."/template/index.html",
							     "debug"             => 0,
							     "loop_context_vars" => 1)
					);
		// Menu Content
			    
		
				$MENU_OFF = (!$MENU_OFF)?(((@$_GET['menu']) || (@$_GET['menu_off']))?1:0):$MENU_OFF;
				
				if(!$MENU_OFF){
				
						$PV['menu_text']    = 'menu_'.strtolower($USER_ROLE).'x'.$IS_HOME.'o'.$PV['is_open'];
						$PV['menu_created'] =  $THEME_ROUTE."/template/role_menu/$PV[menu_text].html";
				
						if(is_file($PV['menu_created'])){
				
							$PV['menu_created_template'] = new Template(array("filename" =>$PV['menu_created']));
							$TD->AddParam('MENU_DATA',$PV['menu_created_template']->Output());    
						    
						}else{
						
												    
						    $M 	= new Template(array("filename" => $THEME_ROUTE."/template/menu.html",
										 "debug"    => 0));						
											    
						    // User Role
						    
						    if($USER_ROLE){
							
							    $M->AddParam("USER_$USER_ROLE",1);
							    $M->AddParam('USER_NAME',@$USER_NAME);
							    $M->AddParam(array(
										    'addon_type'=>$G->get_id_name("entity_child_base","token as id, sn as name"," WHERE entity_code='AT'")
									    ));
							    
							    if(is_file($THEME_ROUTE."/template/role_menu/$USER_ROLE.html")){
								
								$M_ROLE = new Template(array("filename" => $THEME_ROUTE."/template/role_menu/$USER_ROLE.html"));
								$M->AddParam('APP_MENU_TEXT', $M_ROLE->Output());
								
							    }else{
							    
								$M->AddParam('APP_MENU',app_menu_create(['user_role_id'=>2,
													 'parent_id'   =>0
													 ]));
							    }
						    }else{
							    							    
							    $M->AddParam('NO_USER',1);
							    
							    $M->AddParam('PARENT_MENU',menu_create(array('manipulation'=>" WHERE 1=1 $COACH[filter] AND entity_code='PG' AND IFNULL(get_ec_parent_id_eav(id),0)=0  ",
												 'is_home'     => $IS_HOME
												 ))
							    );
							    
						    }
						    
						    // Special addons in menu
				    
						    $M->AddParam( array('is_blog'	 => $SG->get_session('is_blog'),
									'is_directory'   => $SG->get_session('is_directory'),								    
									'is_gallery'     => $SG->get_session('is_gallery'),
									'is_news_events' => $SG->get_session('is_news_events'),
									'is_open'        => $PV['is_open'],
									'is_home'	 => $IS_HOME,
									'is_page'        => $PV['is_page'],
									'coach_name'     => $COACH['name'],
									'coach_path'     => $COACH['path'],
									'page_title'     => @$PV['page_title']
								)
						    );
						    
						    $G->set_html_file($M->Output(),$PV['menu_created']);
						    $TD->AddParam('MENU_DATA',$M->Output());
						}
						
				} // end
		
	
		    // Login Page Content
		    
				    $LOGIN 	= new Template(array("filename" => $LIB_PATH."/template/login.html",
								 "debug"    => 0));
				    
				    $LOGIN->AddParam('IS_OPEN',$PV['is_open']);
	    
				    
		    
		    
		    $TD->AddParam(array(
					'default_addon'=> urlencode($DEFAULT_ADDON),
					'footer'       => $F->Output(),
					'header'       => $H->Output(),
					'is_open'      => $PV['is_open'],				    
					'login'        => $LOGIN->Output(),
					'menu_off'	   => $MENU_OFF,
					'pass_id'      => $PASS_ID,
					'page_content' => @$PAGE_CONTENT,
					'show_door'    => $SHOW_DOOR,
		    ));
						       
		    if($USER_ID){
				    
			$TD->AddParam(array('USER_ID'   =>@$USER_ID,
					    'USER_NAME' =>@$USER_NAME,
					    'USER_EMAIL'=>@$USER_EMAIL,
					    ));                        
		    } // user id
				    
		    echo $temp_content = $TD->Output();
				    
		    $G->set_html_file($temp_content,$PV['page_cached']);
						    
		    # open log
		    
		    if($PV['is_page'] ){
				    
				    $access_key = (@$_GET[$PAGE])?$PAGE.'='.$_GET[$PAGE]:$PAGE ;
				    
				    $param      = array('user_id'=>$USER_ID,'page_code'=>'ed3e225dad017ddafa66fa8a44fda21c','action_type'=>'VIEW','action'=>'General Page Access','access_key'=>$access_key );
								     
				    $G->set_system_log($param);
		    }			
	
		} // outer action
	
		// close db connection
		
		$db_conn_close($db_conn_info);
				
?>