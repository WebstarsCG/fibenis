<?PHP
	include($LIB_PATH."def/mop_v2_eav/t_map.php");
	
	$LAYOUT	    = 'layout_basic';
	
        $D_SERIES       =   array(
                                   'title'=>'Page Sections',
                                    
                                    #query display depend on the user
                                    
                                    'gx'	=> 1,
				    
				    #table data
                                    
                                    'data'=> array(
					                
							1=>array('th'=>'Menu Name',
									 
								'field'=>"get_eav_addon_varchar(id,'ECSN')",
                                                                   
								'td_attr' => ' class="label_father align_LM" width="15%"',
								
								'is_sort' =>1
									 
								),
							
							 2=>array('th'=>'Entity',
								 
								'field'=>"entity_code",
								
								'is_sort' => 1,	
								
								'attr'=>['class'=>' clr_gray_b txt_size_12',
									 'width'=> ' 5%' 
									 ],
                                                                            
								),
							 
							 
							3=>array('th'=>'Ent. Name',
									 
								'field'=>"(SELECT sn FROM entity WHERE code=entity_code)",
                                                      
								
								'is_sort' =>0,
								
								'attr'=>['class'=>' clr_gray_9 txt_size_12',
									 'width'=> ' 10%' 
									 ],
								),
							
							
							
							4=>array('th'=>'Heading',
									 
								'field'=>"IFNULL(get_eav_addon_varchar(id,'ECLN'),'N.A')",
                                                                   
								'td_attr' => ' class="label_grand_chilld align_LM" width="10%"',
								
								'is_sort' =>0
								),
							
							5=>array('th'=>'Sub Heading',
									 
								'field'=>"IFNULL(get_eav_addon_text(id,'ECDT'),'N.A')",
                                                                   
								'td_attr' => ' class="label_father align_LM" ',
								
								'is_sort' =>0,
								
								'attr'=>['class'=>' clr_gray_9 txt_size_11',
									 
									 'width'=>"20%"
									],
								
								),
							
							
							 
							 
							6=>array('th'=>'Status',
									 
								'field'=>'CONCAT(id,"[C]",is_active)',
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => ' class="label_child align_LM  txt_case_upper b" style="padding-right:10px;" width="3%"',
								
								   'filter_out'=>function($data_in){
										
											$temp     = explode('[C]',$data_in);
											
											$flag     = [1,0];
											
											$data_out = array(
													  'data'=>array('id'   => $temp[0],
															'key'  => md5($temp[0]),
															'label'=> 'Page',
															'cv'   => $temp[1],
															'fv'   => $flag[$temp[1]],
															'series'=>'a',
															'action'=>'entity_child',
															'token' =>'ECAI'
															)
													);
											
											return json_encode($data_out);
										},
										
										
								'td_attr' => ' align_CM',
								'js_call' => 'd_series.inline_on_off'
									 
								), 
					
					
							11=>array('th'=>'&nbsp;Menu',
									 
								'field' => "IFNULL(get_exav_addon_num(id,'OPSS'),0)",
								//'field' => "get_exav_addon_num(id,'OPSS')",
																
								'span'      =>  '<span id="sort_icon_2" name="sort_icon_2"></span>',
									 
								'td_attr' => '   width="5%" class="align_CM"',
								
								'filter_out'=>function($data_in){ $temp[0]=1;$temp[1]=0;return $temp[$data_in]; },
								
								'js_call' => 'boolean_display'
									 
								), 
					
                                                        7=>array('th'=>'Line Order',
								 
								'field'=>"concat(id,'[C]',line_order)",
								
								'is_sort' => 'line_order',	
								
								'td_attr' => ' width="15%" ',
								
								'filter_out'=> function($data_in){
										
											$temp     = explode('[C]',$data_in);									
											$data_out = array(
													  'data'=>array('id'   => $temp[0],															
															'key'  => md5($temp[0]),
															'label'=> 'Line Order',
															'info' => $temp[1],
															'series'=>'a',
															'action'=>'entity_child',
															'token' =>'ECLI'
															)
													);
											
											
											return json_encode($data_out);
										},
										
								'js_call'	=> 'd_series.set_inline_update'	
                                                                            
								),
							
							8=>array('th'	=> 'View',
								     
								'field'	=> "concat((SELECT ln FROM entity WHERE code=entity_child.entity_code),':',id,':',entity_code)",
								
								'td_attr' => ' width="5%" ',
								
								'attr'    => [ 'class'=>'align_CM'],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
													$data_out = array( 'id' => $temp[1],
															  'is_fa' => 'fa-chevron-circle-right',
															  'is_fa_btn' => 'btn-default',
												        'link_title'=>'',
													'title'	=> 'View',
												         'src'=>"?d$temp[0]&menu_off=1&mode=simple&default_addon=$temp[1]&code=$temp[2]",
													 'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
												 },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
							
							9=>array('th'	=> 'Add',
								     
								'field'	=> "concat((SELECT ln FROM entity WHERE code=entity_child.entity_code),':',id,':',get_ec_parent_id_eav(id),':',entity_code)",
								
								'td_attr' => ' width="5%" ',
								
								'attr'    => [ 'class'=>'align_CM'],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
													$data_out = array( 'id' => $temp[1],
													'is_fa' => 'fa-plus-square-o',
												        'link_title'=>'Add',
													'title' => 'Add',
												         'src'=>"?f$temp[0]&menu_off=1&mode=simple&default_addon=$temp[2]&code=$temp[3]",
													 'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
												 },
                                                                        
                                                                'js_call'=>'d_series.set_nd'
                                                                        
								),
							
							
							
							10=>array('th'	=> 'Edit',
								     
								'field'	=> "id",
								
								'td_attr' => ' width="5%" ',
								
								'attr'    => [ 'class'=>'align_CM'],
									
                                                                'filter_out'=>function($data_in){
													$temp = explode(':',$data_in);
													$data_out = array( 'id' => $temp[0],
													'is_fa' => 'fa-edit',
												        'link_title'=>'Edit',
													'title' => 'Edit',
												         'src'=>"?f=one_page_eav&menu_off=1&mode=simple&key=$temp[0]",
													 'style'=>"border:none;width:100%;height:600px;");
													 return json_encode($data_out);
												 },
                                                                        
                                                                'js_call'=>'d_series.set_nd'
                                                                        
								),
							  
						),
				    
				    
						
				    
				    
							
				    
                                    
				    'action' => array('is_action'=>1, 'is_edit' =>0, 'is_view' =>0 ),
                                       
				    'order_by'   =>" ORDER BY get_eav_addon_num(id,'ECSN') ASC " ,
				    
				    
				    
				
				#Search
				
				'search'=> 	array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity',
										'field_id'	=> 'sn',
										'field_name' 	=> 'sn',
										 
									 ),
							      
								'title' 		=> 'Name',										
								'search_key' 		=> " get_eav_addon_num(id,'ECSN') ",													       
								'is_search_by_text' 	=> 1, //( For Text search case)	      
							),
								
						),
				
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
				    
				    'is_narrow_down'=>1,
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
				    
				    # after delete
				    
				    'after_delete' => 1,
                                
                                    # File Include
                                
                                  'js'            => array('is_top'=>1, 'top_js' => 'js/d_series/one_page'),
         		
				  'key_filter'	=>" AND entity_code IN ($T_SERIES[op_code])",
				  
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				'page_code'    => 'DECA',
				
				'show_query'=>0
                            
                            );
	
	
		// ds
	
		if(@$_GET['default_addon']){
			
			$coach_code = $_GET['default_addon'];
			
			$D_SERIES['key_filter'].= " AND get_ec_parent_id_eav(id)=get_coach_id_by_code('$coach_code')";
						
			$D_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>"f=one_page_eav", 'b_name' => 'Add Page Section' );
						
		} // end
		
		// after delete
		
		function after_delete($param){
			
			global $rdsql;			 
			$rdsql->exec_query("DELETE FROM entity_child WHERE get_eav_addon_num(id,'ECPR')=$param[key_id]","");			
			
		} # end

?>

	