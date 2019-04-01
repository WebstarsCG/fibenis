<?PHP
		
	$D_SERIES       =   array(
                                    'title'=>'PubSub Connection',
                                    
                                    'gx'	=> 1,
				    
	                            'data'=> array(
                                                      
						       5=>array('th'=>'Type',
							      
							     'field'=>"get_exav_addon_varchar(id,'PCCT')",
							     
							     //'field'=>"id",
							     
							     'is_sort' => 1,	
							     
							     'attr' => ['width'=>'6%',
									'class'=> 'txt_size_11 clr_gray_6'
									],
							     
							        'filter_out'=>function($data_in){
									
											$temp = [];
											$temp['PSCTONL']='<span class="clr_green">Online</span>';
											$temp['PSCTOFL']='<i></i><span>Offline</span>';	
											return $temp[$data_in];
										}
							     ),
						      
						      
						        1=>array('th'=>'PubSub Connection Name',
								 
								'field'=>"get_exav_addon_varchar(id,'PCCN')",
								
								//'field'=>"id",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'70%',
									   'class'=> ' label_grand_father txt_size_13'
									   ],
                                                                            
								),
							
							4=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="10%"',
								
								'js_call'=> 'show_user_info_2l',
									 
								),
						       
						       
							
							
								
							2=>array('th'	=> 'Writer Group', 'th_attr'=>' colspan=2 ',
								 
								 'field'	=> 'id',
								 
								 
								'attr' =>  [ 'class'=>"", 'width' => "6%"],
								
								  
								  	
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
													'link_title'=>'Add Child',
													'is_fa'=>' fa fa-plus-square-o clr_dark_blue fa-lg txt_size_18',
													'title'=>'Add Writer Group',
													'src'=>"?fx=writer_group&menu_off=1&mode=simple&default_addon=$data_in",
													'style'=>"border:none;width:100%;height:600px;"
												  );
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
								     
								
							
							3=>array('th'	=> '',
								 
								 'field'	=> "id",
								 
								 'attr' =>  [ 'class'=>"brdr_right align_CM"],
								
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
						
													$data_out = array('id'   => $temp[0],
												         
													 'link_title'=>'  '.$temp[1],
													 'is_fa'=>' fa-chevron-circle-right clr_dark_blue fa-lg ',
													 'is_fa_btn'=>' btn-default btn-sm ',
													 'title'=>'Child View',
												         'src'=>"?dx=writer_group&menu_off=1&mode=simple&default_addon=$temp[0]",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
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
				
				'key_filter' => "AND entity_code='PC'",
				
				'no_data_message'=> 'No data available',
			    
                                'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'fx=ps_connection&default_addon=PSCTONL', 'b_name' => 'Online Configuration' ),
								
					'del_permission' => array(),
					
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'    => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'     => 'DECA',
				
				'show_query'    => 0,
				
				'hide_show_all' =>1,
				 
				'hide_pager'    =>1,
				 
				'top_action'    => array(  	[	'style' => "icon add",
									'action'=> '?fx=ps_connection&default_addon=PSCTOFL', // js function name
									'label' => 'Offline Configuration',
								]
							)

                            
                            );
	
	
	$find_id = $rdsql->exec_query("SELECT count(id) FROM entity_child WHERE entity_code = 'PC'","Selection Fails");
		
	$value = $rdsql->data_fetch_row($find_id);
	    
	if($value[0]==0){
		
		$D_SERIES['action'] = array('is_action'=>0, 'is_edit' =>0, 'is_view' =>0 );
		
		$D_SERIES['del_permission'] = array('able_del'=>0,'user_flage'=>0);
		
		$D_SERIES['bulk_action'] = array(
			array('is_bulk_button' => 1, 'button_name' => 'Add Online Configuration', 'js_call'=>'' ,'input_html' => ''),
			array('is_bulk_button' => 1, 'button_name' => 'Add Offline Configuration', 'js_call'=>'' ,'input_html' => '')
		);	
	}
	
	
	
?>
<style type="text/css">
	
	.box_right a.icon{			
			
			color	   : #727272 !important;
			/*font-weight: bold !important;*/
			font-size  : 13px !important;
	}
	
</style>