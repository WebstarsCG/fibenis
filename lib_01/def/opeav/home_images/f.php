<?PHP

	include($LIB_PATH."def/opg_v2_eav/f.php");

	$img_size =  $SG->get_session('logo_size');
	
	$entity= ['code'     => 'HI',
		  'title'    => 'Home Images',
		  'page_code'=> 'home_images'
		];
	
	// Start Coach //////////////////////////////////////////////////////
	
	$temp_coach_id	= 0;	

	if(@$_GET['default_addon']){
		
		$temp_coach_id=$_GET['default_addon'];
		
		$temp_coach_name = $G->get_one_column(['field'=>"get_eav_addon_vc128uniq(id,'CHCD')",
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
	
	$F_SERIES['data'][2]['option_data']          = $G->option_builder('entity_child',"id, get_eav_addon_varchar(id,'ECSN') as sn ",
								          " WHERE entity_code='$entity[code]' AND get_ec_parent_id_eav(id)=$temp_coach_id");
	$F_SERIES['data'][2]['avoid_default_option'] = 1;  
	
	////////////////////////////////////////////////////// End Coach //
	
	// sn
	$F_SERIES['data'][3]['field_name'] = "Binder";
	$F_SERIES['data'][3]['attr']       = ['class'=>'w_50','allow'=>'a16'];
	
	// ln
	$F_SERIES['data'][4]['field_name'] = "Title";
	$F_SERIES['data'][4]['type']       = 'text';
	$F_SERIES['data'][4]['attr']       = ['class'=>'w_300'];
		
	// image
	$F_SERIES['data'][7]['field_name'] = 'Image'; 
 	$F_SERIES['data'][7]['save_file_name'] = 'logo';	
	$F_SERIES['data'][7]['image_size'] = json_decode($img_size,TRUE);	
	$F_SERIES['data'][7]['location']   = "$COACH[path]$temp_coach_name/images/";
				
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
	
	// unused
	unset($F_SERIES['data'][5]);
	unset($F_SERIES['data'][6]);
	unset($F_SERIES['data'][8]);
	unset($F_SERIES['data'][9]);
	
	
	if(@$_GET['default_addon']){

		$F_SERIES['is_back_button']['is_add'] = 0;
		
		$LAYOUT	    = 'layout_full';
    
	}
	
	# before add update
	
	$F_SERIES['before_add_update']=function($param){
	
		global $F_SERIES,$SG;	
		
		$lv = [];
		
		$lv['binder'] = $param['X3'];
		$img_size     =  $SG->get_session($lv['binder'].'_size');
	
		$F_SERIES['data'][7]['image_size']     = json_decode($img_size,TRUE);	
		$F_SERIES['data'][7]['save_file_name'] = $lv['binder'];
		
	} // end
	
?>
