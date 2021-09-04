<?PHP
			
	$D_SERIES       =   array(
                                   'title'=>'Status',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx' => 1,
				    
                                    
                                    #table data
                                    
                                    'data'=> array(
						   
							5=>array('th'=>'Type ',
								
								'field' =>"(SELECT sn FROM entity WHERE code = status_info.entity_code)",
								
								//'field' =>"status_code",
								
								'td_attr' => ' class="label_father align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
						    
						        1=>array('th'=>'Status ',
								
								'field' =>"(SELECT sn FROM entity_child_base WHERE token = status_info.status_code)",
								
								//'field' =>"status_code",
								
								'td_attr' => ' class="label_father align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
							
							2=>array('th'=>'Note ',
								
								//'field' =>"note",
								
								'field' => "concat(substring_index(note,' ',10),':',note)",
								    
								'td_attr' => ' class="label_father align_LM" width="20%"',
								
								'is_sort' => 0,
								
								'filter_out'=>function($data_in){
									
									$temp = explode(':',$data_in);
									
									return "<a class='tip clr_gray_5'>$temp[0]...</a><span class='tooltiptext'>$temp[1]</span>";
										
								}
								
								),
							
							3=>array('th'=>'User ',
								
								'field' =>"user_id",
								
								'field' =>"get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE id = status_info.user_id),'COFN')",
								    
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
							
							4=>array('th'=>'Date & Time ',
								
								'field'	=> "date_format(timestamp_punch,'%d-%b-%Y %T')",
                                                                
								'td_attr' => ' class="label_father align_LM" width="20%"',
								
								'is_sort' => 1,
								
								'filter_out' => function($data_in){
									
											return "<div class='block normal txt_case_uppercase txt_size_11 clr_gray_a'>$data_in</div>";;
											
								                }
								
								),
					
                                                    ),
				    
					
                                    #Table Info
                                    
                                    'table_name' =>'status_info',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
				    
				    # Communication
                                
                                    'prime_index'   => 1,
				    
				    'custom_filter' => array(  			     						   
							      
							      array(  'field_name'       => 'Type',
															       
									'field_id'         => 'cf1',   
																	 
									'filter_type'      => 'option_list', 
																			     
									'option_value'=> $G->option_builder('entity','code,sn',"WHERE code IN (SELECT entity_code FROM status_info GROUP BY entity_code) ORDER BY sn ASC"),
							    
									'html'             => 'data-width="80px"',
															     
									'cus_default_label'=>'Show All',
								
									'filter_by'        => 'entity_code'
								),
							      
							 ),
                                
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>0,'page_link'=>'', 'b_name' => '' ),
								
					'del_permission' => array('able_del'=>0,'user_flage'=>0), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'STATUS',
				
				'show_query'=>0,
				
				'search_filter_off' => 1
				
				
                            
                            );
	
	
	if(isset($_GET['default_addon'])){
	    
	    $default_addon = @$_GET['default_addon'];
	    
	    $LAYOUT = 'layout_full';
   
	    $temp = explode(':',$default_addon);
	    
	    $status_code = @$temp[1]; //ASBK
	    
	    $entity_child_id=$temp[0]; //17
	    
	    //$entity_code = substr($temp[0],0,2); //AS
	    
	    $D_SERIES['key_filter']   =	 " AND  child_comm_id='$entity_child_id'  ";
	    
	    $D_SERIES['hide_show_all'] = 1;
				
	    $D_SERIES['search_filter_off']	=1;
	    
	    $D_SERIES['hide_show_all'] = 1;
	    
	    $D_SERIES['hide_pager']=1;
	    
	    $D_SERIES['show_all_rows']=1;
	    
	    $D_SERIES['filter_off']=1;
	    
	    unset($D_SERIES['data'][5]);
                                
	}
?>