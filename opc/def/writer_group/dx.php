<?PHP
		
	$D_SERIES       =   array(
                                   'title'=>'Writer Group',
                                    
                                    'gx'	=> 1,
				    
	                            'data'=> array(
                                                       1=>array('th'=>'Writer Group	 Name',
								 
								'field'=>"get_exav_addon_varchar(id,'WGGN')",
								
								//'field'=>"id",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'70%',
									   'class'=> ' txt_size_13'
									   ],
                                                                            
								),
							
								
							
							4=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="10%"',
								
								'js_call'=> 'show_user_info_2l',
									 
								),
							
							  5=>array('th'	=> 'Action',
								     
								  'field'	=> 'id',
								  
								 'td_attr' => 'width="7%" class="align_CM"',
									
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
																'link_title'=>'Edit',
																'is_fa'=>' fa fa-edit clr_dark_blue fa-lg txt_size_16',
																'fa_title'=>' Edit',
																'title'=>'Edit',
																
																'src'=>"?fx=writer_group&menu_off=1&key=$data_in",
																'style'=>"border:none;width:100%;height:600px;"
															);
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							 
							),
				    
				    
				    
				  
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>0, 'is_view' =>0 ),
                                       
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
				
				'key_filter' => "AND entity_code='WG'",
			    
                                'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'fx=writer_group', 'b_name' => 'Add' ),
								
					'del_permission' => array(),
					
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA',
				
				'show_query' => 0,
                            
                            );
	
	if(@$_GET['default_addon']){
		
		//$default_addon = @$_GET['default_addon'];
        	//$D_SERIES['key_filter'] ="AND  entity_code=(SELECT code FROM entity WHERE id = $default_addon)";
		//unset($D_SERIES['data'][1]);
		unset($D_SERIES['export_csv']);
		//$D_SERIES['action']['is_edit']=0;
		$D_SERIES['add_button']['is_add']=0;
		$D_SERIES['del_permission']['able_del']=1;
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