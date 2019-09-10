<?PHP
	
        $D_SERIES       =   array(
                                   'title'=>'Entity Child',
                                    
                                    #query display depend on the user
                                    
                                    'gx'	=> 1,
				    
				    #table data
                                    
                                    'data'=> array(
					                
							3=>array('th'=>'Entity Name',
									 
								'field'=>'(SELECT sn FROM entity WHERE entity.code=entity_code)',
                                                                   
								'td_attr' => ' class="label_father align_LM" width="20%"',
								
								'is_sort' =>1
									 
								),
					
                                                        1=>array('th'=>'Name',
								 
								'field'=>"get_eav_addon_varchar(id,'ECSN')",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'22%',
									   'class'=> ' label_grand_father '
									   ],
                                                                            
								),
							
							//4=>array('th'=>'Child Code',
							//	 
							//	'field'=>'code',
							//	
							//	'is_sort' => 1,	
							//	
							//	'td_attr' => ' width="20%" ',
							//                                                                     
							//	), 
//

//                                                        2=>array('th'=>'Status',
//									 
//								'field'=>'(SELECT sn FROM entity_attribute WHERE entity_attribute.code=status_code)',                                                                   
//								
//								'td_attr' => ' class="label_child align_LM" width="25%"',
//									 
//								),
							
							 5=>array('th'=>'Long Name',
									 
								'field'=>"get_eav_addon_varchar(id,'ECLN')",
									 
								'td_attr' => ' class="label_child align_LM" width="23%"',
								
								'is_sort' => 0
									 
								),
							 
							 6=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="25%"',
								
								'js_call'=> 'show_user_info',
								
								'is_sort' => 1
									 
								),
							),
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
				    'order_by'   =>'ORDER BY id ASC ' ,
				    
				   
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Entity:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn'," ORDER BY sn ASC"),
							    
										'html'=>'  title="Select Client"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "entity_code"  // main table value
									),
							),
				    
				    #Search
				
				'search'=> 	array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_child',
										'field_id'	=> "get_eav_addon_varchar(id,'ECSN')",
										'field_name' 	=> "get_eav_addon_varchar(id,'ECSN')",
										 
									 ),
							      
								'title' 		=> 'Name',										
								'search_key' 		=> "get_ecsn(id)",													       
								'is_search_by_text' 	=> 1, //( For Text search case)	      
							),
								
						),
				
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 3,
                                
                                    # File Include
                                
                                 
				'key_filter'	=>'',
				
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Child' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA',
				
				//'show_query' 	=> 1
                            
                            );
	
	
	if(@$_GET['default_addon']){

		$default_addon	        = @$_GET['default_addon'];
        	$D_SERIES['key_filter'].="AND  entity_code=(SELECT code FROM entity WHERE id = $default_addon)";
		
		unset($D_SERIES['data'][1]);
		unset($D_SERIES['export_csv']);
		
		$D_SERIES['action']['is_edit']=0;
		$D_SERIES['add_button']['is_add']=0;
		//$D_SERIES['del_permission']['able_del']=0;
		$D_SERIES['is_narrow_down'] = 1;
	
		$D_SERIES['summary_data'] = [];
		
		$LAYOUT	    = 'layout_full';
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['search_filter_off']	=1;
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['hide_pager'] = 1;
		$D_SERIES['show_all_rows']=1;
		$D_SERIES['filter_off'] = 1;
		# d_series data push
		
		array_push($D_SERIES['data'],[	'th'	=> 'Child',
			      
						'th_attr'=>' colspan=2 ',
						     
						'field'	=> "id",
						
						'attr' =>  [ 'class'=>""],
									
						'filter_out'=>function($data_in){
											
											$data_out = array( 'id' => $data_in,
											'link_title'=>'View',
											'title'	=> 'View',
											 'is_fa'=>' fa fa-folder-o clr_red fa-lg',
											 'src'=>"?d=entity_child_of_child&menu_off=1&mode=simple&default_addon=$data_in",
											 'style'=>"border:none;width:100%;height:600px;");
											 return json_encode($data_out);
										 },
							
							'js_call'=>'d_series.set_nd'
                                                                        
			]);
		
		# end
		
		array_push($D_SERIES['data'],[	'th'	=> '',
								     
						'field'	=> 'id',
						
						'attr' =>  [ 'class'=>"brdr_right"],
						   
						'field'	=> 'id',
								
									
                                                'filter_out'=>function($data_in){
													$temp 		= explode(':',$data_in);
													
													$data_out 	= array( 'id' => $temp[0],
																 'link_title'=>'Add',
																'title'	=> 'Add',
																'is_fa'=>' fa fa-plus-square-o clr_red fa-lg',
																'src'=>"?f=entity_child_of_child&menu_off=1&mode=simple&default_addon=$temp[0]",
																 'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
												 },
                                                                        
                                                                'js_call'=>'d_series.set_nd'
					      
						]);
		
		# edit
		
		array_push($D_SERIES['data'],[
								'th'	=> 'Edit',
								     
								'field'	=> 'id',
								
								'td_attr' => ' width="15%" ',
									
                                                                	
                                                                'filter_out'=>function($data_in){
													$temp 		= explode(':',$data_in);
													
													$data_out 	= array( 'id' => $temp[0],
																 'link_title'=>'Edit',
																'title'	=> 'Edit',
																 'src'=>"?f=entity_child&key=$temp[0]&menu_off=1&mode=simple",
																 'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
												 },
                                                                        
                                                                'js_call'=>'d_series.set_nd'
					      
						]);
		
		
	}
	
	
    
?>