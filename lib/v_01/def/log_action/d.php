<?PHP

    
            $D_SERIES       =   array(
                                   'title'=>'Defination',
                                    
                                    #query display depend on the user
                                    
                                    'is_user_base_query'=>0,
                                    
                                    'gx'=>1,
                                    
                                    #table data
                                    
                                    'data'=> array(
                                                            1=>array('th'=>'Token',
                                                                     
                                                                     'field'=>'token',
								    
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
				    
				    'key_filter'=>" AND entity_code='LX' and dna_code='EBAX' ",
				    
				 
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                    
				
				#check_field
								
					'check_field'   =>  array('id' => @$_GET['id']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=log_action', 'b_name' => 'Add Defination' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  'timestamp'),									
				  	
                                        'page_code'    => 'DURP'
                            
                            );