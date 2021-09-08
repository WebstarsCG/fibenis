<?PHP

         $LAYOUT	    = 'layout_basic';	
    
         
         $D_SERIES  	     =   array(
                                   'title'=>'Sys Log',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'User ',
								
								'field' =>"get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE id = sys_log.user_id),'COFN')",
								    
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                            
                                                            2=>array('th'=>'IP Address',
                                                                     'th_attr'=>'  width="10%"',
                                                                     'field'=>'sys_access_ip ',
								    
                                                                    'html' => 'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								    'font'=>  'class="sort"',
																
								    'span'=>'<span id="sort_icon_2" name="sort_icon_2"></span>',
								    
								    'td_attr' => ' class="txt_size_11 clr_gray_9"'
								    
								    
								    ),
							    
							   /*  3=>array('th'=>'System Name',
                                                                     'th_attr'=>'  width="35%"',
                                                                     'field'=>'sys_access_name as v3',
								    
                                                                    'html' => 'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								    'font'=>  'class="sort"',
																
								    'span'=>'<span id="sort_icon_2" name="sort_icon_2"></span>'),*/
							     
							    4=>array('th'=>'Page Name',
                                                                     'th_attr'=>'  width="20%"',
                                                                     'field'=>"get_ecb_parent_child_name_from_hash(page_code,'->')",
								    
                                                                    'is_sort'=>1,
								    
								    'td_attr' => ' class="txt_size_11 clr_dark_blue"'
								    ),
							    
							    
							 
							    
							    
							       7=>array('th'=>'Action Type',
                                                                     'th_attr'=>'  width="10%"',
                                                                     'field'=>'action_type',
								    
                                                                    'is_sort'=>1,
								    
								    
								    ),
							    
							       
							    6=>array(
								     'th'=>'Action',
                                                                     
								     'th_attr'=>'  width="25%"',
                                                                     
								     'field'=>"action ",
								     
								     'td_attr'=>' class="txt_size_11 clr_gray_6" '
								     ),
							    
							           
							    8=>array(
								     'th'=>'Access Key',
                                                                     
								     'th_attr'=>'  width="15%"',
                                                                     
								     'field'=>"access_key ",
								     
								     'td_attr'=>' class="txt_size_11 clr_gray_6" '
								     ),
							       5=>array('th'=>'Accessed On',
                                                                     'th_attr'=>'  width="10%"',
                                                                     'field'=>" date_format(timestamp_punch,'%d-%b-%Y %T')  ",
								    
                                                                  
							             'is_sort'=>'timestamp_punch',
								    
								    'td_attr' => ' class="clr_dark_blue no_wrap"'
								    ),
							    
							    
							    
						),
				    #Sort Info
                                      
                                    
                                       'action' => array('is_action'=>0, 'is_edit' => 0, 'is_view' =>0),
                                       
                                       'order_by'   =>'ORDER BY id ASC',
				       
				                                           
                                    #Table Info
                                    
                                    'table_name' =>'sys_log',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                    //'js'            => 'm_code',
                                    
                                    'search_text' => array(
								
								#1=>array('get_search_text'  => get_search_array('user_role','id as ST1,sn as ST2','User Role',1,0,'')),
                                                                
                                                              ),
						
				
				#Search filter 
				
				'search_field' => 'sn',
				
				'search_id' 	=> array('id'),
				
				 'custom_filter' => array( 			     						   
													
									
										array(  'field_name' 		=> 'User',
												  
												'field_id' 			=> 'cf1', 
												
												'filter_type' 		=> 'option_list', 
															
												'option_value'		=> $G->option_builder('user_info','id,get_user_internal_name(id)'," "),
											
										
												'html' => ' class="w_100"',
											
												'cus_default_label'	=> 'Show All',
										
												'filter_by'  		=> 'sys_log.user_id' 
											),
										
										array(  'field_name' 		=> 'Action type',
												  
												'field_id' 			=> 'cf2', 
												
												'filter_type' 		=> 'option_list', 
												'option_value'		=> $G->option_builder('entity_child_base','token,sn',
																		"WHERE entity_code='LX'
																		order by sn ASC"),
											
										
												'html' => ' class="w_100"',
											
												'cus_default_label'	=> 'Show All',
										
												'filter_by'  		=> 'action_type' 
											),

							
							//    array(  'field_name' => ' Page:',
							//	    'field_id' => 'pg', 'filter_type' =>'option_list', 
							//					    
							//	    'option_value'=> $G->option_builder('page_info','code,sn '," ORDER BY sn ASC"),
							//    
							//	    //'default_option'=>$G->get_entity_value('MP','fy_id'),
							//	    
							//	    'input_html'=>' class="WI_200" ',
							//	    
							//	    'cus_default_label'=>'Show All',
							//    
							//	    'filter_by'  => 'page_code'
							//    ),
							),    
				
				#check_field
								
					'check_field'   =>  array('id' => @$_GET['id']),								
								
					'add_button' => array( 'is_add' =>0,'page_link'=>'f=user_role', 'b_name' => 'Add User Role' ),
								
					'del_permission' => array('able_del'=>0,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>1,'date_field' =>  'timestamp_punch'),	
								
				    #export data
			//	'export_csv'   => array('is_export_file' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
			'export_csv'   => array('is_active' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DSYL',
                                
                                
                                # look and feel
                                
                               // 'table_attr'=>' class="table table-striped table-hover" '
                                'table_attr'=>' class="basic" ',
				'show_query' => 0
                            
                            );