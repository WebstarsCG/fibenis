<?PHP
	       
        $D_SERIES       =   array(
                                   'title'=>'Entity Attribute',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx'	=> 1,
				    
                                    #table data
                                    
                                    'data'=> array(
                                                        1=>array('th'=>'Entity',
								 
								'field'=>'entity_code',
									
								'td_attr' => ' width="2%" ',
								
								'is_sort' => 1,
								
								 
                                                                            
								),
							
							
							 5=>array('th'=>'Entity Name',
								 
								'field'=>'(SELECT sn FROM entity WHERE code=entity_code)',
									
								'td_attr' => ' width="15%" ',
								
								'attr'    =>['class'=>'label_grand_child'],  
                                                                            
								), 
													
                                                        2=>array('th'=>'Attribute Code',
									 
								'field'=>'code',
                                                                   
								'is_sort'   =>1,
								
								'td_attr' => ' class="label_father b txt_size_14 align_LM" width="10%"',
								
									 
								),
								
							3=>array('th'	=> 'Name',
									      
								'field'	=> 'sn',
									
								'is_sort' => 1,
								
								'td_attr' => ' class="align_LM" width="25%" '
									      
								),
							
							4=>array('th'	=> 'Long Name',
									      
								'field'	=> 'ln',
									
								'is_sort' => 1,
								
								'td_attr' => ' class="label_grand_child align_LM" width="15%" ',
									      
								),
							
							6=>array('th'	=> 'Order',
									      
								'field'	=> "concat(id,'[C]',line_order)",
									
								'is_sort' => 'line_order',
							
									      
								'td_attr' => ' class="align_RM" width="5%" ',
								
																'field'     => "concat(id,'[C]',line_order)",
								
                                                                'td_attr' =>  ' class="label_grand_father" ',
                                                                     
								'filter_out'	=> function($data_in){
									
										$temp     = explode('[C]',$data_in);
										
										$temp[1]  = str_replace("\t",'',$temp[1]);
										
										$data_out = array(
												  'data'=>array('id'   => $temp[0],															
														'key'  => md5($temp[0]),															
														'label'=> 'Update Entity Attribute Line Order',
														'info' => htmlentities($temp[1]),
														'type' => 'text',
														'series'=>'a',
														'action'=>'entity_attribute',
														'token' =>'LOU'
														)
												);
										
										return json_encode($data_out);
									},
									
								'js_call'	=> 'd_series.set_inline_update'
								
								
								
									      
								),
							
							15=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="25%"',
								
								'js_call'=> 'show_user_info',
									 
								),
                                                    ),
				    
                                       'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY id ASC' ,
				       
				       'key_filter'	=> '',
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_attribute',
                                    
                                    'key_id'    =>'id',
				    
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 3,
				    
				    'is_narrow_down' => 1,
				    
				    'summary_data'=>array(
								array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
								
						),
						
				    
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Entity:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn',"WHERE is_lib=1 ORDER BY sn ASC"),
							    
										'html'=>'  title="Select Client"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "entity_code"  // main table value
									),
							),
				    
				    'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_attribute',
										'field_id'	=> 'sn',
										'field_name' 	=> 'sn',										
									     ),
												     
								'title' 		=> 'Name',										
								'search_key' 		=> 'sn',													       
								'is_search_by_text' 	=> 1,
							     ),
							
							//array(  'data'  =>array('table_name' 	=> 'entity_attribute',
							//			'field_id'	=> 'ln',
							//			'field_name' 	=> 'ln',										
							//		     ),
							//					     
							//	'title' 		=> 'Long Name',										
							//	'search_key' 		=> 'ln',													       
							//	'is_search_by_text' 	=> 1,
							//     ),	
							
						       ),
				
                                
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_attribute', 'b_name' => 'Add Attribute' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				#export data
				
				'export_csv'   => array('is_active' => 1),								
				
				'show_query'	=> 0,
                            
                            );
	
	if(@$_GET['default_addon']){
		
		$default_addon = @$_GET['default_addon'];
        	$D_SERIES['key_filter'].="AND  entity_code=(SELECT code FROM entity WHERE id = $default_addon)";
		unset($D_SERIES['data'][1]);
		unset($D_SERIES['data'][5]);
		unset($D_SERIES['export_csv']);
		$D_SERIES['action']['is_edit']=0;
		$D_SERIES['add_button']['is_add']=0;
		//$D_SERIES['del_permission']['able_del']=0;
		$LAYOUT	    = 'layout_full';
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['search_filter_off']	=1;
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['hide_pager'] = 1;
		$D_SERIES['show_all_rows']=1;
		$D_SERIES['filter_off'] = 1;
	
	}else{
		
		unset($D_SERIES['data'][4]);	
	}
    
?>