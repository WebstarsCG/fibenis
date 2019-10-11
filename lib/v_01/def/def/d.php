<?PHP

    
            $D_SERIES       =   array(
                                   'title'=>'Defination',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Name',
                                                                     
                                                                     'field'=>'ln',
								    
								    'is_sort'=> 1, 
                                                                    								    
								     'td_attr' =>  ' class="label_grand_father" '
								    
								),
							    
                                                            
                                                            2=>array(	'th'	=> 'Token',
								     
                                                                        'field'	=> "sn",
								),
							    
							    
						),
				    #Sort Info
                                       
                                       'action' => array('is_action'=>1, 'is_edit' => 1, 'is_view' =>0),
                                       
                                       'order_by'   =>'ORDER BY sn ASC',
				       
				    
                                       
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
				    
				    'key_filter'=>" AND entity_code='DF' ",
				    
				 
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                    'search'=> array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_child_base',
										'field_id'	=> 'id',
										'field_name' 	=> 'ln',
										'filter'	=>" AND entity_code='DF' "
									     ),
												     
								'title' 		=> 'Name',										
								'search_key' 		=> 'ln',													       
								'is_search_by_text' 	=> 1,
							     ),							
							
						       ),
				
				    #check_field
								
					'check_field'   =>  array('id' => @$_GET['id']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=def', 'b_name' => 'Add Defination' ),
								
					'del_permission' => array( 'able_del'        =>1,
								   'avoid_del_field' => 'IF(((SELECT count(*) FROM ecb_parent_child_matrix WHERE ecb_parent_id=entity_child_base.id OR ecb_child_id=entity_child_base.id)>0),1,0)',
							           'avoid_del_value' => 1 ),
					
                            
                            );