<?PHP
			
    
	$LAYOUT	    	= 'layout_basic';
               
        $D_SERIES       =   array(
                                   'title'=>'Demo EAV',
                                    
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
							
							
													2=>array('th'=>'Book Name',
								
															'field' =>"get_exav_addon_varchar(id,'BKNA')",
								
															'td_attr' => ' class="label_father align_LM" width="10%"',
								
															'is_sort' => 1,	
								
															),
								
													3=>array('th'=>'Price',
								
															'field' =>"get_exav_addon_decimal(id,'BKPR')",
								
															'td_attr' => ' class="label_father align_LM" width="10%"',
								
															'is_sort' => 1,	
								
															),
							
                                        ),
				    
					
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
				    
									'key_filter'	=> "AND entity_code = 'BK'",
				    
									# Communication
                                
                                    'prime_index'   => 2,
									
									//'show_query'=>1,
				    
									'custom_filter' => array(  	),
                                
				
				#check_field
				
                                        'action'        => array('is_action' => 0, 'is_edit' => 1, 'is_view' => 0),
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button'    => array( 'is_add' =>1,'page_link'=>'fx=demo__eav', 'b_name' => 'Add' ),
								
					'del_permission'=> array('able_del'=>1,'user_flage'=>0), 
								
					'date_filter'   => array( 'is_date_filter' =>1,'date_field' =>  'timestamp_punch'),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
			
				
				'show_query'=>0,
				
				'search_filter_off'	=>1,
                            
		);
    		    
?>