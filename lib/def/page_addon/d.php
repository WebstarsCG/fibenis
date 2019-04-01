<?PHP
//            define("PAGE_CODE", "MANAGE_USER");
//		
//	    define('PAGE_PERM', $_SESSION['MANAGE_USER']);
    
            $D_SERIES       =   array(
                                
                                   'title'=>'Page Addon',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Name', 'field'=>'ln',
                                                                    
								    'td_attr' =>  ' class="label_grand_father" ',
                                                                    
                                                                    'is_sort'=>1,
								    
								    ),
                                                            
                                                            2=>array('th'=>'Template Def.', 'field'=>"concat(token,'=',sn)",
                                                                    
								    'td_attr' =>  ' class="clr_gray_9 "',
                                                                    
                                                                    'is_sort'=>1,
								    
								    ),
                                                            
                                                            3=>array(	'th'	=> 'Attributes',
								     
									'field'	=> " (SELECT ".$DC->group_concat('get_ecb_parent_child_name(id,\'-\')')." FROM ecb_parent_child_matrix WHERE id IN(SELECT id FROM ecb_parent_child_matrix WHERE ecb_parent_id=entity_child_base.id) ) ",
									'js_call'=>'tip_from_list'
                                                                        
                                                                        
									),
                                                            
                                                            
                                                            4=>array(	'th'	=> 'Addon',
								     
									'field'	=> 'id',
									
                                                                        'filter_out'=>function($data_in){
                                                                            
                                                                            
                                                                            $data_out = array('id'   => $data_in,
                                                                                               'link_title'=>'Add View',
                                                                                                'title'=>'Page Addon View',
                                                                                                'src'=>"?f=page_addon_view&at=$data_in&menu_off=1",
                                                                                                'style'=>"border:none;width:100%;height:600px;");
                                                                                         
											return json_encode($data_out);
                                                                        },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ),
                                                            
                                                            
                                                            5=>array(	'th'	=> 'Views',
								     
									'field'	=> 'id',
									
                                                                        'filter_out'=>function($data_in){
                                                                            
                                                                            
                                                                            $data_out = array('id'   => $data_in,
                                                                                               'link_title'=>'View',
                                                                                                'title'=>'Page Addon View',
                                                                                                'src'=>"?d=page_addon_view&at=$data_in&menu_off=1&mode=simple",
                                                                                                'style'=>"border:none;width:100%;height:600px;");
                                                                                         
											return json_encode($data_out);
                                                                        },
                                                                        
                                                                        'js_call'=>'d_series.set_nd'
                                                                        
								    ), 
						),
				    #Sort Info
                                      
                                        
                                    'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                    
                                    'order_by'   =>'ORDER BY id ASC',
				       
				    
                                       
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=>" AND entity_code = 'AT' ",
				    
				 
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                    //'js'            => 'm_code',
                                    
                                    'search_text' => array(),
                                    
                                    # narrow down
                                    
                                    'is_narrow_down'=>1,
						
				
				#Search filter 
				
				'search_field' => '',
				
				'search_id' 	=> array(),
				
				#check_field
								
					'check_field'   =>  array('id' => @$_GET['id']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=page_addon', 'b_name' => 'Add Page Addon' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				    #export data
				    
                                    'export_csv'   => array('is_export_file' => 1, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
                                                                    
                                    'page_code'    => 'DURP',
                                    
                                    'show_query'=>0,
                            
                            );
            
            
        # addon
        
    