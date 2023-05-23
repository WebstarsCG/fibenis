<?PHP

            $D_SERIES       =   array(
                                   
                                   'title'=>'<li><a href="?d=user_role">User Role</a></li><li>User Role Permission</li>',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Page Name',
                                                                     
                                                                     'field'=>'sn',
								    
																	'td_attr' =>  ' class="label_grand_father" '
								    
															),
							                                                                
                                                            2=>array(	'th'	  => 'Permission',
								     
                                                                        'field'	  => " (SELECT ".$DC->group_concat('get_ecb_parent_child_name(id,\'-\')')." FROM ecb_parent_child_matrix WHERE id IN(SELECT user_page_id FROM user_role_page_matrix WHERE user_role_page_id=user_role_page.id) ) ",
								    
																	'js_call' => 'tip_from_list'
																	), 
										
															3=>array('th'		=> 'Line Order',                                                           
																	 'field'	=> 'line_order',								    
																	 'td_attr' 	=> ' class="label_number align_RM" ',
																	 'is_sort'	=> 1 )
															
							                                     
						),
				    #Sort Info
                                      
                                       
                                        
                                       'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                       
                                       'order_by'   =>'ORDER BY id ASC',
				       
				    
                                       
                                    #Table Info
                                    
                                    'table_name' =>'user_role_page',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=>'',
				    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
									'show_default_rows'  => 10,
                                
                                
				
				# Check Field
								
				'check_field'       =>  array('id' => @$_GET['id']),								
								
				'add_button'        =>  array( 'is_add' =>0,'page_link'=>'f=user_role_page', 'b_name' => 'Add User Role Page' ),
								
				'del_permission'    =>  array('able_del'=>1,'user_flage'=>1), 
								
				'date_filter'       =>  array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				
                                # Export data
                                
				'export_csv'        =>  array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
			
                            
                            );
            
            # end
            if(@$_GET['default_addon']){                
                
                        $D_SERIES['key_filter'] = " AND user_role_id = $_GET[default_addon] ";
                      
                        $D_SERIES['filter_off'] = 0; 
                        $D_SERIES['hide_show_all'] = 1;
						
                        $D_SERIES['action']['action_menu_off']         = @$_GET['menu_off'];
                        $D_SERIES['action']['action_default_addon']    = @$_GET['default_addon'];
                        
                        $LAYOUT = 'layout_full';
						
						
                
            }else{
                
                        $D_SERIES['key_filter'] = " id=0";
            }