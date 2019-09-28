<?PHP

	include($LIB_PATH."def/about_us/f.php");
	
	$entity= ['code'=>'G2',
			'title'=>'Grid 2',
			'page_code'=>'g2'
			];
	
	
	$F_SERIES['title'] = $entity['title'];
	
	$F_SERIES['data'][1]['option_data']          = $G->option_builder('entity','code,sn'," WHERE code='$entity[code]'");
	$F_SERIES['data'][1]['avoid_default_option'] = 1;   
	
	// Start Coach //////////////////////////////////////////////////////
	
	$F_SERIES['data'][2]['option_data']          = $G->option_builder('entity_child','id,sn',
								          " WHERE entity_code='$entity[code]' AND parent_id=$temp_coach_id");
	$F_SERIES['data'][2]['avoid_default_option'] = 1;  
	
	////////////////////////////////////////////////////// End Coach //
	
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
	
	$F_SERIES['data'][7]['image_size'] = [640=>400];
	
	
	//// Image Zoom
	$F_SERIES['data'][3]['field_name'] = "Image Zoom";
	$F_SERIES['data'][3]['field_id']   = "code";
	$F_SERIES['data'][3]['type']       = 'option';
	$F_SERIES['data'][3]['option_data']= '<option value="1">Yes</option><option value="0">No</option>';
	$F_SERIES['data'][3]['avoid_default_option']=1;

?>
