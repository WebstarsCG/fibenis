<?php
	
		$LAYOUT	    = 'layout_basic';
    
		
		$D_SERIES	=	array(
					'title'			=>'EAV DB',
					
					'is_user_base_query'=>0,
				    
				    'gx' => 1,
				    
                     #table data
                                    
                    'data'=> array( 
						  
							
							1=>array('th'		=>'XML File ',
								
									'field' 	=>"get_eav_addon_varchar(entity_child.id,'IMFL')",
									
									'td_attr' 	=> ' class="label_father align_LM" width="30%"',
									
									'is_sort' 	=> 0,							
									
									'js_call'   => 'view_file'
																	
									),
							2=>array('th'=>'Updated On',
								
								'field' =>"date_format(timestamp_punch,'%d-%b-%Y %H:%I') ",
								
								'td_attr' => ' class="no_wrap clr_gray_a align_LM txt_size_11" width="30%"',
								
								'is_sort' => 1,),
								
									),
					
					
					'table_name' =>'entity_child',
					
					
                                    
                    'key_id'    =>'id',
                                    
                    # Default Additional Column
                     
					'js'            => array('is_top'=>1, 'top_js' => $LIB_PATH.'def/entity/eav/import/d'),
					 
                    'is_user_id'       => 'user_id',
					
					'action'        => array('is_action' => 0, 'is_edit' => 0, 'is_view' => 0),
					
					'key_filter'	=> "AND entity_code = 'IM'",
					
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button'    => array( 'is_add' =>1,'page_link'=>'f=entity__eav__import', 'b_name' => 'Add' ),
								
					'del_permission'=> array('able_del'=>1,'user_flage'=>0), 
								
					'date_filter'   => array( 'is_date_filter' =>1,'date_field' =>  'timestamp_punch'),	
								
					#export data
					
					'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
									
					'page_code'    => 'REVI',
					
					'show_query'=>0,
					
					'search_filter_off'	=>1,
								
								);
    		    
?>
				