<?PHP

	include($LIB_PATH."def/opg_v2_eav/f.php");

	$img_size =  $SG->get_session('aboutus_image_size');
	
	$entity= ['code'=>'HA',
			'title'=>'Home About Us ',
			'page_code'=>'about_us'
			];
	
	// Start Coach //////////////////////////////////////////////////////
	
	$temp_coach_id	= 0;	

	if(@$_GET['default_addon']){
		
		$temp_ec_id=$_GET['default_addon'];
		
		$temp_coach_name = $G->get_one_column(['field'=>"get_eav_addon_vc128uniq(id,'CHCD')",
						       'table'=>'entity_child',
						       'manipulation'=>" WHERE id=get_ec_parent_id_eav($temp_ec_id) AND entity_code='CH' "
						      ]);
	} # 
	
	////////////////////////////////////////////////////// End Coach//
	// cache
	$F_SERIES['is_cc'] = 1; 
	
	//$F_SERIES['deafult_value']    = array('entity_code' => "'HB'");
	
	$F_SERIES['title'] = $entity['title'];
	
	$F_SERIES['data'][1]['option_data']          = $G->option_builder('entity','code,sn'," WHERE code='$entity[code]'");
	$F_SERIES['data'][1]['avoid_default_option'] = 1;   
	
	// Start Coach //////////////////////////////////////////////////////
	
	$F_SERIES['data'][2]['option_data']          = $G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECSN') as sn",
								          " WHERE id=$temp_ec_id AND  entity_code='$entity[code]' ");
	$F_SERIES['data'][2]['avoid_default_option'] = 1;  
	
	////////////////////////////////////////////////////// End Coach //
	
	// sn
	$F_SERIES['data'][4]['field_name'] = "Heading";
	$F_SERIES['data'][4]['attr']       = ['class'=>'w_300'];
	
	// ln
	$F_SERIES['data'][6]['field_name'] = "Content";
	$F_SERIES['data'][6]['type']       = "textarea";
	$F_SERIES['data'][6]['attr']       = ['class'=>'w_500','rows'=>'7'];
		
	// image
	$F_SERIES['data'][7]['field_name'] = 'Image'; 
 	$F_SERIES['data'][7]['save_file_name_prefix'] = 'ha_';	
	$F_SERIES['data'][7]['image_size'] = json_decode($img_size,TRUE);	
	$F_SERIES['data'][7]['location']   = "$COACH[path]$temp_coach_name/images/";
				
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
	
	// unused
	unset($F_SERIES['data'][3]);
	unset($F_SERIES['data'][5]);
	unset($F_SERIES['data'][8]);
	
	
	if(@$_GET['default_addon']){

		$F_SERIES['is_back_button']['is_add'] = 0;
		
		$LAYOUT	    = 'layout_full';
    
	}
	
?>
