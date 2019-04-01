<?PHP
			
    
	$LAYOUT	    	= 'layout_basic';
               
        $D_SERIES       =   array(
                                   'title'=>'Demo Flat',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx' => 1,
				    
                                    #table data
                                    
                                    'data'=> array( 
						        1=>array('th'=>'ID ',
								
								'field' =>"id",
								
								'td_attr' => ' class="label_father align_LM" width="5%"',
								
								'is_sort' => 0,	
								
								),
							
							
							2=>array('th'=>'Text ',
								
								'field' =>"text_flat",
								
								'td_attr' => ' class="label_father align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
							
							3=>array('th'=>'Textarea ',
								
								'field' =>"text_area",
								
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        4=>array('th'=>'Date ',
								
								'field' =>"date_flat",
								
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        5=>array('th'=>'Decimal ',
								
								'field' =>"decimal_flat",
								
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        6=>array('th'=>'Autocomplete ',
								
								'field' =>"(SELECT sn FROM entity WHERE id = autocomplete)",
								
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        
                                                        7=>array('th'=>'Left right ',
								
								'field' =>"left_right",
								
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        
                                                        8=>array('th'=>'Option multiple ',
								
								'field' =>"option_multiple",
								
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        
                                                        9=>array('th'=>'Updated On',
								
								'field' =>"date_format(timestamp_punch,'%d-%b-%Y %H:%I') ",
								
								'td_attr' => ' class="no_wrap clr_gray_a align_LM txt_size_11" width="10%"',
								
								'is_sort' => 1,
								
								),
							
					
                                        ),
				    
					
                                    #Table Info
                                    
                                    'table_name' =>'demo',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
				    
				    # Communication
                                
                                    'prime_index'   => 2,
				    
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Status:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('demo','text_flat,text_flat'," ORDER by text_flat ASC"),
							    
										'html'=>'  title="Select Type"   data-width="100px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "text_flat" // main table value
									)
									
								),
                                
				
				#check_field
				
                                        'action'        => array('is_action' => 0, 'is_edit' => 1, 'is_view' => 0),
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button'    => array( 'is_add' =>1,'page_link'=>'fx=demo__flat', 'b_name' => 'Add' ),
								
					'del_permission'=> array('able_del'=>1,'user_flage'=>0), 
								
					'date_filter'   => array( 'is_date_filter' =>1,'date_field' =>  'timestamp_punch'),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'REVI',
				
				'show_query'=>0,
				
				'search_filter_off'	=>1,
                            
                            );
    		    
?>