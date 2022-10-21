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
							
							
							2=>array('th'=>'Text ',
								
								'field' =>"get_exav_addon_varchar(entity_child.id,'DETX')",
								
								'td_attr' => ' class="label_father align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
							
							3=>array('th'=>'Textarea ',
								
								'field' =>"get_exav_addon_text(entity_child.id,'DETA')",
							
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        4=>array('th'=>'Date ',
								
								'field' =>"get_exav_addon_date(entity_child.id,'DEDT')",
							
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        5=>array('th'=>'Decimal ',
								
								'field' =>"get_exav_addon_decimal_2(entity_child.id,'DEDC')",
								
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
							
                                                        6=>array('th'=>'Autocomplete ',
								
								'field' =>"get_exav_addon_text(entity_child.id,'DETA')",
							
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        
                                                        7=>array('th'=>'Left right ',
								
								'field' =>"get_exav_addon_text(entity_child.id,'DELR')",
							
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,	
								
								),
                                                        
                                                        
                                                        8=>array('th'=>'Option multiple ',
								
								'field' =>"get_exav_addon_text(entity_child.id,'DEOM')",
							
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
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
				    
				    'key_filter'	=> "AND entity_code = 'DE'",
				    
				    # Communication
                                
                                    'prime_index'   => 2,
				    
				    'custom_filter' => array(  	),
                                
				
				#check_field
				
                                        'action'        => array('is_action' => 0, 'is_edit' => 1, 'is_view' => 0),
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button'    => array( 'is_add' =>1,'page_link'=>'fx=demo__eav', 'b_name' => 'Add' ),
								
					'del_permission'=> array('able_del'=>1,'user_flage'=>0), 
								
					'date_filter'   => array( 'is_date_filter' =>1,'date_field' =>  'timestamp_punch'),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'REVI',
				
				'show_query'=>0,
				
				'search_filter_off'	=>1,
                            
                            );
							
			 print_r($G->get_key_value(['id'=>'id',
										'tex'=>"get_exav_addon_varchar(entity_child.id,'DETX')",
										'ta'=>"get_exav_addon_text(entity_child.id,'DETA')",
										],        
					"entity_child",
					" AND id=5859")
				); 
    		    
		
			
?>