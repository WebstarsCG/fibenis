<?PHP
	       
         $D_SERIES       =   array(
                                   'title'=>'Status Map',
                                    'data'=> array(
                            
												6=>array('th'			=> 'Code',								 
															 'field'	=> 'entity_code',									
															 'attr'		=> ['width'=>'5%','class'=>'label_grand_child align_CM'],
															
																										 
														),

												1=>array('th'			=> 'Name',								 
														 'field'	=> '(SELECT sn FROM entity WHERE code=entity_code)',									
														 'attr'		=> ['width'=>'10%','class'=>'label_father txt_size_12']
																									 
													), 
													
												3=>array('th'			=> 'Start ',								 
															 'field'	=> 'get_ecb_sn_by_token(status_code_start)',									
															 'attr'		=> ['width'=>'14%' ,'class'=>'clr_green b']
																										 
														), 	

												2=>array('th'			=> 'Start Code',								 
															 'field'	=> 'status_code_start',									
															 'attr'		=> ['width'=>'10%' ,'class'=>'clr_gray_7'],
															 'is_sort'	=> 1,
																										 
														), 
														
												5=>array('th'			=> 'End',								 
															 'field'	=> 'get_ecb_sn_by_token(status_code_end)',									
															 'attr'		=> ['width'=>'14%' ,'class'=>'clr_dark_blue']
																										 
														),	

												4=>array('th'			=> 'End Code',								 
															 'field'	=> 'status_code_end',									
															 'attr'		=> ['width'=>'10%' ,'class'=>'clr_gray_7'],
															  'is_sort'	=> 1,
																										 
														), 
														
												7=>array('th'=>'Updation',
									 
														'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
																								 
														'td_attr' => 'width="18%"',
														
														'js_call'=> 'show_user_info',
														
														'is_sort' => 'timestamp_punch'
															 
												),		
																				
												
													
													
									),
                            
                                        
                                       'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
                                       'order_by'   =>'ORDER BY entity_code ASC' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'status_map',
                                    
                                    'key_id'    =>'id',
                                    
                                
                                    # Communication
                                
                                    'prime_index'   => 2,
                                
				
				#Search filter 
				'search_filter_off'   => 1,				
				'custom_filter' => array(),
				'del_permission' => array('able_del'=>1,'user_flage'=>1), 
		);
	
	
	# custon filter 1
	$D_SERIES['functions']['code_filter']=function($code){
		
			global $G,$D_SERIES;
		
			array_push($D_SERIES['custom_filter'], array(
						
							'field_name' => 'Start Code',		
							'field_id' => 'cf2', 		
							'filter_type' =>'option_list', 														
							'option_value'=> $G->option_builder('entity_child_base','token,sn'," WHERE entity_code='$code' ORDER BY line_order"),
									
							'cus_default_label' => 'Show All',										
							'html' => ' class="w_150"',									
							'filter_by'  => 'status_code_start'										
				));
	};
    
	
	if(@$_GET['default_addon']){
		
		$default_addon = @$_GET['default_addon'];
        
		unset($D_SERIES['data'][6]); // code
		unset($D_SERIES['data'][1]); // name
		unset($D_SERIES['export_csv']);
		
		$LAYOUT	   			  						= 'layout_full';
		
		$D_SERIES['action']['is_edit']	  			= 1;
		$D_SERIES['action']['action_menu_off']		= 1;
		$D_SERIES['action']['action_default_addon'] = $default_addon;
		$D_SERIES['add_button']['is_add'] 			= 0;		
		$D_SERIES['hide_show_all'] 	  = 1;
		$D_SERIES['search_filter_off']= 1;
		$D_SERIES['hide_show_all'] 	  = 1;
		$D_SERIES['hide_pager'] 	  = 1;
		$D_SERIES['show_all_rows']	  = 1;
		$D_SERIES['filter_off'] 	  = 1;
		
		$D_SERIES['key_filter']		  = " AND entity_code='$default_addon'";
		
		$D_SERIES['functions']['code_filter']($default_addon);
		
	}else{
			array_push($D_SERIES['custom_filter'],array(
								
									'field_name' => 'Entity',
								
									'field_id' => 'cf1', 
								
									'filter_type' =>'option_list', 
																
									'option_value'=> $G->option_builder('entity','code,sn','order by sn'),
											
									'cus_default_label' => 'Show All',
												
									'html' => ' class="w_150"',
											
									'filter_by'  => 'entity_code'
								
								));
								
			if(@$_GET['cf1']){
		
				$D_SERIES['functions']['code_filter'](@$_GET['cf1']);
			}
	}
	
?>