<?PHP

	include($LIB_PATH."def/opg_v2/f.php");
	
	$entity= ['code'=>'AB',
			'title'=>'Action Box',
			'page_code'=>'action_box'
		];
	
	// Start Coach //////////////////////////////////////////////////////
	
	$temp_coach_id	= 0;	

	if(@$_GET['default_addon']){
		
		$temp_coach_id=$_GET['default_addon'];
		
		$temp_coach_name = $G->get_one_column(['field'=>"get_eav_addon_varchar(id,'CHDN')",
						       'table'=>'entity_child',
						       'manipulation'=>" WHERE id=$temp_coach_id and entity_code='CH' "
						      ]);
	} # 
	
	////////////////////////////////////////////////////// End Coach//
	
	//$F_SERIES['deafult_value']    = array('entity_code' => "'HB'");
	
	$F_SERIES['title'] = $entity['title'];
	
	$F_SERIES['data'][1]['option_data']          = $G->option_builder('entity','code,sn'," WHERE code='$entity[code]'");
	$F_SERIES['data'][1]['avoid_default_option'] = 1;   
	
	// Start Coach //////////////////////////////////////////////////////
	
	$F_SERIES['data'][2]['option_data']          = $G->option_builder('entity_child','id,sn',
								          " WHERE entity_code='$entity[code]' AND parent_id=$temp_coach_id");
	$F_SERIES['data'][2]['avoid_default_option'] = 1;  
	
	////////////////////////////////////////////////////// End Coach //
	//code
	
	$F_SERIES['data'][4]['field_name']   = "Action Name";	
	$F_SERIES['data'][4]['type']         = 'text';	
		
	// sn
	$F_SERIES['data'][5]['field_name'] = "Action URL";
	$F_SERIES['data'][5]['type']       = 'text';	
	$F_SERIES['data'][5]['attr']       = ['class'=>'w_300'];
	
	// ln
	$F_SERIES['data'][6]['field_name'] = "Short Hint";
	$F_SERIES['data'][6]['type']       = "textarea";
	$F_SERIES['data'][6]['attr']       = ['class'=>'w_300'];
	
	//doc
	
	// image
	$F_SERIES['data'][7]['field_name'] = 'Document'; 
 	$F_SERIES['data'][7]['save_file_name_prefix'] = 'ab_';
	$F_SERIES['data'][7]['upload_type']           = 'docs';
	$F_SERIES['data'][7]['location']   = "$COACH[path]$temp_coach_name/docs/";
		
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
	
	// unused
	unset($F_SERIES['data'][3]);
	//unset($F_SERIES['data'][7]);
	unset($F_SERIES['data'][8]);
	
	
	if(@$_GET['default_addon']){

		$F_SERIES['is_back_button']['is_add'] = 0;
	}
	
?>
