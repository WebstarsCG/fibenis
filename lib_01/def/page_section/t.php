<?PHP
        	
	$key       	= @$_GET['key'];
	
	//$user_id_temp   = @$_GET['user_id'];
	
	$find_id = $rdsql->exec_query("SELECT ea_value,get_page_coach_code($key),
				      get_ecb_sn_by_token(get_eav_addon_exa_token($key,'PGTM'))
				      FROM eav_addon_vc128uniq
				      WHERE ea_code = 'PGCD' AND parent_id = $key",
				      "Selection Fails");
		
	$value = $rdsql->data_fetch_row($find_id);
	    
	$page = $value[0];
	
	$coach_path['content']  = "$COACH[path]$value[1]/content";
	
	//$coach_path['content']  = "terminal/test/content/";
	
	$T_SERIES       =   array(
		
					'table' => 'entity_child',
					 
					'data'  => array(
						
							'title'      =>array('field'=>"get_eav_addon_varchar(id,'ECSN')"),
							 
							'ln'      =>array('field'=>"get_eav_addon_varchar(id,'ECLN')"),
							 
							'dt'      =>array('field'=>"get_eav_addon_text(id,'ECDT')"),
								
						
						
						),	
					
					'key_id' => "get_eav_addon_ec_id(id,'ECPR')",
					
					'key_filter'=>" AND entity_code='SC' AND id IN (SELECT parent_id FROM eav_addon_ec_id WHERE ec_id = $key AND ea_code ='ECPR')",
					
					'show_query'=>0,
					
					'template'       => $LIB_PATH.'def/page_section/sec_template/'.$value[2].'.html',
					
					'save_as'=> array(
							
								array(	'type'	 =>'html',
									'file_name'=>$page,
									'path'=>$coach_path['content'])
							
							)

                            );
	
	
?>