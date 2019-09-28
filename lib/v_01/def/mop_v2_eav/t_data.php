<?php

    $T_SERIES['temp']['section']=[

						'detail'=>array('field' =>"get_eav_addon_text(id,'ECDT')"),
						
						
						
						# accordion_heading
						
						'accordion_heading'=>array(
								       
									 'is_child_addon' =>1,
									'child_data'   =>array(
													'1'=>array('key'=>'heading',    'field' =>"get_eav_addon_varchar(id,'ECLN')"),
													'2'=>array('key'=>'sub_heading','field' =>"get_eav_addon_text(id,'ECDT')" )
										),
									
									'table'=> ' entity_child',
									
									'key_filter'=>" AND id={{SEC_ID}} AND entity_code='AC' AND is_active=1
									                AND get_ec_parent_id_eav(id)=get_coach_id_by_code('$coach_code')",
									
									'show_query'=>0
								       
								       ),
						
						
						# accordion
						
						'accordion'=>array(
								'is_child_addon' =>1,
								'child_data'   =>array(
												'1'=>array('key'=>'question','field' =>"get_eav_addon_varchar(id,'ECLN')"),
												'2'=>array('key'=>'answer','field' =>"get_eav_addon_text(id,'ECDT')" ),
												
												
												
									),
								
								'table'=> ' entity_child',
								
								'key_filter'=>" AND get_ec_parent_id_eav(id)={{SEC_ID}} AND entity_code='AC' 										
										AND get_ec_status(get_ec_parent_id_eav(id))=1
										ORDER BY line_order
										",
								
								'show_query'=>0
								
						),
						
						
						# aboutus_heading
						
						'home_aboutus_heading'=>array(
								       
									'is_child_addon' => 1,
									'child_data'   	 => array(
													'1'=>array('key'=>'heading',   'field' =>"get_eav_addon_varchar(id,'ECLN')"),
													'2'=>array('key'=>'sub_heading','field' =>"get_eav_addon_varchar(id,'ECDT')" )
										),
									
									'table'=> ' entity_child',
									
									'key_filter'=>" AND id={{SEC_ID}} AND entity_code='HA'
									                AND get_ec_parent_id_eav(id)=get_coach_id_by_code('$coach_code')",
									
									'show_query'=>0
								       
								       ),
						
						
						# about us
						
						'home_aboutus'=>array(
								'is_child_addon' =>1,
								'child_data'   =>array(
												'1'=>array('key'=>'title','field' =>"get_eav_addon_varchar(id,'ECSN')"),
												'2'=>array('key'=>'content','field' =>"get_eav_addon_text(id,'ECDT')"),
												'3'=>array('key'=>'image','field' =>"get_eav_addon_varchar(id,'ECIA')")
												
												
									),
								
								'table'=> ' entity_child',
								
								'key_filter'=>" AND get_ec_parent_id_eav(id)={{SEC_ID}} AND entity_code='HA' 
										AND get_ec_status(get_ec_parent_id_eav(id))=1
										ORDER BY line_order
									    ",
								
								'show_query'=>0
								
						),
						
						
						
						'home_banner'=>array(
									'is_child_addon' =>1,
									
									'child_data'   =>array(
													'1'=>array('key'=>'btn_title','field'=>"get_eav_addon_varchar(id,'ECSN')"),
													'2'=>array('key'=>'url','field'=>"get_eav_addon_varchar(id,'ECLN')"),
													'3'=>array('key'=>'img_src','field'=>"get_eav_addon_varchar(id,'ECIA')"),
													
													'4'=>array(	'key'		=> 'heading',
														   
														        'field'=>"get_eav_addon_text(id,'ECDT')",
														   
															'filter_out'	=> function($data_in){
																	
																			$lv = [];
																			
																			$lv['data']    = json_decode($data_in,true);
																			
																			$lv['content'] = [];
																			
																			if($lv['data']){
																			
																			    foreach($lv['data'] as $data_key=>$data_info){
																				    
																				    if(@$data_info[0]){
																					    array_push($lv['content'],['title'=>@$data_info[0]]);
																				    } // end
																			    }
																			}
																		
																			return $lv['content'];																	
																		} // end														   
														),
													
													
										),
									
									'table'=> ' entity_child',
									
									'key_filter'=>" AND get_ec_parent_id_eav(id)={{SEC_ID}} AND entity_code='HB' 										
											AND get_ec_status(get_ec_parent_id_eav(id))=1
											ORDER BY line_order
											",
									
									'show_query'=>0
									
						),
						
						
						# enquiry & Contact
												
						'contact'	=>	array('field' => "(SELECT is_active FROM entity_child WHERE entity_code='CX' AND id=(SELECT id FROM entity_child as ec2 WHERE entity_code='CX' AND get_ec_parent_id_eav(ec2.id)=(SELECT parent_id FROM eav_addon_vc128uniq WHERE ea_code='CHCD' AND ea_value='$coach_code')))"),
						
						
						
						

						
						'contact_info'	=>	array(
										'is_child_addon'=> 1,
										
										'child_data'   	=> array(
														'1'=>array('key'=>'org_name','field'=>"get_eav_addon_varchar(id,'CXFN')"),
														'2'=>array('key'=>'add_i',   'field'=>"get_eav_addon_varchar(id,'CXRA')"),
														'3'=>array('key'=>'add_ii',  'field'=>"get_eav_addon_varchar(id,'CXRB')"),
														'4'=>array('key'=>'phone',   'field'=>"get_eav_addon_varchar(id,'CXLD')"),
														'5'=>array('key'=>'mobile',  'field'=>"get_eav_addon_varchar(id,'CXMB')"),
														'6'=>array('key'=>'email',   'field'=>"get_eav_addon_varchar(id,'CXEM')"),
													),
										
										'table'		=> 	' entity_child',
										
										'key_filter'	=>	" AND entity_code='CX'  
													  AND get_ec_parent_id_eav(id)=(SELECT id FROM entity_child as ec2 WHERE entity_code='CX' AND get_ec_parent_id_eav(ec2.id)=(SELECT parent_id FROM eav_addon_vc128uniq WHERE ea_code='CHCD' AND ea_value='$coach_code'))
													  AND get_ec_status(get_ec_parent_id_eav(id))=1
													  ORDER BY line_order",
										
										'show_query'	=>0									
						),
						
						# home images
						
						
						'home_images'	=>	array(
										'is_child_addon'=> 1,
										
										'child_data'   	=> array(
														'1'=>array('key'=>'data_binder','field'=>"get_eav_addon_varchar(id,'ECCD')"),
														'2'=>array('key'=>'content_src','field'=>"get_eav_addon_varchar(id,'ECIA')")														
													),
										
										'table'		=> 	'entity_child',
										
										'key_filter'=>" AND get_ec_parent_id_eav(id)={{SEC_ID}} AND entity_code='HI' 
												AND get_ec_status(get_ec_parent_id_eav(id))=1
												ORDER BY line_order",
												
										'show_query'	=> 0									
									),
						
						'marquee'=>array(
									'is_child_addon' =>1,
									'child_data'   =>array(
													'1'=>array('key'=>'Title','field'=>"get_eav_addon_varchar(id,'ECLN')"),
													'2'=>array('key'=>'url','field'=>"get_eav_addon_varchar(id,'ECSN')" ),
													
													
										),
									
									'table'=> ' entity_child',
									
									'key_filter'=>" AND get_ec_parent_id_eav(id)={{SEC_ID}} AND entity_code='MQ'
											AND get_ec_status(get_ec_parent_id_eav(id))=1
											ORDER BY line_order
											",
									
									'show_query'=>0
									
						),
						
				
	]

?>