<?PHP
        	
	$key        	= @$_GET['key'];
	$user_id_temp   = @$_GET['user_id'];
	
	$coach_code   	= $key;
	$coach_name     = $coach_code;
	
	$coach_path             = [];
	$coach_path['content']  = "$COACH[path]$coach_name/content";
	$coach_path['template'] = "$COACH[path]$coach_name/cache/t.html";
			
	$T_SERIES       =   array(
		
                                'table' => 'entity_child',
				 
				'data'  => array('id'=>['field'=>'id']),	
				
				
				'key_id' => " get_coach_code(id) ",
				
				'key_filter'=>' ',
				
				'show_query'=>0,
				
				# if data stored in array way like [ ['ins','1'],['ins B',2]]
  
                                'template'       => $coach_path['template'],
				
				// save data 
				'save_as'=> array(
						
						array('type'=>'html',
						      'file_name'=>'home',
						      'path'=>$coach_path['content'])
						
					)

                            );
	
	// include data
	include($LIB_PATH."/def/mop_v2_eav/t_data.php");
	
	include($LIB_PATH."/def/mop_v2_eav/t_map.php");
	
	
	
	$coach_content ='';
	
	$temp_menu     = [];
	
	$coach_inner_data	= $rdsql->exec_query("SELECT    id,
						                entity_code,
								get_eav_addon_varchar(id,'ECSN') as sn,
								get_ec_parent_id_eav(id) as parent_id,
								get_exav_addon_num(id,'OPSS') as is_menu_hide
							FROM
								entity_child
							WHERE
								get_coach_code(get_ec_parent_id_eav(id))='$coach_code'  ORDER by line_order","ERR");
	
	
	
		
	// each coach entity_code
	
	while($coach_inner_info=$rdsql->data_fetch_assoc($coach_inner_data)){
		
		if(@$T_SERIES['temp']['map'][$coach_inner_info['entity_code']]){
		
			# replace section id			
			$temp_pattern              = '/(\{\{)(\w+)(\}\})/i';
		
			foreach($T_SERIES['temp']['map'][$coach_inner_info['entity_code']] as $map_idx => $map_data_key){
				
				        $temp_data_replacement = @$T_SERIES['temp']['section'][$map_data_key];
				
				
				        $temp_filtered_content =preg_replace($temp_pattern,
										$coach_inner_info['id'],
										@$temp_data_replacement['key_filter']);
				       
				         $temp_data_replacement['key_filter'] = $temp_filtered_content;
 
					$T_SERIES['data'][$map_data_key.'_'.$coach_inner_info['id']]=$temp_data_replacement;
			
			}
			
		
			$temp_entity_content    = dirname(__FILE__)."/template/$coach_inner_info[entity_code].html";
			
			$temp_content_file_name = $temp_entity_content;
			
			$temp_content_file = fopen($temp_content_file_name, "r") or die("Unable to open file!");
			
			$temp_content = fread($temp_content_file,filesize($temp_entity_content));
			
			
			$temp_pattern_replace_I     = $coach_inner_info['id'];
			$temp_pattern_replace       = $temp_pattern_replace_I;
			
			$temp_pattern_match        = preg_match($temp_pattern,$temp_content);
						
			$temp_content_file_neutral = ($temp_pattern_match)?preg_replace($temp_pattern,$temp_pattern_replace,$temp_content):$temp_content;
			$coach_content.=$temp_content_file_neutral;
			
			fclose($temp_content_file);
			
			# menu
			if($temp_pattern_match){
				
				array_push($temp_menu,['code'     => $temp_pattern_replace_I,
						       'title'    => $coach_inner_info['sn'],
						       'is_active'=> (($coach_inner_info['is_menu_hide'])?0:1),
						       'coach_id' => $coach_inner_info['parent_id'],
						       'user_id'  => $user_id_temp
						]);
			}
			
		} // end
	
	} # end

	$theme_content_file_name = $coach_path['template'];

	$theme_content_file = fopen($theme_content_file_name, "w") or die("Unable to open file!");
		
	fwrite($theme_content_file,'<TMPL_LOOP DATA_INFO><!---<TMPL_VAR ID>--->'.$coach_content.'</TMPL_LOOP>');
		
	fclose($theme_content_file);
	
	# menu builder
		
	temp_menu_builder($temp_menu);
	
	
	
	
	function temp_menu_builder($param){
		
		global $USER_ID;
		
		global $rdsql;
		
		$USER_ID = (@$USER_ID)?@$USER_ID:$param[0]['user_id'];
		
		#print_r($param);
		
		$lv = [];
		
		$lv['temp_coach_id'] = $param[0]['coach_id'];
		
		if($param[0]['coach_id']){
		
			$lv['del_query']     = "DELETE FROM entity_child WHERE entity_code='PG' AND get_eav_addon_ec_id(id,'PGCH')=$lv[temp_coach_id]
		                                                                                AND get_eav_addon_bool(id,'PGHS') IS NOT NULL ";
				
			$rdsql->exec_query($lv['del_query'],$lv['del_query']);
		}
		
		# page builder
		
		foreach($param as $menu_key => $menu_detail){
			
			# delete existing
			
			
			
			# insert into page
			
			$lv['page_query'] = "INSERT INTO entity_child(entity_code,is_active,user_id) VALUES('PG',$menu_detail[is_active],$USER_ID)";
		
			$rdsql->exec_query($lv['page_query'],'menu_build_failed');
			
			$lv['page_id']    = $rdsql->last_insert_id('entity_child');
			
			# insert into title
			 
			$lv['page_title_query'] = "INSERT INTO eav_addon_varchar(parent_id,ea_code,ea_value,user_id)
							        VALUES
									($lv[page_id],'ECSN','$menu_detail[title]',$USER_ID)";
			
			$rdsql->exec_query($lv['page_title_query'],'redirection_failed');
			
			
			# insert into redirection code
			 
			$lv['page_redirection_query'] = "INSERT INTO eav_addon_varchar(parent_id,ea_code,ea_value,user_id)
							        VALUES
									($lv[page_id],'PGRD','#$menu_detail[code]',$USER_ID)";
			
			$rdsql->exec_query($lv['page_redirection_query'],'redirection_failed');
			
			# insert coach id
			
			$lv['page_coach_id']    = "INSERT INTO  eav_addon_ec_id(parent_id,ea_code,ec_id,user_id)
							        VALUES
									($lv[page_id],'PGCH',$menu_detail[coach_id],$USER_ID)";
			
			$rdsql->exec_query($lv['page_coach_id'],'page_coach_failed');
			
			# insert home section id
			
			$lv['query_home_section']    = "INSERT INTO  eav_addon_bool(parent_id,ea_code,ea_value,user_id)
							        VALUES
									($lv[page_id],'PGHS',1,$USER_ID)";
			
			$rdsql->exec_query($lv['query_home_section'],'page_coach_failed');
						
		} // end
		
	} // end
    
?>