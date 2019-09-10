<?PHP

	include($LIB_PATH."def/opg_v2/f.php");

	$img_size =  $SG->get_cookie('logo_size');
	
	$entity= ['code'     => 'HX',
		  'title'    => 'Home Content Others',
		  'page_code'=> 'home_content_x'
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
	$F_SERIES['data'][5]['field_name'] = "Short Content";
	$F_SERIES['data'][5]['type']       = 'text';
	$F_SERIES['data'][5]['attr']       = ['class'=>'w_300'];

				
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
	
	// unused
	unset($F_SERIES['data'][3]);
	unset($F_SERIES['data'][4]);
	unset($F_SERIES['data'][6]);
	unset($F_SERIES['data'][7]);
	unset($F_SERIES['data'][8]);
	unset($F_SERIES['data'][9]);
	
	
	if(@$_GET['default_addon']){

		$F_SERIES['is_back_button']['is_add'] = 0;
	}
	

	
?>
