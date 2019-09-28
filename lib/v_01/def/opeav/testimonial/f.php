<?PHP

	include($LIB_PATH."def/one_page_general/f.php");
	
	// Start Coach //////////////////////////////////////////////////////
	
	$temp_coach_id=0;	

	if(@$_GET['default_addon']){
		$temp_coach_id=$_GET['default_addon'];		
	}
	
	////////////////////////////////////////////////////// End Coach//
	
//	$F_SERIES['deafult_value']    = array('entity_code' => "'TM'");
	
	$F_SERIES['title'] = "Testimonial";
	
	$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn'," WHERE code='TM'");
	
	$F_SERIES['data'][1]['avoid_default_option'] = 1;
	
	// Start Coach //////////////////////////////////////////////////////
	
	$F_SERIES['data'][9]['option_data'] = $G->option_builder('entity_child','id,sn',
								 " WHERE entity_code='TM' AND parent_id=$temp_coach_id   ");
	$F_SERIES['data'][9]['avoid_default_option'] = 1;
	
	////////////////////////////////////////////////////// End Coach//
	
	$F_SERIES['data'][3]['field_name'] = "Title";
	
	$F_SERIES['data'][3]['allow'] = "x30";
	
	$F_SERIES['data'][4]['field_name'] = "Authour";
	
	$F_SERIES['data'][4]['type'] = "text";
	
	$F_SERIES['data'][4]['allow'] = "x25";
	
	$F_SERIES['data'][5]['field_name'] = "Content";
	
	$F_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>'f=testimonial', 'b_name' => 'Add Testimonial' );
	
	$F_SERIES['back_to'] = array('is_back_button'=>1,'back_link'=>'?d=testimonial', 'BACK_NAME'=>'Back');
	
	unset($F_SERIES['data'][2]);
	
	unset($F_SERIES['data'][7]);
	
	unset($F_SERIES['data'][8]);

	if(@$_GET['default_addon']){

		$F_SERIES['back_to']['is_back_button'] = 0;
	}	
	
	
?>
