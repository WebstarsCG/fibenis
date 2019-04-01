<?PHP
	
	$home_banner_img =  $SG->get_session('home_banner_img');
	
	#$home_banner_path =  $SG->get_cookie('home_banner_path');

	include($LIB_PATH."def/opg_v2_eav/f.php");
	
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
	
	$F_SERIES['title'] 			     =  "Home Banner";
	
	$F_SERIES['data'][1]['option_data']          =  $G->option_builder('entity',
									   "code,sn ",
									   " WHERE code='HB'");
	$F_SERIES['data'][1]['avoid_default_option'] =  1;   
	
	// Start Coach //////////////////////////////////////////////////////
	
	$F_SERIES['data'][2]['option_data']          = $G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECSN') as sn",
								          " WHERE entity_code='HB' AND get_ec_parent_id_eav(id)=$temp_coach_id");
	$F_SERIES['data'][2]['avoid_default_option'] = 1;  
	
	////////////////////////////////////////////////////// End Coach //
	
	// sn
	$F_SERIES['data'][4]['field_name'] = "Button Name";
	
	// ln
	$F_SERIES['data'][5]['field_name'] = "Button URL";
	
	// detail
	
	$F_SERIES['data'][6]['field_name']          = 'Heading Text';
	$F_SERIES['data'][6]['is_plugin']           =  1;
	$F_SERIES['data'][6]['type']                =  'handsontable';
	
	$F_SERIES['data'][6]['default_rows_prop']   =  ['start_rows'    =>'4', // default number of rows
							  'min_spare_rows'=>'0', // empty rows setup
							  'max_rows'      =>'4' // maximum allowed rows
							];
	
	$F_SERIES['data'][6]['colHeaders']	   = [ ['column'=>'Heading', // Column Header Name
							    'width' =>'500',      // Column Width                                               
							    // Type ( text,numeric,dropdown) 
							    'type'  =>'text']];
		
	// image
	
	$F_SERIES['data'][7]['save_file_name_prefix'] = 'hb_';
	
	$F_SERIES['data'][7]['image_size'] = json_decode($home_banner_img,TRUE);
	
	$F_SERIES['data'][7]['location'] = "$COACH[path]$temp_coach_name/images/";
	
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>'f=home_banner', 'b_name' => 'Add Home Banner' );
	
	// unused
	
	unset($F_SERIES['data'][3]);
	
	unset($F_SERIES['data'][8]);
	
	
	if(@$_GET['default_addon']){

		$F_SERIES['is_back_button']['is_add'] = 0;
		
		$LAYOUT	    = 'layout_full';
    
	}
	
	$F_SERIES['show_query'] = 0;
	
	$F_SERIES['avoid_trans_key_direct']=0;
	
?>
