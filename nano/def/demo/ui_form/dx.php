<?PHP

    $D_SERIES	=   array(
	
			'title'	    => 'Page',
									
			# table
			'table_name'    => 'entity_child',
			
			# columns
			'data'	=>  array( 
						'1' =>[ 'th'		=> "Text",
							'field' 	=> "get_exav_addon_varchar(id,'FTTT')",
							'attr'		=> ['class' => ' txt_size_14 b ',
									    'width'  => '20%'],
							'is_sort'	=> 1],
					   
					),
			
			'key_id'        => 'id',    				
			
			'key_filter'    => " AND entity_code='FT' ",
			
			# controls
			'action'        => array('is_edit' => 1),									
			'add'  		=> array('is_add'  => 1,'page_link'=>'fx=demo__ui_form'),						
			'del_permission'=> array('able_del' =>1), 
		);
	
?>