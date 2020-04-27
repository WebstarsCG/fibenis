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
                                                            3=>array('th'=>'Input Type', 'field'=>"get_ecb_ln_by_token(get_ecb_av_addon_varchar(id,'APIT'))",
                                                                    
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
                                
				    'is_narrow_down'   => 1,	
				
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
												    
										'option_value'=> $G->option_builder('entity_child_base','token,ln'," WHERE entity_code='IT' ORDER by ln ASC"),
							    
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
								
				'show_query'=>0,
                            
                            );
	    
	    # custome filter enity
	    
	        
	    if(@$_GET['cf1']){
			
			$D_SERIES['add_button']['page_link']='f=external_attribute&default_addon=PT';
			
	    }
	    
	    
	    //ext_at_addon
	    
	    $D_SERIES['data'][7] = array(	'th'=>'Edit ',
								
						'field' =>"concat(id,':',get_ecb_addon_varchar(entity_child_base.id,'APIT'),':',entity_code)",
						
						'td_attr' => ' class=" align_RM" width="10%"',
						
						'filter_out'=>function($data_in){
							    	    
							    global $PAGE_NAME;
							    
							    $lv=[];
							    
							    $temp = explode(':',$data_in);
        
							    $data_out	 = array('id'        => $temp[0],
									         'link_title'=> 'Edit',
									         'is_fa'     => ' fa fa-edit',
									         'title'     => 'Manage External Attribute',
									         'src'       => "?f=$PAGE_NAME&i_t=$temp[1]&key=$temp[0]$lv[addon_param]&default_addon=$temp[2]&menu_off=1",
									         'style'     => "border:none;width:100%;height:450px;");
										    
							    return json_encode($data_out);													 
						},
                                                                        
                                                'js_call'=>'d_series.set_nd'
								
					);
                                        
            $D_SERIES['action']  = array('is_action'=>1, 'is_edit' => 0, 'is_view' =>0);
	    
	    //end ext_at_addon
	    
	    
	if(@$_GET['default_addon']){
		
		$default_addon = @$_GET['default_addon'];
        	$D_SERIES['key_filter'].=" AND  entity_code='$default_addon'";
		//unset($D_SERIES['data'][1]);
		//unset($D_SERIES['data'][5]);
		unset($D_SERIES['export_csv']);
		$LAYOUT	   			  = 'layout_full';
		$D_SERIES['action']['is_edit']	  = 0;
		$D_SERIES['action']['action_default_addon'] = $default_addon;
		$D_SERIES['add_button']['is_add'] = 0;		
		$D_SERIES['hide_show_all'] 	  = 1;
		$D_SERIES['search_filter_off']	  = 1;
		$D_SERIES['hide_show_all'] 	  = 1;
		$D_SERIES['hide_pager'] 	  = 1;
		$D_SERIES['show_all_rows']	  = 1;
		$D_SERIES['filter_off'] 	  = 1;
	}

?>
	    