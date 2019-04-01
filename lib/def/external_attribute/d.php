<?PHP

    
            $D_SERIES       =   array(
                
                                   'title'=>'External Attribute',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Name', 'field'=>'sn',
                                                                    
								    'td_attr' =>  ' class="clr_gray_9" width="25%"',
                                                                    
                                                                    'is_sort'=>1,
								    
								    ),
                                                            
                                                            2=>array('th'=>'Token', 'field'=>'token',
                                                                    
								    'td_attr' =>  ' class="label_grand_father txt_size_14" width="7%" ',
                                                                    
                                                                    'is_sort'=>1,
								    
								    ),
                                                            3=>array('th'=>'Input Type', 'field'=>"(SELECT sn FROM entity_attribute WHERE code=(SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=entity_child_base.id AND ea_code='APIT'))",
                                                                    
								    'td_attr' =>  ' class="txt_size_12" width="15%"',
                                                                    
                                                                    'is_sort'=>1,
								    
								    ),
                                                          
//                                                            4=>array('th'=>'Unit', 'field'=>"(SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=entity_child_base.id AND ea_code='APUT')",
//                                                                    
//								    'td_attr' =>  ' class="txt_size_12" width="15%"',
//                                                                    
//                                                                    'is_sort'=>1,
//								    
//								    ),
							    
							    5=>array('th'=>'Line order', 'field'=>"line_order",
                                                                    
								    'td_attr' =>  ' class="txt_size_12" width="8%"',
                                                                    
                                                                    'is_sort'=>1,
								    
								    ),
							    
							    6=>array('th'=>'Status',
								       
							      'field'=>"CONCAT(id,'[C]',is_active)",
							      
							      'filter_out'=>function($data_in){
									      
										      $temp     = explode('[C]',$data_in);
										      
										      $flag     = [1,0];
										      
										      $data_out = array(
													'data'=>array('id'   => $temp[0],
														      'key'  => md5($temp[0]),
														      'label'=> 'Page',
														      'cv'   => $temp[1],
														      'fv'   => $flag[$temp[1]],
														      'action'=>'entity_child_base',
														      'series'=>'a',
														      'token' =>'ECBAI'
														      )
												      );
										      
										      return json_encode($data_out);
									      },
								 
								       
							      'td_attr' => ' class="label_child align_LM  txt_case_upper b" style="padding-right:10px;" width="3%"',
							      
							      'js_call'=> 'd_series.inline_on_off',
								       
							      ),
							    
							    
							    10=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="25%"',
								
								'js_call'=> 'show_user_info',
								
								'is_sort'=> 'timestamp_punch'
									 
								),
						),
				    #Sort Info
                                      
                                        
                                       'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                       
                                       'order_by'   =>'ORDER BY id ASC',
				       
				    
                                       
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=>"AND dna_code = 'EBAT' AND entity_code IN (SELECT code from entity where is_lib=0)",
				    
				    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
				    
				    #Search filter 
				
                                    'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_child_base',
										'field_id'	=> 'sn',
										'field_name' 	=> 'sn',
										'filter'	=> " AND entity_code ='EA' "
									     ),
												     
								'title' 		=> 'Name',										
								'search_key' 		=> 'sn',													       
								'is_search_by_text' 	=> 1,
							     ),
						    ),
				    
				    
				    #Custom filter
				    
				    'custom_filter' => array(  			     						   
							      
									
									array(  'field_name' => 'Entity',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn',"WHERE is_lib=0 ORDER by sn ASC"),
							    
										'html'=>'  title="Select Client"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "entity_code"  // main table value
									),
									
									array(  'field_name' => 'Input Type:',
									      
										'field_id' => 'cf2', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity_attribute','code,sn'," WHERE entity_code='IT' ORDER by sn ASC"),
							    
										'html'=>'  title="Select Client"   data-width="160px"  ',
								    
										'cus_default_label'=>'Show All',
							    
										'filter_by'  => "(SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=entity_child_base.id AND ea_code='APIT')"  // main table value
									),
									
									
									
							    ),
				    
				    # js
				    
				    'js' => array('is_top' => 1, 'top_js' => "$LIB_PATH/def/external_attribute/d"),
				
				#check_field
								
					'check_field'   =>  array('id' => @$_GET['id']),
					
					'search_filter_off'=>1 ,
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=external_attribute', 'b_name' => 'Add External Attribute' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),
					
					'bulk_action' => array(
							    array('is_bulk_button' => 1,
								  'button_name'    => 'Set Active',
								  'js_call'        => 'set_active'
							    ),
							    
							    array('is_bulk_button' => 1,
								  'button_name'    => ' Set In-Active ',
								  'js_call'        => 'set_inactive'
							    )
						), 
											    
				    #export data
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DURP'
                            
                            );
	    
	    # custome filter enity
	    
	        
	    if(@$_GET['cf1']){
			
			$D_SERIES['add_button']['page_link']='f=external_attribute&default_addon=PT';
			
	    }
?>
	    