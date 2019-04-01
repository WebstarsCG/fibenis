<?PHP
	$parent = @$_GET['default_addon'];
	
        $D_SERIES       =   array(
                                   'title'=>'Blend',
                                    
                                    #query display depend on the user
                                    
                                    'gx'	=> 1,
				    
				    #table data
                                    
                                    'data'=> array(
							1=>array('th'=>'Name',
								 
								'field'=>"get_eav_addon_varchar(id,'ECLN')",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'22%',
									   'class'=> ' label_grand_father '
									   ],
                                                                            
								),
							
							2=>array('th'=>'File',
								 
								'field'=>"get_eav_addon_varchar(id,'ECSN')",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'22%',
									   'class'=> ' label_grand_father '
									   ],
                                                                            
								),
							
							4=>array('th'	=> 'Add ', 'th_attr'=>' colspan=2 ',
								     
								'field'	=> "id",
								
								'attr' =>  [ 'class'=>"", 'width' => "6%"],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
						
													$data_out = array('id'   => $temp[0],
												         
													 'link_title'=>'  '.$temp[1],
													 'is_fa'=>' fa-chevron-circle-right clr_dark_blue fa-lg ',
													 'is_fa_btn'=>' btn-default btn-sm ',
													 'title'=>'Child View',
												         'src'=>"?d=create_theme__blend&menu_off=1&mode=simple&default_addon=$temp[0]",
												         'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
													 
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
									
									
                                                                        
								    ),
							
							5=>array('th'	=> '',
								     
								  'field'	=> 'id',
								  
								  'attr' =>  [ 'class'=>"brdr_right align_CM"],
									
								  'filter_out'=>function($data_in){
                                                                            
													$data_out = array('id'   => $data_in,
													'link_title'=>'Add Child',
													'is_fa'=>' fa fa-plus-square-o clr_dark_blue fa-lg',
													'title'=>'Add Child',
													'src'=>"?f=create_theme__blend&menu_off=1&mode=simple&default_addon=$data_in",
													'style'=>"border:none;width:100%;height:600px;"
												  );
														
													return json_encode($data_out);
													 
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							
							
							
							 7=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="20%"',
								
								'js_call'=> 'show_user_info',
									 
								),
							
							 
							),
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
				    'order_by'   =>'ORDER BY id ASC ' ,
				    
				    'custom_filter' => array( ),
				    
				    'key_filter' => "AND entity_code='BE'",
				    
				    #Search
				
				'search'=> 	array(),
				
				'search_filter_off' => 1,
				
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                  'js'            => array('is_top'=>1, 'top_js' => 'js/d_series/entity_child'),
         			
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Child' ),
								
					'del_permission' => array('able_del'=>1,
								  
								  'avoid_del_field' => "if(((SELECT 	(select count(*) FROM  eav_addon_ec_id as ec WHERE ea_code='ECPR' AND ec.ec_id = entity_child.id) )
											> 0),1,0)",
											
								  'avoid_del_value' => 1
								  
							),
					
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA',
				
				'show_query' => 0,
				
				'before_delete' => 1,
                            
                            );
	
	
	function before_delete($param){
		
		global $LIB_PATH;
		
		$lv 	      = array();
		
		$lv['folder_name'] = $param['g']->get_one_cell(['table'=>'eav_addon_varchar',
								'field'=>"ea_value",
								'manipulation'=>" WHERE ea_code='ECSN' AND
								parent_id=get_ec_parent_id_eav($param[key_id])" 
						    ]);
		
		$lv['file_name'] = $param['g']->get_one_cell(['table'=>'eav_addon_varchar',
								'field'=>"ea_value",
								'manipulation'=>" WHERE ea_code='ECSN' AND parent_id=$param[key_id]" 
						    ]);
		
		
		$lv['loc'] = get_config('theme_path').'/'.$lv['folder_name'].'/blend/source/'.$lv['file_name'].'.less';
		
		if(is_file($lv['loc'])){
		   
			unlink($lv['loc']);
		}  	
		
	       	
		
	} // end
	
	
	if(@$_GET['default_addon']){

		$default_addon = @$_GET['default_addon'];
		
		$LAYOUT	    = 'layout_full';
		
        	$D_SERIES['key_filter'].="AND get_ec_parent_id_eav(id)=$default_addon";
		
		$D_SERIES['action']['is_edit']=0;
		
		$D_SERIES['add_button']['is_add']=0;
		
		$D_SERIES['hide_show_all'] = 1;
		
		$D_SERIES['hide_pager'] = 1;
		
		$D_SERIES['show_all_rows']=1;
		
		$D_SERIES['search_filter_off']	=1;
		
		$D_SERIES['filter_off'] = 1;
		
		$D_SERIES['is_narrow_down']=1;
		
		unset($D_SERIES['export_csv']);
		
		unset($D_SERIES['custom_filter']);
		
		unset($D_SERIES['summary_data']);
			
				
	} // end
    
?>