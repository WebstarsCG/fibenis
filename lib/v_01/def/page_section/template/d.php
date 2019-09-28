<?PHP
	
	
	
	$D_SERIES       =   array(
                                   'title'=>'Section Template',
                                    
                                    #query display depend on the user
                                    
                                    'gx'	=> 1,
				    
				    #table data
                                    
                                    'data'=> array(
                                                        1=>array('th'=>'Template Name',
								 
								'field'=>"sn",
								
								'is_sort' => 1,	
								
								'attr' => ['width'=>'55%',
									   'class'=> ' label_grand_father '
									   ],
                                                                            
								),		
							
							
							 
							 2=>array('th'   => 'Updation',
									 
								'field'  => "concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'attr'   => ['class'=>'align_RM'],
								
								'js_call'=> 'show_user_info',
									 
								),
							
							 
							),
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>1),
                                       
				    'order_by'   =>'ORDER BY id ASC ' ,
				    
				
				
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
                                
                                    # File Include
                                
                                  'js'            => array('is_top'=>1, 'top_js' => 'js/d_series/entity_child'),
         			
				'key_filter'	=>" AND entity_code='SC' ",
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				'search'   => [ 	array(  'data'  =>array('table_name' 	=> 'entity_child_base',
										'field_id'	=> 'id',
										'field_name' 	=> 'sn',
										'filter'	=> 'AND entity_code="SC"' 
									     ),
												     
								'title' 		=> 'Template Name',										
								'search_key' 		=> 'id',													       
								'is_search_by_text' 	=> 0,
							),
						],
				
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=page_section__template','b_name'=>'Add Section Template' ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
					
								
				#export data
				
				
                            
                            );
	

    
?>