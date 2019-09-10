<?PHP

               
        $D_SERIES       =   array(
                                   'title'=>'',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx'	=> 1,
                                    
                                    #table data
                                    
                                    'data'=> array(
					                
							1=>array('th'=>'Entity',
									 
								'field'=>'(SELECT sn FROM entity WHERE entity.code=entity_code)',
		 
								#'field' => '',
                                                                   
								'td_attr' => ' class="label_father align_LM" width="15%"',
								
								'is_sort' => 1,
									 
								),
					
                                                       
													
                                                        2=>array('th'=>'Token',
									 
								'field'=>'token',
								
								'is_sort' => 1,
								
								'td_attr' => ' class="label_father align_LM" width="10%"',
									 
								),
							
							3=>array('th'=>'Short Name',
								 
								'field'=>'sn',
								     															
								'is_sort' => 1,
								
								'td_attr' => ' width="20%" ',
                                                                            
								), 
						
							 
							4=>array('th'=>'Long Name',
									 
								'field'=>'ln',
								
								'is_sort' => 1,
									 
								'td_attr' => ' class="label_child align_LM" width="25%"',
									 
								),
							
							5=>array('th'=>'DNA',
									 
								'field'=>'(SELECT sn FROM entity_attribute WHERE code=dna_code)',
								
								'is_sort' => 1,
									 
								'td_attr' => ' class="label_father" width="15%"',
									 
								),
							
							6=>array('th'=>'Line order',
								 
								'field'=>'line_order',
								     															
								'is_sort'      => 1,
									
								'td_attr' => ' width="5%" ',
							                                                                     
								),
							
							8=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="10%"',
								
								'js_call'=> 'show_user_info',
								
								'is_sort' => 'timestamp_punch'
									 
								),
								
                                                    ),
				    
                                    
                                       'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY id ASC ' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 3,
				    
				    'search'=> 	array(
							  
							
							array(  'data'  =>array('table_name' 	=> 'entity_child_base',
										'field_id'	=> 'token',
										'field_name' 	=> 'token',
										'filter'	=> "AND dna_code IN ('EBUC','EBMS','EBAX')"
										
									 ),
							      
								'title' 		=> 'Token',										
								'search_key' 		=> 'token',													       
								'is_search_by_text' 	=> 1, //( For Text search case)	      
							),
							
								
						),
				    
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Entity:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn'," ORDER BY sn ASC"),
									  
										'html'=>'  title="Select Client"   data-width="160px"  ',
									   
										'cus_default_label'=>'Show All',
									  
										'filter_by'  => "entity_code"  // main table value
									),
									
									
									array(  'field_name' => 'DNA:',
									      
										'field_id' => 'cf2', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity_attribute','code,sn',"WHERE entity_code='EB' AND code IN ('EBUC','EBMS','EBAX') ORDER BY sn ASC"),
									  
										'html'=>'  title="Select Client"   data-width="160px"  ',
									   
										'cus_default_label'=>'Show All',
									  
										'filter_by'  => "dna_code"  // main table value
									),
							),
				
                                
                                    # File Include
                                
                                  //'js'            => array('is_top'=>0, 'top_js' => 'js/d_series/entity_child_base'),
                                    
				'key_filter'	=> " AND dna_code IN ('EBUC','EBMS','EBAX') ",
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child_base', 'b_name' => 'Add Child Base' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA',
				
				'show_query'	=> 0
                            
                            );
	
	if(@$_GET['default_addon']){
		
		$default_addon = @$_GET['default_addon'];
        	$D_SERIES['key_filter'] ="AND  entity_code=(SELECT code FROM entity WHERE id = $default_addon)";
		unset($D_SERIES['data'][1]);
		unset($D_SERIES['export_csv']);
		$D_SERIES['action']['is_edit']=1;
		$D_SERIES['action']['action_menu_off']=@$_GET['menu_off'];
		$D_SERIES['action']['action_default_addon']=@$_GET['default_addon'];
		$D_SERIES['add_button']['is_add']=0;
		$D_SERIES['del_permission']['able_del']=1;
		$D_SERIES['summary_data'] = [];
		
		$LAYOUT	    = 'layout_full';
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['search_filter_off']	=1;
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['hide_pager'] = 1;
		$D_SERIES['show_all_rows']=1;
		$D_SERIES['filter_off'] = 1;
	}
	
    
?>