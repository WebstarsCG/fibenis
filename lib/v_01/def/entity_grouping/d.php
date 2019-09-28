<?PHP
//            define("PAGE_CODE", "MANAGE_USER");
//		
//	    define('PAGE_PERM', $_SESSION['MANAGE_USER']);
    
            $D_SERIES       =   array(
                                   
                                   'title'=>'Entity Grouping',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Code',
                                                                     
                                                                     'field'=>'token',
								    
								     'td_attr' =>  ' class="label_father" '
								    
								    ),
                                                            
                                                            2=>array('th'=>'Name',
                                                                     
                                                                     'field'=>'sn',
								    
								     'td_attr' =>  ' class="label_child"  '
								    
								    ),
                                                            
                                                            3=>array('th'=>'Entity',
                                                                     
                                                                    'field'     => "concat_ws(':',substring_index(note,',',7),note)",
								
                                                                    'td_attr' =>  ' class="label_grand_father" ',
                                                                     
                                                                     'filter_out'=>function($data_in){
									
									$temp = explode(':',$data_in);
									
									return "<a class='tip clr_gray_5'>$temp[0]...</a><span class='tooltiptext'>$temp[1]</span>";
										
								}
								    
							    ),
							    
                                                            
//                                                            3=>array(	'th'	=> 'Permission',
//								     
//                                                                        'field'	=> " (SELECT ".$DC->group_concat('get_ecb_parent_child_name(id,\'-\')')." FROM ecb_parent_child_matrix
//                                                                                        WHERE id IN(SELECT user_permission_id FROM user_role_permission_matrix WHERE user_role_id=user_role_permission.user_role_id) ) ",
//								    
//									'js_call'=>'tip_from_list'
//									
//									),

						),
				    #Sort Info
                                      
                                       
                                        
                                       'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                       
                                       'order_by'   =>'ORDER BY id ASC',
				       
				    
                                       
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=>' AND entity_code = "GP"',
				    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                    
                                    'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
                                    
                                    'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_child_base',
										'field_id'	=> 'id',
										'field_name' 	=> 'sn',
										'filter'	=> ' AND entity_code = "GP"'
									     ),
												     
								'title' 		=> 'Name',										
								'search_key' 		=> 'id',													       
								'is_search_by_text' 	=> 0,
							     ),							
							
						       ),

                                
                                    # File Include
                                
                                    //'js'            => 'm_code',
                                
				
				# Check Field
								
				'check_field'       =>  array('id' => @$_GET['id']),								
								
				'add_button'        =>  array( 'is_add' =>1,'page_link'=>'f=entity_grouping', 'b_name' => 'Add Entity Grouping' ),
								
				'del_permission'    =>  array('able_del'=>1,'user_flage'=>1), 
								
				'date_filter'       =>  array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				
                                # Export data
                                
				'export_csv'        =>  array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
			
                            
                            );