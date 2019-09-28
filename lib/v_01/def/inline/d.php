<?PHP
        $LAYOUT	   	= 	'layout_basic';
               
        $D_SERIES       =  	array(
                                
					'title'=>'',
					 
					# query display depend on the user
					
					'is_user_base_query'=>0,
					
					#table data
					
					'data'	=> array(
							 
							1=>array(
								 
								'th'		=> 'Label',
									 
								'field'		=> 'ln as v1',                                                                   
									 
								'td_attr' 	=> 'class="label_father align_LM" width="30%" '
							),							        
							2=>array(
								 
								'th'		=> 'Detail',
									 
								'field'		=> 'concat_ws(",",id,sn,ln,detail) as v2',                                                                   
									 
								'td_attr' 	=> ' class="label_father align_LM" width="30%" ',
									
								'js_call'	=> 'd_series.set_inline_update'										 
							),							    
						),				    
					 
					#Sort Info
                                      
                                       'sort_field' =>array(),
                                        
                                       'action' => array('is_action'=>0, 'is_edit' =>0, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY id ASC ' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                 
                                    #create search field
									
                                        'search_text' => array(
								
																						
								1=>array('get_search_text'  => get_search_array('entity_child','id as ST1,sn as ST2','Title',1,0,' WHERE entity_code="MQ" ')),
								
								//2=>array('get_search_text'  => get_search_array('entity','id as ST1,code as ST2','Code',2,1)), 
								
                                                              ),
						
				
				#Search filter 
				
				'search_field' => 'sn',
				
				'search_id' 	=> array('id'),
				
				'is_narrow_down'=>1,
				
				'custom_filter' => array(),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' 	=> array( 'is_add' =>0,'page_link'=>'?f=plug_land_no', 'b_name' => 'Add Master Pannel' ),
								
					'del_permission' => array('able_del'=>0,'user_flage'=>1), 
								
					'date_filter'  	=> array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
						
				'show_query'   => 0
                            
                            );
    
?>