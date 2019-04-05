<?PHP
		
	$D_SERIES       =   array(
                                   'title'=>'Theme',
                                    
                                    'gx'	=> 1,
				    
	                            'data'=> array(
                                                       1=>array('th'=>'Code',
								 
								'field'=>"get_eav_addon_varchar(id,'ECSN')",
								
								//'field'=>"id",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'10%',
									   'class'=> ' label_grand_father '
									   ],
                                                                            
								),
							
								
							 2=>array('th'=>'Name',
									 
								'field'=>"get_eav_addon_varchar(id,'ECLN')",
									 
								'td_attr' => ' class="label_child align_LM" width="23%"',
								
								'is_sort' => 0
									 
								),
							 
							
							 
							 
							3=>array('th'	=> 'Blend', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "id",
								
								'attr' =>  [ 'class'=>"", 'width' => "6%"],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
						
													$data_out = array('id'   => $temp[0],
												         
													 'link_title'=>'  '.$temp[1],
													 'is_fa'=>' fa-chevron-circle-right clr_dark_blue fa-lg ',
													 'is_fa_btn'=>' btn-default btn-sm ',
													 'title'=>'Child View',
												         'src'=>"?d=create_theme__blend_source&menu_off=1&mode=simple&default_addon=$temp[0]",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
							4=>array('th'	=> '',
								     
								  'field'	=> 'id',
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
													'link_title'=>'Add Child',
													'is_fa'=>' fa fa-plus-square-o clr_dark_blue fa-lg',
													'title'=>'Add Child',
													'src'=>"?f=create_theme__blend_source&menu_off=1&mode=simple&default_addon=$data_in",
													'style'=>"border:none;width:100%;height:600px;"
												  );
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							5=>array('th'	=> 'Layout', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "id",
								
								'attr' =>  [ 'class'=>"", 'width' => "6%"],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
						
													$data_out = array('id'   => $temp[0],
												         
													 'link_title'=>'  '.$temp[1],
													 'is_fa'=>' fa-chevron-circle-right clr_green fa-lg ',
													 'is_fa_btn'=>' btn-default btn-sm ',
													 'title'=>'Child View',
												         'src'=>"?d=page_layout&menu_off=1&mode=simple&default_addon=$temp[0]",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
							6=>array('th'	=> '',
								     
								  'field'	=> 'id',
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
													'link_title'=>'Add Child',
													'is_fa'=>' fa fa-plus-square-o clr_green fa-lg',
													'title'=>'Add Child',
													'src'=>"?f=page_layout&menu_off=1&mode=simple&default_addon=$data_in",
													'style'=>"border:none;width:100%;height:600px;"
												  );
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							7=>array('th'	=> 'Template', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "id",
								
								'attr' =>  [ 'class'=>"", 'width' => "6%"],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
						
													$data_out = array('id'   => $temp[0],
												         
													 'link_title'=>'  '.$temp[1],
													 'is_fa'=>' fa-chevron-circle-right clr_red fa-lg ',
													 'is_fa_btn'=>' btn-default btn-sm ',
													 'title'=>'Child View',
												         'src'=>"?d=page_template&menu_off=1&mode=simple&default_addon=$temp[0]",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
							8=>array('th'	=> '',
								     
								  'field'	=> 'id',
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
													'link_title'=>'Add Child',
													'is_fa'=>' fa fa-plus-square-o clr_red fa-lg',
													'title'=>'Add Child',
													'src'=>"?f=page_template&menu_off=1&mode=simple&default_addon=$data_in",
													'style'=>"border:none;width:100%;height:600px;"
												  );
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							
							 
							 9=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="20%"',
								
								'js_call'=> 'show_user_info',
									 
								),
							
							 
							),
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
				    'order_by'   =>'ORDER BY id ASC ' ,
				    
				    
				    
				    #Search
				
				'search'=> 	array(),
				
				'search_filter_off' => 1,
				
				       		
                                
				#Table Info
				
				'table_name' =>'entity_child',
				
				'key_id'    =>'id',
				
				# Default Additional Column
			    
				'is_user_id'       => 'user_id',
			    
				# Communication
			    
				'prime_index'   => 1,
				
				'is_narrow_down' => 1,
				
				'key_filter' => "AND entity_code='TH'",
			    
                                'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=create_theme', 'b_name' => 'Add Theme' ),
								
					'del_permission' => array('able_del'=>0,
								  
								  'avoid_del_field' => "if(((SELECT 	(select count(*) FROM  eav_addon_ec_id as ec WHERE ea_code='ECPR' AND ec.ec_id = entity_child.id) )
											> 0),1,0)",
											
								
								// 'avoid_del_field' => "if(((SELECT 	(select count(*) FROM  eav_addon_ec_id as ec WHERE ea_code='ECPR' AND ec.ec_id = entity_child.id) +
								//					(select count(*) FROM  entity_child_base as ecb WHERE parent_id = (SELECT ecb.id FROM ecb WHERE ecb.entity_code='TH'
								//					 AND ecb.token=(SELECT ea_value FROM eav_addon_varchar WHERE parent_id = entity_child.id AND ea_code='ECSN')))
								//			> 0),1,0)",								  
								// 
											
											
								  'avoid_del_value' => 1
								  
							),
					
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA',
				
				'show_query' => 0,
                            
				'before_delete' => 0,
                            
                            );
	
	
	function before_delete($param){
		
		global $LIB_PATH;
		
		 $lv 	      = array();
		
		$lv['result'] = $param['g']->get_one_cell(['table'=>'eav_addon_varchar',
						    'field'=>"ea_value",
						    'manipulation'=>" WHERE ea_code='ECSN' AND parent_id=$param[key_id]" 
						    ]);
		
		$lv['dir'] = $LIB_PATH.'def/create_theme/template/'.$lv['result'];
		
		$dir = get_config('theme_path').'/'.$lv['result'];
		
		
		
	} // end
	
	
?>