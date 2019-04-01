<?PHP
//            define("PAGE_CODE", "MANAGE_USER");
//		
//	    define('PAGE_PERM', $_SESSION['MANAGE_USER']);
    
            $D_SERIES       =   array(
			              #Title:
			              
                                      'title'=>'User Role and Permission',

                                      #query display depend on the user

                                      'is_user_base_query'=>0,
                                    
                                      #table data
                                    
                                       'data'=> array(
                                                            1=>array('th'=>'Code',
                                                                     
                                                                     'field'=>'sn',
                                                                            
                                                                    'html' => 'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',1);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_1\'));filter_data();"',
								  
								    'font'=>  'class="sort"',
																
								    'span'=>'<span id="sort_icon_1" name="sort_icon_1"></span>'
                                                                    
                                                            ),
                                                            
                                                            2=>array('th'=>'Role',
                                                                     
                                                                     'field'=>'ln',
								    
                                                                    'html' => 'style	= "cursor:pointer" onclick="JavaScript:E_V_PASS(\'sort_field\',2);E_V_PASS(\'sort_direction\',GET_E_VALUE(\'sort_col_2\'));filter_data();"',
								  
								    'font'=>  'class="sort"',
																
								    'span'=>'<span id="sort_icon_2" name="sort_icon_2"></span>'
                                                                    
                                                            ),
                                                            
                                                            3=>array('th'=>'Home Page URL',
                                                                     
                                                                     'field'=>'home_page_url',
								     
                                                                     'attr'=>["width"=>"25%"]
                                                            )
							    
							    
						),
				       
				                                           
                                    #Table Info
                                    
                                    'table_name' =>'user_role',
                                    
                                    'key_id'    =>'id',
                                    
                                    'is_user_id'       => 'user_id',
                                
                                    'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'user_role',
										'field_id'	=> 'id',
										'field_name' 	=> 'ln',
									     ),
												     
								'title' 		=> 'Role',										
								'search_key' 		=> 'id',													       
								'is_search_by_text' 	=> 0,
							     ),							
							
						       ),
				   
				   
				    'check_field'   =>  array('id' => @$_GET['id']),
				   
				    'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>'timestamp_punch'),
				
				    'sort_field' =>array('sn','ln'),
				    
				    'order_by'   =>'ORDER BY id ASC',
				    
				    'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                       
                                    'add_button' => array( 'is_add' =>1,'page_link'=>'f=user_role', 'b_name' => 'Add User Role' ),
				    
				    'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
			            'prime_index'   => 1,
                                    
                                    'show_query'    => 0,
                                
                                    'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
								
				    'page_code'    => 'DUSR'
                            
                            );