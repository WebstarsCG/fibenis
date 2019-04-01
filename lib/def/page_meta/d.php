<?PHP
        $LAYOUT	   	= 	'layout_basic';
               
        $D_SERIES       =  	array(
                                
					'title'=>'',
					 
					# query display depend on the user
					
					'is_user_base_query'=>0,
					
					'gx'=>1,
					
					#table data
					
					'data'	=> array(
							 
							1=>array(
								 
								'th'		=> 'Label',
									 
								'field'		=> 'ln',                                                                   
									 
								'td_attr' 	=> 'class="label_father align_LM" width="15%" '
							),
							
							2=>array(
								 
								'th'		=> 'Page Title',
									 
								'field'		=> "concat(id,'[C]',get_eav_addon_varchar(id,'PGPT'))",                                                                   
									 
								'td_attr' 	=> ' class=" align_LM" width="30%" ',
								
								'filter_out'	=> function($data_in){
										
											$temp     = explode('[C]',$data_in);									
											$data_out = array(
													  'data'=>array('id'   => $temp[0],															
															'key'  => md5($temp[0]),															
															'label'=> 'Keyword',
															'info' => htmlentities($temp[1]),
															'ea_code'=> 'PGPT',
															'type' => 'textarea',
															'series'=>'a',
															'action'=>'entity_child',
															'token' =>'ECAV'
															)
													);
											
											return json_encode($data_out);
										},
										
								'js_call'	=> 'd_series.set_inline_update'
							),	
							
							3=>array(
								 
								'th'		=> 'Page Description',
									 
								'field'		=> "concat(id,'[C]',get_eav_addon_varchar(id,'PGPD'))",                                                                   
									 
								'td_attr' 	=> ' class=" align_LM" width="30%" ',
								
								'filter_out'	=> function($data_in){
										
											$temp     = explode('[C]',$data_in);									
											$data_out = array(
													  'data'=>array('id'   => $temp[0],															
															'key'  => md5($temp[0].'PGDP'),															
															'label'=> 'Keyword',
															'info' => htmlentities($temp[1]),
															'ea_code'=> 'PGPD',
															'type' => 'textarea',
															'series'=>'a',
															'action'=>'entity_child',
															'token' =>'ECAV'
															)
													);
											
											return json_encode($data_out);
										},
										
								'js_call'	=> 'd_series.set_inline_update'
							),
							
							4=>array(
								 
								'th'		=> 'Keywords',
									 
								'field'		=> "concat(id,'[C]',get_eav_addon_varchar(id,'PGKW'))",                                                                   
									 
								'td_attr' 	=> ' class=" align_LM" width="30%" ',
								
								'filter_out'	=> function($data_in){
										
											$temp     = explode('[C]',$data_in);									
											$data_out = array(
													  'data'=>array('id'   => $temp[0],															
															'key'  => md5($temp[0].'PGKW'),															
															'label'=> 'Keyword',
															'info' => htmlentities($temp[1]),
															'ea_code'=> 'PGKW',
															'type' => 'textarea',
															'series'=>'a',
															'action'=>'entity_child',
															'token' =>'ECAV'
															)
													);
											
											return json_encode($data_out);
										},
										
								'js_call'	=> 'd_series.set_inline_update'
							),
							//
							//4=>array(
							//	 
							//	'th'		=> 'Keyword',
							//		 
							//	'field'		=> "get_eav_addon_varchar(id,'PGKW')",                                                                   
							//		 
							//	'td_attr' 	=> ' class=" align_LM" width="25%" ',
							//		
							//	//'js_call'	=> 'd_series.set_inline_update'										 
							//),
						),				    
					 
					#Sort Info
                                      
                                       'sort_field' =>array(),
                                        
                                       'action' => array('is_action'=>0, 'is_edit' =>0, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY id ASC ' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=> ' AND entity_code="PG" ', 
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                 
                                    #create search field
									
                                        				
                                        'search_text' => array(
								
																						
								1=>array('get_search_text'  => get_search_array('entity_child','id as ST1,ln as ST2','Title',1,0," WHERE entity_code='PG'")),
								
								
                                                              ),
						
				
				#Search filter 
				
				'search_field' => 'sn',
				
				'search_id' 	=> array('id'),
				
				'is_narrow_down'=>1,
				
				
								
				'custom_filter' => array(
								   array(  'field_name' => 'Parent.:', 'field_id' => 'cf_i', 'filter_type' =>'option_list', 
									
								    'option_value'=> $G->option_builder('entity_child','id,IFNULL(concat((SELECT sn FROM entity_child as ec WHERE ec.id=entity_child.parent_id),\' -> \',sn),sn ) as sn'," WHERE entity_code='PG' AND is_active=1 ORDER BY sn,line_order ASC"),							   
								    
								    'input_html'=>' class="WI_200" ',
								    
								    'cus_default_label'=>'Show All',
							    
								    'filter_by'  => 'parent_id'
							    ),
							 
							 ),
				
				#check_field
								
					'check_field'   =>  array(),								
								
					'add_button' 	=> array( 'is_add' =>0,'page_link'=>'?f=plug_land_no', 'b_name' => 'Add Master Pannel' ),
								
					'del_permission' => array('able_del'=>0,'user_flage'=>1), 
								
					'date_filter'  	=> array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				
				
				'show_query'   => 0,
				
				'page_code'    => ''
                            
                            );
    
?>