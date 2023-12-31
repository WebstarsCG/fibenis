<?PHP

	# In present case, we are parellely calling all the page content functions,
	# We have to load the called content instead of loading all
	# In present, we can consider BL (Blog), PG (Page) are two type of displays.
	# Where both need different lrigayouts and dynamic side contents
	# But now the ?page_id will be the essential one to communication
	# When we loading a page by page_id, we have no way to get the information
	# Now we have to take it from page_info only.
	# The present content array based implementation is fine.
	# now it only need two cases
	# BL->
	# PG->
	# 	Cases Like about us (Sub Pages) implemented through parent/child way
	# 	1. During Page Creation, We can show the parent
	#                                list box-> contains the entity_child WHERE code=PG
	#	By that way
	#		1. About Us Added parent_id= 0 (root)
	#		2. History added -> with parent as ( About Us )
	#	When we load the page ?history-> We will check any parent is there.
	#       Such a case, we will select the parent's child entry and passed to child menu
	#	2.If it's a plain ?contactus page, there will be no parent_id.
	#         It will fill the content,layout as by config in table
	#	3.In present case, Menu is semi dynamic. The childs can grow, but the top level is controled in this case
	# BL
	#	In case of blog page, ?wedding_tradation_present <page_code>
	#	We will pick the child_info as like PL
	#	If we have the entity_code as BL
	#	We will load it with different layout
	# In that way, we can restrict to only two functions ->dynamic_page_content,
	#              and get_side_menu ( based on case for child pages/blog)
	# $PAGE from the index will solve the purpose to pick the information
	#  
	# Also, we will have only one $CONTENT[$PAGE] defination, ( unnecssary content loading avoided)
		
	$CONTENT      = array();
	
	# if cookie not there	

	$PV['MASTER']   = (!@$_SESSION['meta_title'])?$SG->set_get_master_session($COACH['name_hash']):$_SESSION;
	
	#print_r($PV['COOKIE']);
	
	#print_r($_SESSION);

	if(is_file($LIB_PATH."/inc/".$PAGE.".php")){
		
		$PAGE_NAME 	= $_GET[$PAGE];
		
		$entity_code    = array( 'blog'		=>'BL',
					 'news_events'	=>'NE',
					 'contact_card'	=>'CG'  );
		
		$page_info      = @page_setup( array('code'=>$entity_code[$PAGE_NAME]) );
		
		#print_r($page_info);
		
	} // direct page
	else{
	        $page_info	=  dynamic_page_content(array('manipulation' => " code = '$PAGE' $COACH[filter]"  ));
		
		$temp_page_info =  @page_setup( array('code'     => $page_info['entity_code'],
						      'parent_id' => $page_info['parent_id'])
				   );
		
		$page_info['side_menu'] = $temp_page_info['side_menu'];
		
	} // end of content retrieve
	
	// set layout & content	
	
	$LAYOUT 		= $page_info['layout'];
		
	
	$CONTENT[@$PAGE]   	= 	array(
						        'add_on'	=> '',
							'layout'        => $LAYOUT,
							'lib_path'      => $LIB_PATH,
							
							'parent_key_code'=> @$page_info['parent_key_code'],
							'parent_name' 	=> @$page_info['parent_name'],
							'parent_right_image'=>@$page_info['parent_right_image'],
							'parent_header_image'=>@$page_info['parent_header_image'],
							
							'parent_title'      => @$page_info['parent_title'],
							'parent_keywords'   => @$page_info['parent_keywords'],
							'parent_description'=> @$page_info['parent_description'],
							
							'page_title'        => @$page_info['page_title'],
							'page_keywords'     => @$page_info['page_keywords'],
							'page_description'  => @$page_info['page_description'],
							'page_right_image'  => @$page_info['page_right_image'],
							'page_header_image' => @$page_info['page_header_image'],
							
							'page'          => $PAGE,							
							'title'  	=> $page_info['title'],							
							'side_menu'     => $page_info['side_menu']														
					);
	
	
	$CONTENT[@$PAGE]['page_content']  = page_content($CONTENT[@$PAGE]);
	
	function page_setup($param){
				
		$page_info = array(
			
			'BL' 	=> array('layout'=>'layout_right',
				      'title'=>'Blog',
				      'side_menu'=> get_side_menu( array( 'manipulation' => "entity_code='BL' AND parent_id=0 ",'is_blog'=>1,'menu_link'=>'d=blog', 'show_query'=>0) ),
				      'menu_name' => 'Blog',						 
				      ),
			
			'NE' 	=> array('layout'=>'layout_right', 'title'=>'News Events',
				      'side_menu'=> get_side_menu( array( 'manipulation' => "entity_code='ET' AND parent_id=0 ",'is_blog'=>1,'menu_link'=>'d=news_events') ),
				      'menu_name' => 'News & Events'
				      ),
			
			
			'CG' 	=> array('layout'=>'layout_right', 'title'=>'Contact Us',
				      'side_menu'=> get_side_menu( array( 'manipulation' => "entity_code='CG' AND parent_id=0 ",'is_blog'=>0,
									 'is_no_content'=>1, 'menu_link'=>'d=contact_card','show_query'=>0) ),
				      'menu_name' => 'Contact Us'
				      ),
			
			'PG' 	=> array(
				      'side_menu'=>$param['parent_id']?get_side_menu( array( 'manipulation' => "entity_code='$param[code]' AND parent_id=$param[parent_id] ",'is_blog'=>0,'show_query'=>0)):''
				      ),
				  
		);
		
		return @$page_info[$param['code']];
		
	} // end
	
	
	
	// get series page content
	
	function page_content($content){
		
		global $COACH;
		
		$page = $content['page'];
		
		
		if(!is_file($content['lib_path']."/inc/$page.php")){		
			
			$page 			= (is_file("$COACH[path]$COACH[name]/content/$page.html"))?$page:'home';
			
			$c 			= new Template(array("filename" => "$COACH[path]$COACH[name]/content/$page.html",
							    "debug"    => 0));
			
			if($content['add_on']){ $c->AddParam($content['add_on']); } 
			
			return $c->Output();
		}
		
	} // end
	
	
	
	
	// get dynamic page conent	
	function dynamic_page_content($param){
		
			global $rdsql;
			 
			global $PARAM;
			
			$select_data = "SELECT
						ln,						
						entity_code,
						parent_id,												
					        addon,
					        get_page_parent(parent_id) as parent_name,
						IFNULL(get_eav_addon_varchar(entity_child.id,'PGPL'),'layout_right') as page_layout,
						get_eav_addon_varchar(entity_child.id,'PGKW') as page_keywords,
						get_eav_addon_varchar(entity_child.id,'PGPD') as page_description,
						get_eav_addon_varchar(entity_child.id,'PGPT') as page_title,
						get_eav_addon_varchar(entity_child.id,'PGIB') as page_header_image,
						get_eav_addon_varchar(entity_child.id,'PGIC') as page_right_image						
					FROM
						entity_child
					WHERE
						$param[manipulation]
					 ";
			#echo $select_data;		  
			
			$exe_select_info = $rdsql->exec_query($select_data,'pag dy content');
			
			$get_row 	 = $rdsql->data_fetch_object($exe_select_info);		
			
			$temp_parent     = (@$get_row->parent_name)?(explode('[C]',@$get_row->parent_name)):['home','Home','','','','',''];
			
			return array(
				     'title' 	        => @$get_row->ln,
				     
				     'parent_id'        => @$get_row->parent_id,
				     
				     'page_title'       => @$get_row->page_title,
				     'page_keywords'    => @$get_row->page_keywords,
				     'page_description' => @$get_row->page_description,
				     'page_right_image' => @$get_row->page_right_image,
				     'page_header_image'=> @$get_row->page_header_image,
				     
				     'parent_key_code'     => $temp_parent[0],			     
				     'parent_name'         => $temp_parent[1],
				     'parent_header_image' => $temp_parent[2],
				     'parent_right_image'  => $temp_parent[3],
				     
				     'parent_title'       => $temp_parent[4],
				     'parent_description' => $temp_parent[5],
				     'parent_keywords'    => $temp_parent[6],
				     
				     'layout'  	        => @$get_row->page_layout,
				     'entity_code'      => @$get_row->entity_code				     				  
			);
			
	} // end of dynamic page content
		
	
	
	// get side menu
	function get_side_menu($param){
		
		global $rdsql;		
		global $PAGE_NAME;
		global $PAGE;
		global $G;
		global $LIB_PATH;
		
		$page      = $PAGE;
		$page_name = $PAGE_NAME;
		
		$temp_info	 = array();
		
		// query
		
		$select_data = "SELECT
					id,
					sn,
					code,
					addon,
					get_eav_addon_varchar(id,'PGRD') as redirect_url
				FROM
					entity_child
				WHERE 1=1 AND 
					$param[manipulation] AND is_active=1	
				ORDER BY
					line_order ASC";
				 
		if(@$param['show_query']){
			
			echo $select_data.'-------<br>';			
		}
		
		$exe_select_info = $rdsql->exec_query($select_data,'error sub menu ');
			
		// fetch object		
				
		while($get_row = $rdsql->data_fetch_object($exe_select_info)){
			
			$temp 		   = array();
			
			$temp['menu_name'] = $get_row->sn;
			
			$temp['redirect_url'] = $get_row->redirect_url;
			
			$get_row->code = ($get_row->redirect_url)?$get_row->redirect_url:$get_row->code;
			
			if(@$param['is_blog']){				
				
				$no_row 		= $G->table_no_rows(array('table_name'=>'entity_child',
										 'WHERE_FILTER'=> ' AND  parent_id='.$get_row->id.' AND is_active=1' ));
				$temp['is_no_content']  = $param['is_blog'];				
			
			}else{ // contact case
				
				$no_row 		= $G->table_no_rows(array('table_name'=>'communication', 'WHERE_FILTER'=> ' AND is_active=1 AND comm_group_code=(SELECT code FROM entity_child WHERE id ='.$get_row->id.')','show_query'=>0));
				
				$temp['is_no_content']  = @$param['is_no_content'];
			}
			
			// sub menu
			
			if(is_file($LIB_PATH."/inc/".$page.".php")){
				
				$temp['code'] 		= $page.'='.$page_name.'&default_addon='.$get_row->id; //$get_row->code;			  
				$temp['no_data'] 	= $no_row[0];
			}else{
				
				$temp['no_data'] 	= $no_row[0];
				
				if(@$param['is_blog']){
				      $temp['code']  	     = @$param['menu_link'].'&default_addon='.$get_row->id;
				      $temp['is_no_content'] = $param['is_blog'];
				}else{
				    $temp['code']	     = strtolower(preg_replace('/\s+/', '_',$get_row->code )); //$get_row->code;				    
				}
			}
			
			array_push($temp_info,$temp);
		}
		
		return $temp_info;
	
	} // end	
		
		

	// menu create
	
	function menu_create($param){
			 
			global $rdsql;
			global $G;
			 
			$select_data =" SELECT id,
						sn,
						code,
						ln,
						parent_id,
						get_eav_addon_varchar(id,'PGRD') as redirect
					   FROM
						entity_child  
						$param[manipulation] AND is_active=1 ORDER BY line_order ";
			
			$exe_select_info = $rdsql->exec_query($select_data,'Test');
			 
			$result = array();
			 
			while($get_row	 = $rdsql->data_fetch_object($exe_select_info)){
				 
				$temp = array();
				$temp['menu_name']  = $get_row->sn;
				$temp['menu_title'] = $get_row->ln;
				$temp['menu_code']  = $get_row->code;
				$temp['menu_href']  = (!$get_row->redirect)?'?'.$get_row->code:$get_row->redirect;
				 
				if( (strpos($temp['menu_href'],'#') !== false) &&
				    ($param['is_home']==0)){					
					$temp['menu_href']  = '?home'.$temp['menu_href'];
				}
				 
				$parent_id =$get_row->id;
				 
				if($get_row->parent_id==0){
				  $temp['child_menu'] = menu_create(array('manipulation'=> " WHERE entity_code='PG' AND parent_id=$parent_id" ));		
				}
				 
				array_push($result,$temp);
			}
			 
			return $result;
			 
	} // end
	

?>