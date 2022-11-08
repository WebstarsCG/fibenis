<?PHP

	include($LIB_PATH."def/entity/d.php");
	
	$D_SERIES['title']     = 'External Entity';  
	
	
	$D_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>'f=external_entity', 'b_name' => 'Add External Entity' );
	
	$D_SERIES['data'][3]['field']	= "concat(id,':',(SELECT COUNT(*) FROM entity_child_base WHERE entity_code=entity.code AND dna_code='EBAT'),':',is_lib,':',code)";
	
	$D_SERIES['data'][3]['filter_out'] = function($data_in){
												
							$temp 		= explode(':',$data_in);
	
							$data_out	= array('id'   		=>$temp[0],
										'link_title'	=>$temp[1],
										'is_fa'		=> ' fa fa-folder-o clr_red fa-lg',
										'title'		=> 'Attribute View',
										'is_fa'		=> ' fa-chevron-circle-right clr_orange fa-lg ',
										'is_fa_btn'	=> ' btn-default btn-sm w_50 ',
										'src'		=> "?d=external_attribute&menu_off=1&mode=simple&default_addon=$temp[3]",
										'style'		=> "border:none;width:100%;height:600px;");
							
							 return json_encode($data_out);		 
						};
						
	$D_SERIES['data'][4]['field']	=  "concat(id,':',code)";
							
	$D_SERIES['data'][4]['filter_out'] = function($data_in){
								  
							$temp 	  	=  explode(':',$data_in);
							
							$data_out 	=  array('id'   =>$temp[0],
								'link_title'	=> "Add Attribute",
								'is_fa'		=> ' fa fa-plus-square-o clr_red fa-lg',
								'title'		=> 'Add Attribute',
								'src'		=> "?f=external_attribute&menu_off=1&mode=simple&default_addon=$temp[1]",
								'style'		=> "border:none;width:100%;height:600px;"
							);
						
							return json_encode($data_out);
													 
						};
						
	// ec
						
	$D_SERIES['data'][5]['field']="concat(id,':',(SELECT COUNT(*) FROM entity_child WHERE entity_code=entity.code),':',code)";
	
	$D_SERIES['data'][5]['filter_out'] =function($data_in){
							$temp = explode(':',$data_in);
		
							$data_out = array('id'=>$temp[0],
							  'token'=>'ec_'.$temp[0],
							'link_title'=>$temp[1],
							'is_fa'=>' fa-chevron-circle-right clr_dark_blue fa-lg ',
							'is_fa_btn'=>' btn-default btn-sm ',
							'title'=>'Child View',
							'src'=>"?d=entity_child_addon&menu_off=1&mode=simple&default_addon=$temp[2]&show=1",
							'style'=>"border:none;width:100%;height:600px;");
							 return json_encode($data_out);		 
						};
						
						
	$D_SERIES['data'][6]['filter_out']=function($data_in){
                                                                            
													$temp = explode(':',$data_in);
													
													$data_out = array('id'=>$temp[0],
																
																'link_title'=>'Add Child',
																'is_fa'=>" fa fa-plus-square-o clr_dark_blue fa-lg",
																'title'=>'Add Child',
																//'src'=>"?f=entity_child&menu_off=1&mode=simple&default_addon=$data_in",
																'src'=>"?f=entity_child_addon&menu_off=1&mode=simple&default_addon=$temp[1]:$temp[0]",
																'style'=>"border:none;width:100%;height:600px;"
															);
														
													return json_encode($data_out);
													 
											};
	
	// child base excluding attribute
	
	$D_SERIES['data'][7]['field'] = "concat(id,':',(SELECT COUNT(*) FROM entity_child_base WHERE entity_code=entity.code AND dna_code <> 'EBAT'),':',code)";
	$D_SERIES['data'][7]['filter_out'] = function($data_in){
							$temp = explode(':',$data_in);
							$data_out = array('id'   => $temp[0],
							'link_title'=>$temp[1],
							'is_fa'=>' fa-chevron-circle-right clr_red fa-lg ',
							'is_fa_btn'=>' btn-default btn-sm ',
							'title'=>'Entity Child Base',
							'src'=>"?d=entity_child_base&menu_off=1&mode=EXT&default_addon=$temp[2]",
							'style'=>"border:none;width:100%;height:600px;");
							 return json_encode($data_out);
						};
                                

	$D_SERIES['js']=['is_top'=>1];					
    
?>