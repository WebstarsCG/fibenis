<?PHP
    
            $D_SERIES       =   array(
                                
                                    'title'=>'Page Addon',
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Name', 'field'=>'ln',
                                                                    
								    'td_attr' =>  ' class="label_grand_father" ',
                                                                    
                                                                    'is_sort'=>1,
								    
								    'attr'   => ['width'=>'10%']
								    
								    ),
                                                            
                                                            2=>array('th'=>'Template Def.', 'field'=>"concat(token,'=',sn)",
                                                                    
								    'td_attr' =>  ' class="clr_gray_9 "',
                                                                    
                                                                    'is_sort'=>1,
								    
								    'attr'   => ['width'=>'15%']
								    
								    ),
                                                            
                                                            3=>array(	'th'	=> 'Attributes',
								     
									'field'	=> " (SELECT ".$DC->group_concat('get_ecb_parent_child_name(id,\'-\')')." FROM ecb_parent_child_matrix WHERE id IN(SELECT id FROM ecb_parent_child_matrix WHERE ecb_parent_id=entity_child_base.id) ) ",
									'js_call'=>'tip_from_list',
                                                                        'attr'   => ['width'=>'60%']
                                                                        
									),
                                                            
                                                            
//                                                            4=>array(	'th'	=> 'Addon',
//								     
//									'field'	=> 'id',
//									
//                                                                        'filter_out'=>function($data_in){
//                                                                            
//                                                                            
//                                                                            $data_out = array('id'   => $data_in,
//                                                                                               'link_title'=>'Add View',
//                                                                                                'title'=>'Page Addon View',
//                                                                                                'src'=>"?f=page_addon_view&at=$data_in&menu_off=1",
//                                                                                                'style'=>"border:none;width:100%;height:600px;");
//                                                                                         
//											return json_encode($data_out);
//                                                                        },
//                                                                        
//                                                                        'js_call'=>'d_series.set_nd'
//                                                                        
//								    ),
//                                                            
//                                                            
//                                                            5=>array(	'th'	=> 'Views',
//								     
//									'field'	=> 'id',
//									
//                                                                        'filter_out'=>function($data_in){
//                                                                            
//                                                                            
//                                                                            $data_out = array('id'   => $data_in,
//                                                                                               'link_title'=>'View',
//                                                                                                'title'=>'Page Addon View',
//                                                                                                'src'=>"?d=page_addon_view&at=$data_in&menu_off=1&mode=simple",
//                                                                                                'style'=>"border:none;width:100%;height:600px;");
//                                                                                         
//											return json_encode($data_out);
//                                                                        },
//                                                                        
//                                                                        'js_call'=>'d_series.set_nd'
//                                                                        
//								    ), 
						),
				    #Sort Info
                                      
                                       
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
                                    
                                    'action' => array('is_action'=>1, 'is_edit' => 1),
                                    
                                    # narrow down
                                    
                                    'is_narrow_down'=>1,
						
				
				#Search filter 
				
				    'search_filter_off'=>1,
				
				#check_field
								
					'check_field'    =>  array('id' => @$_GET['id']),								
								
					'add_button' 	 => array( 'is_add' =>1,'page_link'=>'f=page_addon', 'b_name' => 'Add Page Addon' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
                            
                            );
            
            
        # addon
        
    