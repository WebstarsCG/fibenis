<?PHP
            
	 
	       
         $D_SERIES       =   array(
                                   'title'=>'Status Map',
                                    
                                    #query display depend on the user
                                    
                                    //'is_user_base_query'=>0,
                                    
                                    #table data
                                    
                                    'data'=> array(
////                            
							 1=>array('th'=>'Entity',
								 
								'field'=>'(SELECT sn FROM entity WHERE code=entity_code) as v1',
									
								'td_attr' => ' width="12%" ',
							                                                                     
								), 
													
                                                        2=>array('th'=>'Start Code',
									 
								'field'=>'status_code_start as v2',
                                                                   
								'html'      =>  'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								'font'      =>  'class="sort"',
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => ' class="label_child align_LM" width="15%"',
									 
								),
								
							3=>array('th'=>'Start Status',
								 
								'field'=>'(select sn from entity_attribute where code = status_code_start) as v3',
                                                                   
								'html'      =>  'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								'font'      =>  'class="sort"',
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => ' class="label_child align_LM" width="15%"',
									 
								),	
								
							 4=>array('th'=>'End Code',
									 
								'field'=>'status_code_end as v4',
                                                                   
								'html'      =>  'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								'font'      =>  'class="sort"',
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => ' class="label_child align_LM" width="15%"',
									 
								),
								
							5=>array('th'=>'End Status',
								 
								'field'=>'(select sn from entity_attribute where code = status_code_end) as v5',
                                                                   
								'html'      =>  'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								'font'      =>  'class="sort"',
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => ' class="label_child align_LM" width="15%"',
									 
								),		
						
							6=>array('th'=> 'Line order',
								 
								'field'=>'(select line_order from entity_attribute where code = status_code_start) as v6',
                                                                   
								'html'      =>  'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								'font'      =>  'class="sort"',
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => ' class="label_child align_LM" width="15%"',
									      
								),
							
							
							
                                                    ),
				    
                                    
                                    #Sort Info
                                      
                                       'sort_field' =>array('status_code_start',
							    
							    //'sn',
							    
							    'status_code_start',
							    
							    //'ln',
							    
							    'line_order'
							    ),
                                        
                                       'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY entity_code ASC' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'status_map',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    //'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                    //'js'            => 'm_code',
                                    
                                    #create search field
									
                                        'search_text' => array(
							       
							       
							//       1=>array('get_search_text'  => get_search_array('entity_attribute',
							//							'entity_code as ST1,(SELECT sn FROM entity WHERE code=entity_code)as ST2',
							//							'Entity Code',1,1,'')),
								
								//2=>array('get_search_text'  => get_search_array('entity_attribute','id as ST1,sn as ST2','First Name',2,1,'',''))								
                                                        ),
						
				
				#Search filter 
				
				'search_field' => '',
				
				'search_id' 	=> array(),
				
				'search_filter_off'   => 1,
				
				'custom_filter' => array(	
								array(
								
									'field_name' => 'Entity',
								
									'field_id' => 'cf1', 
								
									'filter_type' =>'option_list', 
																
									'option_value'=> $G->option_builder('entity','code,sn','order by sn'),
											
									'cus_default_label' => 'Show All',
												
									'html' => ' class="w_150"',
											
									'filter_by'  => 'entity_code'
								
								),
								
								
								
				
				),
				
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=status_map', 'b_name' => 'Add Status Map' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DSTM'
                            
                            );
	
	
	# custon filter 1
	
	if(@$_GET['cf1']){
		
		
		
		
		array_push($D_SERIES['custom_filter'], array(
				
									'field_name' => 'Start Code',
				
									'field_id' => 'cf2', 
				
									'filter_type' =>'option_list', 
																
									'option_value'=> $G->option_builder('entity_attribute','code,sn'," WHERE entity_code='$_GET[cf1]' ORDER BY line_order"),
											
									'cus_default_label' => 'Show All',
												
									'html' => ' class="w_150"',
											
									'filter_by'  => 'status_code_start'
								
				));
	}
    
?>