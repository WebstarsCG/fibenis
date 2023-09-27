<?PHP
	
        $D_SERIES       =   array(
                                   'title'=>'Entity Child',
                                    
                                    #query display depend on the user
                                    
                                    'gx'	=> 1,
				    
				    #table data
                                    
                                    'data'=> array(
					                
							1=>array('th'=>'Entity Name',
									 
								'field'=>'(SELECT sn FROM entity WHERE entity.code=entity_code)',
                                                                   
								'td_attr' => ' class="label_father align_LM" width="25%"',
								
								'is_sort' =>1
									 
								),
					
							2=>array('th'=>'Code',
								 
								'field'=>"get_eav_addon_varchar(id,'ECCD')",
								
								'is_sort' => 1,	
								
								'td_attr' => ' width="20%" ',
                                                                            
								), 
					
                                                        3=>array('th'=>'Short Name',
								 
								'field'=>"get_eav_addon_varchar(id,'ECSN')",
								
								'is_sort' => 1,	
								
								'td_attr' => ' width="20%" ',
                                                                            
								),
							
							
//
							 4=>array('th'=>'Long Name',
									 
								'field'=>"concat(substring_index(get_eav_addon_varchar(id,'ECLN'),' ',5),'..')",
									 
								'td_attr' => ' class="label_child align_LM" width="35%"',
								
								'is_sort' => 0
									 
								),
							 
							 5=>array('th'=>'Detail',
									 
								'field'=>"concat(substring_index(get_eav_addon_text(id,'ECDT'),' ',15),'..')",
									 
								'td_attr' => 'width="20%"',
								
								'is_sort' => 0,
									 
								),
							 
							
							 6=>array('th'=>'Image',
									 
								'field'=>"get_eav_addon_varchar(id,'ECIA')",
									 
								'td_attr' => ' class="label_child align_LM" width="35%"',
								
								'filter_out'   =>	function($data_out){
									
                                                                        $temp = explode(',',$data_out);
                                                                        
									return '<img class="w_25" src="'. $temp[0].'">';
									
									},
									 
								),
							 
							 7=>array('th'=>'Image A',
									 
								'field'=>"get_eav_addon_varchar(id,'ECIB')",
									 
								'td_attr' => 'width="20%"',
								
								'filter_out'   =>	function($data_out){
									
                                                                        $temp = explode(',',$data_out);
                                                                        
									return '<img class="w_25" src="'. $temp[0].'">';
									
									},
									 
								),
							 
							 
							  8=>array('th'=>'Line Order',
									 
								'field'=>'line_order',
									 
								'td_attr' => 'width="20%"',
								
								'attr'    => ['class'=>'align_CM','width'=>'15%'],
								
								'is_sort' => 1
									 
								),
							 
							 
							 9=>array(	'th'=>'Edit',
									 
									'field'=>"concat(id,':',(SELECT id as parent_id FROM entity_child  as ec WHERE ec.id=get_ec_parent_id_eav(entity_child.id)))",
										 
									'td_attr' => 'width="5%"',
									
									'attr'    => ['class'=>'align_CM'],
									
									'filter_out'=>function($data_in){
														global $PAGE_NAME;
														
														list($id,$parent_id)    = explode(':',$data_in);
														
														$data_out = array('id'        => $id,
																  'link_title'=> 'Edit',
																  'is_fa'      => 'fa-edit',
																  'title'     => 'Status View',
																  'src'	      => "?f=$PAGE_NAME&menu_off=1&mode=simple&key=$id&default_addon=$parent_id",
																  'style'     => "border:none;width:100%;height:600px;"
														);
														
														 return json_encode($data_out);
													},
									
									'js_call'=>'d_series.set_nd'
								
								),
							 
							  
							),
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
				    'order_by'   =>'ORDER BY id ASC ' ,
				    
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Entity:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn'," ORDER BY sn ASC"),
							    
										'html'=>'  title="Select Client"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "entity_code"  // main table value
									),
							),
				    
				    #Search
				
				//'search'=> 	array(
				//			  
				//			array(  'data'  =>array('table_name' 	=> 'entity_child',
				//						'field_id'	=> 'sn',
				//						'field_name' 	=> 'sn',
				//						 
				//					 ),
				//			      
				//				'title' 		=> 'Name',										
				//				'search_key' 		=> 'sn',													       
				//				'is_search_by_text' 	=> 1, //( For Text search case)	      
				//			),
				//				
				//		),
				
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 3,
				    
				    'is_narrow_down' => 1,
                                
                                    # File Include
                                
                                  'js'            => array('is_top'=>1, 'top_js' => 'js/d_series/entity_child'),
         			
				'key_filter'	=>'',
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Child' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA'
                            
                            );
	
	
	if(@$_GET['default_addon']){

		$D_SERIES['hide_show_all']     = 1;
		$D_SERIES['search_filter_off'] = 1;
		$D_SERIES['filter_off']        = 1;
		
		unset($D_SERIES['export_csv']);
		
		$D_SERIES['add_button']['is_add'] = 0;		
		$D_SERIES['action']['is_edit']    = 0;
		
		$D_SERIES['del_permission']['able_del']=0;
	}
    
?>