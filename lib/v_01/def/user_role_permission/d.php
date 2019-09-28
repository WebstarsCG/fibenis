<?PHP
//            define("PAGE_CODE", "MANAGE_USER");
//		
//	    define('PAGE_PERM', $_SESSION['MANAGE_USER']);
    
            $D_SERIES       =   array(
                                   
                                   'title'=>'<li><a href="?d=user_role">User Role</a></li><li>User Role Permission</li>',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'User Role Name',
                                                                     
                                                                     'field'=>'(SELECT ln FROM user_role WHERE id=user_role_id)',
								    
								     'td_attr' =>  ' class="label_grand_father" '
								    
								    ),
							    
                                                            
                                                            2=>array(	'th'	=> 'Permission',
								     
                                                                        'field'	=> " (SELECT ".$DC->group_concat('get_ecb_parent_child_name(id,\'-\')')." FROM ecb_parent_child_matrix WHERE id IN(SELECT user_permission_id FROM user_role_permission_matrix WHERE user_role_id=user_role_permission.user_role_id) ) ",
								    
									'js_call'=>'tip_from_list'
									
									), 
						),
				    #Sort Info
                                      
                                       
                                        
                                       'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                       
                                       'order_by'   =>'ORDER BY id ASC',
				       
				    
                                       
                                    #Table Info
                                    
                                    'table_name' =>'user_role_permission',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=>'',
				    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                    //'js'            => 'm_code',
                                
				
				# Check Field
								
				'check_field'       =>  array('id' => @$_GET['id']),								
								
				'add_button'        =>  array( 'is_add' =>1,'page_link'=>'f=user_role_permission', 'b_name' => 'Add User Role Permission' ),
								
				'del_permission'    =>  array('able_del'=>1,'user_flage'=>1), 
								
				'date_filter'       =>  array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),	
								
				
                                # Export data
                                
				'export_csv'        =>  array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
			
                            
                            );