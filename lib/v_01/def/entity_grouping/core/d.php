<?PHP
		
	
        $D_SERIES       =   array(
									'title'=>'Entity Grouping',
                                    
                                    'gx'	=> 1,
				    
									#table data
                                    
                                    'data'=> array(
												
										1=>array(	'th'=>'Group Name',
													'field'=>"get_eav_addon_varchar(id,'ECSN')",								   
													'td_attr' => ' class="label_father align_LM" width="15%"',
													'is_sort' =>1
										),
												
										2=>array('th'=>'Code',
												 
													'field'=>"get_eav_addon_vc128uniq (id,'ECCD')",
																			   
													'td_attr' => ' class="label_father align_LM" width=10%"',
											
													'is_sort' =>1
										),
																				
										3=>array('th'=>'Entities',
                                                                     
			   'field'	=> " (SELECT ".$DC->group_concat('(SELECT sn FROM entity WHERE code=eav_addon_entity_code.entity_code)')." FROM eav_addon_entity_code WHERE parent_id = entity_child.id AND ea_code='GPEN' ) ",
													'td_attr' => ' class="label_father align_LM" width=25%"',
								    
													'js_call' => 'tip_from_list'
												)
					
							),
				    
                                    
				    'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
                                       
				    'order_by'   =>'ORDER BY id ASC ' ,
				    
				   
				    
				    #Search
				
					'search'=> 	array(
							  
							array(  'data'  =>array('table_name' 	=> 'entity_child',
										'field_id'	=> "id",
										'field_name' 	=> "get_eav_addon_varchar(id,'ECSN')",
										  'filter'	=> 'AND entity_code="GP"' 
									 ),
							      
								'title' 		=> 'Name',										
								'search_key' 		=> "id",													       
								'is_search_by_text' 	=> 0, //( For Text search case)	      
							),
								
						),
						
							
				
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
									
                                
                                    # File Include
                                
                                
         			
				'key_filter'	=>' AND entity_code ="GP"',
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
											
								
					'add_button' => array( 'is_add' =>1 ),
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
					'date_filter'  => array( 'is_date_filter' =>0,'date_field' =>  ''),	
								
				#export data
				
				'export_csv'   => array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
				
                            
		);
	
    
?>	
