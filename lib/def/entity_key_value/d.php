<?PHP

               
        $D_SERIES       =   array(
                                   'title'=>'Entity Key Value',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
				    'gx'	=> 1,
                                    #table data
                                    
                                    'data'=> array(
                                                        1=>array('th'=>'Entity Code',
								 
								'field'=>'(SELECT sn FROM entity WHERE code=entity_code)',
								     
								'is_sort' => 1,
								
								'th_attr'=>'width="15%"',
								
								'js_call'=>'label_grand_father'
								
                                                                            
								), 
													
                                                        2=>array('th'	=> 'Entity Key',
									      
								'field'	=> 'entity_key',
									
								'is_sort' => 1,
								
								'js_call'=>'label_father ',
									      
								'td_attr' => ' class="align_LM" width="15%" ',
								
								'th_attr'=>'width="20%"',
									      
								),
							
							4=>array('th'	=> 'Domain',
									      
								'field'	=> "(SELECT get_eav_addon_varchar(id,'ECSN') FROM entity_child WHERE entity_code='CH' AND md5(get_eav_addon_vc128uniq(id,'CHCD'))=domain_hash)",
									
								'is_sort' => 1,
								
								'js_call'=>'label_father ',
									      
								'td_attr' => ' class="align_LM" width="15%" ',
								
								'th_attr'=>'width="10%"',
									      
								),
							
							3=>array('th'	=> 'Entity Value',
									      
								'field'     => "concat_ws('F:I:B:E:N:I:S',substring_index(entity_value,' ',7),entity_value)",
								
                                                                'td_attr' =>  ' class="label_grand_father" ',
                                                                     
									'filter_out'=>function($data_in){
										
										$temp = explode('F:I:B:E:N:I:S',$data_in);
										
										return "<a class='tip clr_gray_5'>$temp[0]...</a><span class='tooltiptext'>$temp[0]</span>";
											
									}
									      
								),
							
							5=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="25%"',
								
								'js_call'=> 'show_user_info',
								
								'is_sort'=>'timestamp_punch'
									 
								),
							
							//4=>array('th'	=> 'User Name',
							//		      
							//	'field'	=> 'concat((SELECT user_name FROM user_info WHERE id=user_id),\'<font class="label_child">\',date_format(timestamp_punch,"%d-%b-%Y %T")) as v4',
							//		
							//	'html'      =>  'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',4);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_4\'));filter_data();"',
							//	  
							//	'font'      =>  'class="sort"',
							//									
							//	'span'      =>  '<span id="sort_icon_4" name="sort_icon_4"></span>',
							//		      
							//	'js_call' => 'label_father ',
							//		      
							//	'td_attr' => ' class="align_LM" width="20%" ',
							//	
							//	'th_attr'=>'width="13%"',
							//		      
							//	),
                                                    ),
				    
                                    
                                        
                                       'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY id ASC ' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_key_value',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 2,
				    
				    'key_filter'    =>"AND entity_code IN (SELECT code FROM entity WHERE is_lib=0)",
                                
                                    # File Include
                                
                                    'js'            => 'm_code',
				    
				    'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				    
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Entity:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn'," WHERE is_lib=0 ORDER BY sn ASC"),
							    
										'html'=>'  title="Select Client"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "entity_code"  // main table value
									),
									
									array(  'field_name' => 'Domain:',
									      
										'field_id' => 'cf2', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity_child',"md5(get_eav_addon_vc128uniq(id,'CHCD')),get_eav_addon_varchar(id,'ECSN')","  WHERE entity_code='CH' ORDER BY get_eav_addon_varchar(id,'ECSN') ASC"),
							    
										'html'=>'  title="Select Domain"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "domain_hash"  // main table value
									),
							),
                                    
				    'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_key_value',
										'field_id'	=> 'entity_key',
										'field_name' 	=> 'entity_key',										
									     ),
												     
								'title' 		=> 'Entity Key',										
								'search_key' 		=> 'entity_key',													       
								'is_search_by_text' 	=> 1,
							     ),
							
							array(  'data'  =>array('table_name' 	=> 'entity_key_value',
										'field_id'	=> 'entity_value',
										'field_name' 	=> 'entity_value',										
									     ),
												     
								'title' 		=> 'Entity Value',										
								'search_key' 		=> 'entity_value',													       
								'is_search_by_text' 	=> 1,
							     ),	
							
						       ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_key_value', 'b_name' => 'Add Values' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DEKV',
				
				'show_query'	=> 0,
                            
                            );

		if(@$_GET['default_addon']){

		$default_addon = @$_GET['default_addon'];
        	$D_SERIES['key_filter'] ="AND  entity_code=(SELECT code FROM entity WHERE id = $default_addon)";
		unset($D_SERIES['data'][1]);
		unset($D_SERIES['export_csv']);
		$D_SERIES['action']['is_edit']=0;
		$D_SERIES['add_button']['is_add']=0;
		$D_SERIES['del_permission']['able_del']=0;
		
		$D_SERIES['summary_data'] = [];
		
		$LAYOUT	    = 'layout_full';
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['search_filter_off']	=1;
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['hide_pager'] = 1;
		$D_SERIES['show_all_rows']=1;
		$D_SERIES['filter_off'] = 1;
	}

    
?>