<?PHP
			
        $LAYOUT	    	= 'layout_basic';
               
        $D_SERIES       =   array(
                                   'title'=>'Text Types',
                                   'gx' => 1,
				    
                                    #table data
                                    'data'=> array( 		
							
													2=>array('th'		=>'Alphabet',
															'field' 	=>"get_exav_addon_text(entity_child.id,'TTTXAL')",
															'td_attr' 	=> ' class="align_LM" width="7%"',
															'is_sort' 	=> 1,	
															),
														
													3=>array('th'		=>'Number',
															'field' 	=>"get_exav_addon_varchar(entity_child.id,'TTTXNM')",
															'td_attr' 	=> ' class="align_LM" width="7%"',
															'is_sort' 	=> 1,	
															),
															
													4=>array('th'		=>'Decimal',
															'field' 	=>"get_exav_addon_decimal_2(entity_child.id,'TTTXDL')",
															'td_attr' 	=> ' class="align_LM" width="7%"',
															'is_sort' 	=> 1,	
															),
													
													5=>array('th'		=>'Alphabet and externals',
															'field' 	=>"get_exav_addon_text(entity_child.id,'TTTXAE')",
															'td_attr' 	=> ' class="align_LM" width="7%"',
															'is_sort' 	=> 1,	
															),
															
													6=>array('th'		=>'Value between',
															'field' 	=>"get_exav_addon_text(entity_child.id,'TTTXVB')",
															'td_attr' 	=> ' class="align_LM" width="7%"',
															'is_sort' 	=> 1,	
															),
												
													7=>array('th'		=>'Minimal digits',
															'field' 	=>"get_exav_addon_varchar(entity_child.id,'TTTXMD')",
															'td_attr' 	=> ' class="align_LM" width="10%"',
															'is_sort' 	=> 1,	
															),
													
													8=>array('th'		=>'Equal digits',
															'field' 	=>"get_exav_addon_varchar(entity_child.id,'TTTXED')",
															'td_attr' 	=> ' class="align_LM" width="10%"',
															'is_sort' 	=> 1,	
															),
													
													9=>array('th'		=>'Limted length digits',
															'field' 	=>"get_exav_addon_varchar(entity_child.id,'TTTXLD')",
															'td_attr' 	=> ' class="align_LM" width="10%"',
															'is_sort' 	=> 1,	
															),
													
													10=>array('th'=>'Updated On',
															 'field' =>"date_format(timestamp_punch,'%d-%b-%Y %H:%I') ",
															 'td_attr' => ' class="no_wrap clr_gray_a align_LM txt_size_11" width="7%"',
															 'is_sort' => 1,
															),
												),
								
					'table_name' =>'entity_child',
					'key_id'    =>'id',
					
					# Default Additional Column
					'is_user_id'    => 'user_id',
				    'key_filter'	=> "AND entity_code = 'TT'",
					#check_field
                    'action'        => array('is_action' => 0, 'is_edit' => 1, 'is_view' => 0),								
					'add_button'    => array( 'is_add' =>1,'page_link'=>'fx=test__text', 'b_name' => 'Add' ),
					'del_permission'=> array('able_del'=>1,'user_flage'=>0), 
					'date_filter'   => array( 'is_date_filter' =>1,'date_field' =>  'timestamp_punch'),	
					#export data
					'export_csv'   	=> array('is_export_file' => 0, 'button_name'=>'Create CSV','csv_file_name' => 'csv/log_'.time().'.csv'  ),
					'show_query'=>0,
					);
    		    
?>