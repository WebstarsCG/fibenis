<?PHP

	# Var	
		$C;		// content
		
		$MENU_OFF=0;   // menu_off
		
		$PAGE_CONTENT; // final content variable passes to main stream
		
		$PV;	       // page variable
		
		$SHOW_DOOR;    // closed access
		
		$THEME_ROUTE;

	# Config & Header 	
		
		$LIB_PATH               =  get_config('lib_domain');
		
		$DEFAULT_ADDON          =  (@$_GET['default_addon'])?@$_GET['default_addon']:'';
		
		$PV['is_open']		=  get_config('is_open');
		
		$THEME_ROUTE		=  get_config('theme_path').'/'.get_config('theme').'/';
		
		$P_V['table_name'] 	=  "user_info";
		
		@$session_off 	    	=  0;
		
		include($LIB_PATH.'/inc/lib/header.php');
	
	# Param		
	
		@$PARAM	 		= array_keys($_GET);
		
		# for closed access
		
		$SHOW_DOOR              = ( (get_config('access_key')==@$PARAM[0]) &&
					    (!get_config('is_open')))?1:0;
		
		$PAGE 	 		= (@$PARAM[0])?@$PARAM[0]:'home';
                
                if($PAGE=="id"){                
                    $PAGE                   = ($PAGE=="id")?@$_GET['id']:'home';		
                }
                
		if($SHOW_DOOR ){  $PAGE='home'; }
		
		$IS_HOME 		= ((($PAGE=='home') || ($PAGE==''))?1:'');
		
		# PAGE used in content.php
		
		include($LIB_PATH.'/engine/'.$ENGINE.'/inner.php');
                
               # print_r($_COOKIE);
	
		# Content Stream
		
		if($PAGE){
			
				# checking for series content
				if(is_file($LIB_PATH."/inc/".$PAGE.".php")){
                                    
                                                # flag
                                                
                                                $PV['is_page'] = 0;
				
						# process series content	
							
						include($LIB_PATH."/inc/".$PAGE.".php");	
						
						# Check Layout
						
						$LAYOUT = (@$LAYOUT)?$LAYOUT:'layout_basic';
						
						if($USER_ID){							
							
							   // space for additional info	
						}
				
						# Layout Content	
						
						$L = new Template(array("filename" => $THEME_ROUTE."template/layout/$LAYOUT.html",
									"debug"    => 0));
						
						# contnet from series to sub-stream
					
						$L->AddParam('PAGE_INFO',$PAGE_INFO);
				
						# for additional info check layout
					
						if($LAYOUT!='layout_basic'){
								
								// user info
						
								if($USER_ID && $session_off!=1 ){
								
										# params
										
										$L->AddParam(array(													
												'USER_COMM_KEY'		=> $USER_COMM_KEY,
												//'USER_ROLE_NAME'	=> $get_row->user_role_name,
												'USER_NAME'		=> $USER_NAME,																									
												'USER_ID'		=> $USER_ID,
										));
								}
						
						
								// side menu
						
								if(@$CONTENT[$PAGE]['side_menu']){
									
									$L->AddParam('menu_name',@$CONTENT[$PAGE]['menu_name']);
									
									$L->AddParam('side_menu',@$CONTENT[$PAGE]['side_menu']);
								}
						}
										
						// processed content substream
														
						$PAGE_CONTENT = $L->Output();
                                                
                                                // is_page
                                                
                                                
			
				}else{ // open page
				
                                                $PV['is_page']  = 1;
                                
						$PV['layout']   = (@$CONTENT[$PAGE]['layout'])?$CONTENT[$PAGE]['layout']:'layout_basic';
											
						$C 		= new Template(array("filename" => $THEME_ROUTE."template/layout/".$PV['layout'].".html",
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
				
				} // end of content stream
			
		} # end of closed area
		
			
		// Header & footer		
		
				$PV['header_footer'] =  array(  'page_title'   => get_config('title'),                                                            
                                                                'lib_path'     => $LIB_PATH,
                                                                'theme_path'   => get_config('theme_path'),
                                                                'theme'	       => get_config('theme'),
                                                                'is_home'      => $IS_HOME,
                                                                'current_year' => date("Y")
                                                            );
				
				
				$H 		= new Template(array("filename" => $THEME_ROUTE."template/header.html",
							     "debug"    => 0));
				
				$H->AddParam($PV['header_footer']);
				
				$H->AddParam(array('default_title'   => $SG->get_cookie('meta_title'),
						'default_keywords'   => $SG->get_cookie('meta_keywords'),
						'default_description'=> $SG->get_cookie('meta_description'),
						
						'page_title'         => @$CONTENT[$PAGE]['page_title'],
						'page_keywords'      => @$CONTENT[$PAGE]['page_keywords'],
						'page_description'   => @$CONTENT[$PAGE]['page_description'],
                                                
                                                'parent_title'         => @$CONTENT[$PAGE]['parent_title'],
						'parent_keywords'      => @$CONTENT[$PAGE]['parent_keywords'],
						'parent_description'   => @$CONTENT[$PAGE]['parent_description'],
						
						'primary_mail'       => $SG->get_cookie('primary_mail'),
                                                'is_page'            => $PV['is_page'],
                                                
                                                'page_content_title' => $CONTENT[$PAGE]['title']
                                                
                                                )
					    );
			
				// Footer	
			
				$F 		= new Template(array("filename" => $THEME_ROUTE."template/footer.html",
							     "debug"    => 0));
			
				$F->AddParam($PV['header_footer']);
                                
                         
				
				$F->AddParam(array('PAGE_ID'=>$PAGE,
                                                   'default_footer'=> (($SG->get_cookie('default_footer'))?$SG->get_cookie('default_footer'):$PV['COOKIE']['default_footer']),
						   'IS_USER'=>(($USER_ID)?1:0)));
				
				//email:
				
				if(@$_GET['e_mail']){		     
						$F->AddParam('SIGN_EMAIL',base64_decode($_GET['e_mail'])); 
				}
				
				if(@$_GET['e_mail_su']){                    		    
						$F->AddParam('SIGNUP_EMAIL',base64_decode($_GET['e_mail_su']));                
				}

	
		// Menu Content
               
		
				$MENU_OFF = (!$MENU_OFF)?(((@$_GET['menu']) || (@$_GET['menu_off']))?1:0):$MENU_OFF;
				
				if(!$MENU_OFF){
				
						$M 	= new Template(array("filename" => $THEME_ROUTE."template/menu.html",
									     "debug"    => 0));
						
						$M->AddParam('PARENT_MENU',menu_create(array('manipulation'=>" WHERE entity_code='PG' AND parent_id=0 ")) );
						
						$M->AddParam(get_add_on_content($rdsql,$G));
					
						// User Role
						
						if($USER_ROLE){	
							$M->AddParam("USER_$USER_ROLE",1);
							$M->AddParam('USER_NAME',@$USER_NAME);
							$M->AddParam(array(
										'addon_type'=>$G->get_id_name("entity_child_base","token as id, sn as name"," WHERE entity_code='AT'")
									));
						}else{
							$M->AddParam('NO_USER',1);
						}
						
						// Special addons in menu
				
						$M->AddParam( array('is_blog'	     => $SG->get_session('is_blog'),
								    'is_directory'   => $SG->get_session('is_directory'),								    
								    'is_gallery'     => $SG->get_session('is_gallery'),
								    'is_news_events' => $SG->get_session('is_news_events'),
								    'is_open'        => $PV['is_open'],
                                                                    'is_home'	     => $IS_HOME,
								    )
						);
						
				} // end
		
	
		// Login Page Content
		
				$LOGIN 	= new Template(array("filename" => $LIB_PATH."/template/login.html",
							     "debug"    => 0));
				
				$LOGIN->AddParam('IS_OPEN',$PV['is_open']);
	
		# Template
				
				$TD     = new Template(array("filename"          => $LIB_PATH."/template/index.html",
							     "debug"             => 0,
							     "loop_context_vars" => 1)
						);		
		
				
		
		
		# Menu Data
				
		if(!$MENU_OFF){
				
			$TD->AddParam('MENU_DATA',$M->Output());
			
		} // menu off
		
		$TD->AddParam(array(
				    'header'       => $H->Output(),
				    'menu_off'	   => $MENU_OFF,
				    'page_content' => @$PAGE_CONTENT,
				    'footer'       => $F->Output(),
				    'login'        => $LOGIN->Output(),
				    'default_addon'=> urlencode($DEFAULT_ADDON),
				    'pass_id'      => $PASS_ID,
				    'is_open'      => $PV['is_open'],
				    'show_door'    => $SHOW_DOOR,
		));
						   
		if($USER_ID){
				
		    $TD->AddParam(array('USER_ID'   =>@$USER_ID,
					'USER_NAME' =>@$USER_NAME,
					'USER_EMAIL'=>@$USER_EMAIL,
					));                        
		} // user id
				
		$TD->EchoOutput();
		
		
		# open log
		
		if(!@$USER_ID){
				
				$access_key = (@$_GET[$PAGE])?$PAGE.'='.$_GET[$PAGE]:$PAGE ;
				
				$param=array('user_id'=>$USER_ID,'page_code'=>'PAGE','action_type'=>'VIEW','action'=>'General page access','access_key'=>$access_key );
								 
				$G->set_system_log($param);
		}			
	
	
		// close db connection
		
		$db_conn_close($db_conn_info);		
		
?>