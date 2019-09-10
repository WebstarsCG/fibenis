<?PHP

	$home_banner_img =  $SG->get_cookie('home_banner_img');
	
	#$home_banner_path =  $SG->get_cookie('home_banner_path');

	include($LIB_PATH."def/opg_v2/f.php");
	
	$entity= ['code'=>'TB',
			'title'=>'Tab Content',
			'page_code'=>'tab'
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
	
	// ln
	$F_SERIES['data'][4]['field_name'] = "Tab Title";
	$F_SERIES['data'][4]['attr']       = ['class'=>'w_300'];
	
	// ln
	$F_SERIES['data'][6]['field_name'] = "Content";
	$F_SERIES['data'][6]['type']       = "textarea_editor";
		
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
	
	// unused
	
	unset($F_SERIES['data'][3]);	
	unset($F_SERIES['data'][5]);
	unset($F_SERIES['data'][7]);
	unset($F_SERIES['data'][8]);
	
	
	if(@$_GET['default_addon']){

		$F_SERIES['is_back_button']['is_add'] = 0;
	}
	
?>
