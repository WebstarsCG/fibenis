<?PHP
		
	$default_addon = @$_GET['default_addon'];
	    
	$PARAM         = @$_GET;
    
	$PARAM['code'] = ((@$PARAM['code'])?@$PARAM['code']:'CX');
	
        $LAYOUT	    	= 'layout_basic';
               
        $D_SERIES       =   array(
                                   'title'=>'Contact Details',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx' => 1,
				    
                                    #table data
                                    
                                    'data'=> array(
					                
							1=>array('th'=>'Name ',
								
                                                                'field' => "get_eav_addon_varchar(id,'CXFN')",
								  
								'td_attr' => ' class="clr_pri b align_LM no_wrap" width="20%"',
								
								'is_sort' => 1,
								
								),
					
							
							2=>array('th'=>'Address 1 ',
								
								'field' => "(get_eav_addon_varchar(id,'CXRA'))",
							          
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,
								
								),
							
							3=>array('th'=>'Address 2 ',
								
								'field' => "(get_eav_addon_varchar(id,'CXRB'))",
							                                                            
								'td_attr' => ' class="align_LM" width="20%"',
								
								'is_sort' => 0,
								
								),
							
							4=>array('th'=>'Phone',
								
								'field' => "(get_eav_addon_varchar(id,'CXLD'))",
							                                                            
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,
								
								),
							
							5=>array('th'=>'Mobile',
								
								'field' => "(get_eav_addon_varchar(id,'CXMB'))",
							                                                            
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,
								
								),
							
							6=>array('th'=>'Email',
								
								'field' => "(get_eav_addon_varchar(id,'CXEM'))",
							                                                            
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,
								
								),
							
							
							7=>array('th'=>'Map',
								
								'field' => "(get_eav_addon_varchar(id,'CXGM'))",
							                                                            
								'td_attr' => ' class="align_LM" width="10%"',
								
								'is_sort' => 0,
								
								'filter_out'=>function($data_in){
								
											return ($data_in)?'<a href="'.$data_in.'" target="_blank" >View</a>':'NA';	
									
										}
								
								),
							
							
							
							8=>array('th'	=> 'Edit',
								     
								'field'	=> "concat(id,':',entity_code)",
								
								'td_attr' => ' width="15%" ',
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
													$data_out = array( 'id' => $temp[0],
												        'link_title'=>'Edit',
													'title' => 'Edit',
												         'src'=>"?f=opeav__contact_one_page&menu_off=1&mode=simple&key=$temp[0]&code=$temp[1]",
													 'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
												 },
                                                                        
                                                                'js_call'=>'d_series.set_nd'
                                                                        
								),
								
                                                    ),
				    
					
                                        
                                       'action' => array('is_action'=>0, 'is_edit' =>0, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY id ASC ' ,
				       
				       
				    #Filter Info
				    
					'custom_filter' => array(  			     						   
							      
									
									
								),   
				       		
                                
				
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
				    
				    'key_filter'     =>	 " AND  get_ec_parent_id_eav(id)=$default_addon  AND entity_code='$PARAM[code]'",
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
					'is_narrow_down' => 1,
						
					'filter_off'    => 1,
								   
				 #Search_info
				 
				 'search'=> 	array(),
	      
				#check_field
								
										
							
				'add_button' => array( 'is_add' =>0,'page_link'=>'f=contact_eav', 'b_name' => 'Add Contact' ),
							
				'del_permission' => array('able_del'=>1,'user_flage'=>1), 
							
				'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
			
				'show_query'=>0,
                            
                            );
	if(@$_GET['default_addon']){
	
		
		$LAYOUT = 'layout_full';
		unset($D_SERIES['summary_data']);
   
	}
?>