<?PHP

	include($LIB_PATH."def/entity_child_base/d.php");
	
	
	unset($D_SERIES['data']['6']); //line order
	
	$D_SERIES['data']['3']['th']   = 'Name';
	$D_SERIES['data']['3']['attr'] = ['width'=>'60%'];
	
	
	$D_SERIES['data']['4']['th'] = 'Keywords';
	unset($D_SERIES['data']['4']);
	
	
	$D_SERIES['data']['8']['td_attr'] = 'width="25%"';
	
	$D_SERIES['data']['1']=array('th'=>'Theme',
									 
				'field'=>'(SELECT sn as name FROM entity_child_base as ecb
						WHERE ecb.id=entity_child_base.parent_id)',
					 
				'td_attr' => ' class="label_child align_LM" width="20%"',
	
				);
	
	$D_SERIES['data']['5']=array('th'=>'Content',
									 
				'field'=>'note',
					 
				'td_attr' => ' class="label_child align_LM" width="25%"',
				
				'filter_out'=>function($data_in){
					
						      return '<a class="tip">View...</a><font class="tooltiptext">'.$data_in.'</font>';	 
						}	
				);
	
	unset($D_SERIES['data']['5']); //Content
	
	// add
	
	$D_SERIES['add_button']['page_link'] = 'f=page_layout';
	$D_SERIES['add_button']['b_name']    = 'Add Page Layout';
	
	// filter
	
	$D_SERIES['key_filter'] = " AND entity_code='PL' ";
	
	$D_SERIES['before_delete'] = 1;
	
	// after delete
	function before_delete($param){
		
		$lv 	      = array();
		
		$lv['result'] = $param['g']->get_one_cell(['table'=>'entity_child_base',
						    'field'=>"token",
						    'manipulation'=>" WHERE id=$param[key_id]" 
						    ]);
		
		$file_to_delete = get_config('theme_path').'/'.get_config('theme').'/template/layout/'.$lv['result'].".html";
		
		if(is_file($file_to_delete)){
		   
			unlink($file_to_delete);
		}  		
		
	} // end
	
	
	unset($D_SERIES['custom_filter']);
	
	if(@$_GET['default_addon']){
		
		$default_addon = @$_GET['default_addon'];
		$D_SERIES['key_filter'] ="AND entity_code='PL' AND parent_id = (SELECT id FROM entity_child_base WHERE entity_code='TH' AND
					  token = (SELECT ea_value FROM eav_addon_varchar WHERE ea_code='ECSN' aND parent_id = $default_addon))";
        	unset($D_SERIES['data'][1]);
		unset($D_SERIES['export_csv']);
		$D_SERIES['action']['is_edit']=1;
		$D_SERIES['add_button']['is_add']=0;
		$D_SERIES['del_permission']['able_del']=1;
		$D_SERIES['summary_data'] = [];
		
		$LAYOUT	    = 'layout_full';
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['search_filter_off']	=1;
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['hide_pager'] = 1;
		$D_SERIES['show_all_rows']=1;
		$D_SERIES['filter_off'] = 1;
	}
    
?>