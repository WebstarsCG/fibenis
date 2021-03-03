<?PHP
              
        $D_SERIES       =   array(
		
		
					'title'=>'Core Entity ',
                                    					
					#generation
					'gx'=>1,
                                    
					#table data                                    
					'data'=> [
					
							1=>array(
								'th'      => 'Code',
								'field'   => 'code',																
								'td_attr' => ' width="5%" class="clr_dark_blue txt_size_12" ',
								'is_sort' => 1,
							),							  
					
							2=>array('th'=>'Name',
								 
								'field'=>'sn',
									
								'attr' =>  ['width' => "24%",
									    'class' => "txt_size_13 b" ],
								
								'is_sort' => 1,
								
                                                                            
								),
						
							
							
							3=>array('th'	=> 'Attr.', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "concat(id,':',(SELECT COUNT(*) FROM entity_attribute WHERE entity_code=entity.code),':',is_lib)",
								
								'attr' =>  [ 'class'=>"align_CM", 'width' => "6%",],
									
                                                                'filter_out'=>function($data_in){
												
												$temp = explode(':',$data_in);
						
												$data_out = array('id'   => $temp[0],
												 'link_title'=>'  '.$temp[1],
												 'is_fa'=>' fa fa-folder-o clr_red fa-lg',
												 'title'=>'Attribute View',
												 'is_fa'=>' fa-chevron-circle-right clr_orange fa-lg ',
												 'is_fa_btn'=>' btn-default btn-sm w_50 ',
												 'src'=>"?d=entity_attribute&menu_off=1&mode=simple&default_addon=$temp[0]&show=1",
												 'style'=>"border:none;width:100%;height:600px;");
												 return json_encode($data_out);
													 
													 
									},
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
							4=>array('th'	=> '',
								     
								  'field'	=> "concat(id,':',code)",
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
								  
												$temp 	  	=  explode(':',$data_in);
												
												$data_out 	=  array('id'   => $temp[0],
													'link_title'	=> "Add Attribute",
													'is_fa'		=> ' fa fa-plus-square-o clr_red fa-lg',
													'title'		=> 'Add Attribute',
													'src'		=> "?f=entity_attribute&menu_off=1&mode=simple&default_addon=$temp[1]",
													'style'		=> "border:none;width:100%;height:600px;"
												);
											
												return json_encode($data_out);
													 
										},
                                                                        
										'js_call'=>'d_series.set_nd'                                                                        
								),
							
							5=>array(
								 
								'th'		=> 'Child',
								
								'th_attr'=>' colspan=2 ',
								     
								'field'		=> "concat(id,':',(SELECT COUNT(*) FROM entity_child WHERE entity_code=entity.code))",
								
								'attr' 		=> [ 'class'=>"", 'width' => "6%"],
									
                                                                'filter_out'	=> function($data_in){
													$temp = explode(':',$data_in);
						
													$data_out = array('id'   => $temp[0],
												         
													 'link_title'=>'  '.$temp[1],
													 'is_fa'=>' fa-chevron-circle-right clr_dark_blue fa-lg ',
													 'is_fa_btn'=>' btn-default btn-sm ',
													 'title'=>'Child View',
												         'src'=>"?d=entity_child&menu_off=1&mode=simple&default_addon=$temp[0]&show=1",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                'js_call'=>'d_series.set_nd'
									
									
                                                                        
								),
							
							6=>array('th'	=> '',
								     
								  'field'	=> "concat(id,':',code)",
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
                                                                            
													$temp = explode(':',$data_in);
													
													$data_out = array('id'   => $temp[0],
																'link_title'=>'Add Child',
																'is_fa'=>' fa fa-plus-square-o clr_dark_blue fa-lg',
																'title'=>'Add Child',
																//'src'=>"?f=entity_child&menu_off=1&mode=simple&default_addon=$data_in",
																'src'=>"?f=entity_child_addon&menu_off=1&mode=simple&default_addon=$temp[1]",
																'style'=>"border:none;width:100%;height:600px;"
															);
														
													return json_encode($data_out);
													 
											},
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								),
							
							
							7=>array('th'	=> 'Child Base', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "concat(id,':',(SELECT COUNT(*) FROM entity_child_base WHERE entity_code=entity.code),':',code)",
								
								'attr' =>  [ 'class'=>"", 'width' => "6%"],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
								
                                                                            
													$data_out = array('id'   => $temp[0],
													'link_title'=>'  '.$temp[1],
													'is_fa'=>' fa-chevron-circle-right clr_red fa-lg ',
													'is_fa_btn'=>' btn-default btn-sm ',
													'title'=>'Entity Child Base',
												        'src'=>"?d=entity_child_base&menu_off=1&mode=simple&default_addon=$temp[2]&show=1",
												        'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
								8=>array('th'	=> '',
								     
								  'field'	=> "concat(id,':',code)",
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
												
												$temp = explode(':',$data_in);
												//if($temp[1]==0){
                                                                            
													$data_out = array('id'   => $temp[0],
													'link_title'=>'Add Entity Child Base',
													'is_fa'=>' fa fa-plus-square-o txt_size_18 clr_red fa-lg',
													'title'=>'Add Child Base',
													'src'=>"?f=entity_child_base&menu_off=1&mode=simple&default_addon=$temp[1]",
													'style'=>"border:none;width:100%;height:600px;");
												//}else{
												//	$data_out = array('id'   => $temp[3],
												//			'link_title'=>'Not Applicable',
												//			'is_fa'=>'fa-ban txt_size_12 clr_red ',
												//			'title'=>'Not Applicable',
												//			'src'=>"",
												//			'style'=>"border:none;width:100%;height:600px;");
												//}
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							
							
							
							
							9=>array('th'	=> 'Key Value', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "concat(id,':',(SELECT COUNT(*) FROM entity_key_value WHERE entity_code=entity.code))",
								
								'attr' =>  [ 'class'=>"", 'width' => "6%",],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
									    
													$data_out = array('id'   => $temp[0],
													'link_title'=>'  '.$temp[1],
													'is_fa'=>' fa-chevron-circle-right clr_sky_blue fa-lg ',
													'is_fa_btn'=>' btn-default btn-sm ',
													'title'=>'Entity Key Value',
												         'src'=>"?d=entity_key_value&menu_off=1&mode=simple&default_addon=$temp[0]",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
							
							
							10=>array('th'	=> '',
								     
								  'field'	=> 'id',
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
													'link_title'=>'Add Entity Key Value',
													'is_fa'=>' fa fa-plus-square-o clr_sky_blue fa-lg',
													'title'=>'Add Key Value',
													'src'=>"?f=entity_key_value&menu_off=1&mode=simple&default_addon=$data_in",
													'style'=>"border:none;width:100%;height:600px;"
												  );
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
//							11=>array('th'	=> 'Addon',
//								     
//								  'field'	=> "concat(id,':',code)",
//								  
//								  'attr' =>  [ 'class'=>"brdr_right align_CM" , 'width'=>"3%"],
//									
//								  'filter_out'=>function($data_in){
//										
//													$temp = explode(':',$data_in);
//									    
//													$data_out = array('id'   => $temp[0],
//													'link_title'=>'Addon',
//													'is_fa'=>' fa fa-files-o clr_green fa-lg',
//													'title'=>'Add Child Base',
//													'src'=>"?f=entity_child_addon&menu_off=1&mode=simple&default_addon=$temp[1]",
//													'style'=>"border:none;width:100%;height:600px;"
//												  );
//														
//													return json_encode($data_out);
//													 
//												 },
//                                                                        
//                                                                        'js_call'=>'d_series.set_nd'
//                                                                        
//								    ),
//							
							12=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'attr' => [ 'width'=>"12%"],
								
								'js_call'=> 'show_user_info_2l',
									 
								),
								
						 ],
				    
                                    
                                    #Sort Info
                                      
                                       
                                        
                                       'action' => array('is_action'=>1, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY sn ASC ' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity',
                                    
                                    'key_id'    =>'id',
				    
				    'hidden_data'=>array('code'),
                                    
                                    # Default Additional Column                         
                                
                                    # Communication
                                
                                    'prime_index'   => 2,
				    
				    'key_filter'    => ' AND is_lib=1',	
				    				    
				    #narrow_down
				    
				    'is_narrow_down'=>1,
				   
                                    # File Include
                                    
                                   'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity',
										'field_id'	=> 'id',
										'field_name' 	=> 'sn',
										'filter'	=> ' AND is_lib=1 ' 
									     ),
												     
								'title' 		=> 'Name',										
								'search_key' 		=> 'id',													       
								'is_search_by_text' 	=> 0,
							     ),							
							
						       ),
				   
				   
					//  'custom_filter' => array(  			     						   
					//		      
					//		      array(  'field_name'       => 'Entity',
					//										       
					//				'field_id'         => 'cf1',   
					//												 
					//				'filter_type'      => 'option_list', 
					//														     
					//				'option_value'     => '<option value=FALSE>Application</option><option value=1>Library</option>',
					//				
					//				'html'             => 'title="Select Super Entity"   data-width="80px"  ',
					//										     
					//				'cus_default_label'=>'Show All',
					//			
					//				'filter_by'        => 'is_lib'
					//			),
					//		      
					//		 ),
					  
					   'summary_data'=>array(
								array(  'name'=>'Entities:','field'=>'(SELECT count(id) FROM entity as en WHERE en.is_lib=1)','html'=>'class=summary'),
								//array(  'name'=>'App','field'=>'(SELECT count(id) FROM entity as en WHERE en.is_lib=0)','html'=>'class=summary'),
								
						),
										 
				
				#check_field
												
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity', 'b_name' => 'Add Entity' ),
								
					'del_permission' => array('able_del'=>1,
								  
								  'avoid_del_field' => 'if(((SELECT 	(select count(*) FROM  entity_child as ec WHERE ec.entity_code=entity.code) +
													(select count(*) FROM  entity_child_base  as ec WHERE ec.entity_code=entity.code) +
													(select count(*) FROM  entity_key_value  as ec WHERE ec.entity_code=entity.code) +
													(select count(*) FROM  entity_attribute  as ec WHERE ec.entity_code=entity.code))
											> 0),1,0)',								  
								  'avoid_del_value' => 1
								  
							), 
								
					
								
				#export data
				
				'export_csv'   => array('is_active' => 0,																				
							'export_csv_data'=>  array(
											array('th'   =>'Code','field'=>'code' ),
											array('th'   =>'Name','field'=>'sn' )
										) // end							
							),
                            
                            );
	
	# customization
	if($PAGE_NAME=='entity'){
		
		unset($D_SERIES['data'][9]);
		unset($D_SERIES['data'][10]);
		unset($D_SERIES['data'][11]);
		
	}
    
?>