<?PHP
		
	$LAYOUT	    	= 'layout_basic';
               
        $D_SERIES       =   array(
                                   'title'=>'Contact Details',
                                    
                                    'is_user_base_query'=>0,
				    
				    'gx' => 1,
				    
                                    'data'=> array(
//					                1=>array('th'=>'User Id ',
//								
//                                                                'field' => "get_user_id(entity_child.id)",
//								
//								'td_attr' => ' class="label_father align_RM" width="7%"',
//								
//								'is_sort' => 0,
//								
//								'filter_out'=>$FILTER['square_secondary']
//								
//								),
							
							2=>array('th'=>'Name ',
								
                                                                'field' => "get_eav_addon_varchar(id,'COFN')",
								  
								'td_attr' => ' class="clr_pri b align_LM no_wrap" width="20%"',
								
								'is_sort' => 1,
								
								),
							
							3=>array('th'=>'Email ',
								
                                                                'field' => "get_eav_addon_varchar(id,'COEM')",
								  
								'td_attr' => ' class="label_child align_LM" width="20%"',
								
								'is_sort' => 1,
								
								),
					
							4=>array('th'=>'Mobile ',
								
								'field' => "(get_eav_addon_varchar(id,'COMB'))",
                                                                   
								'td_attr' => ' class="label_child align_LM" width="15%"',
								
								'is_sort' => 0,
								
								),
							
//							5=>array('th'=>'EC ID ',
//								
//                                                                'field' => "id",
//								
//								'td_attr' => ' class="label_father align_RM" width="10%"',
//								
//								'is_sort' => 0,
//								
//								//'filter_out'=>$FILTER['square_secondary']
//								
//								),
							
							6=>array('th'=>'Role ',
								
                                                                'field' => "get_user_role(entity_child.id)",
								
								'td_attr' => ' class="clr_gray_7 align_LM" width="15%"',
								
								'is_sort' => 1,
								
								),

							7=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="25%"',
								
								'js_call'=> 'show_user_info',
								
								'is_sort' => 1
									 
								),
							
						),
				    
					
                                        
                                       'action' 	=> array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   	=>'ORDER BY get_user_id(entity_child.id) ASC ' ,
				       
				       'custom_filter' 	=> array( ), 	
									
					'table_name' 	=>'entity_child',
					
					'is_narrow_down' => 1,
				
					'key_id'    	=>'id',					
					
					#'key_filter'    =>" AND  entity_code='CO'",
					
					'prime_index'   =>2,
					
					'custom_filter' => array(  			     						   
							      
							      array(  'field_name'       => 'Role',
															       
									'field_id'         => 'cf1',   
																	 
									'filter_type'      => 'option_list', 
																			     
									'option_value'=> $G->option_builder('user_role','id,ln',"ORDER BY ln ASC"),
							    
									'html'             => 'title="Select Super Entity"   data-width="80px"  ',
															     
									'cus_default_label'=>'Show All',
								
									'filter_by'        => '(SELECT user_role_id FROM user_info WHERE is_internal=entity_child.id)'
								),
							      
							 ),
					
	      
				#check_field
								
				'check_field'   =>  array('entity_code' => "'CO'"),								
							
				'add_button' => array( 'is_add' =>1,'page_link'=>'f=contact_eav', 'b_name' => 'Add Contact' ),
							
				'del_permission' => array('able_del'=>1,								  
							  'avoid_del_field' => 'IF(((SELECT id FROM user_info WHERE is_internal=entity_child.id)>0),1,0)',
							  'avoid_del_value' => 1
							  ), 
							
				
				
				'search_filter_off'	=>1,
				
				//'filter_off'	=> 0
				
			);
	
?>