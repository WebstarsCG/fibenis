<?PHP

    $D_SERIES	=   array(
	
			'title'	    => 'Page',
									
			# table
			'table_name'    => 'demo_page_info',
			
			# columns
			'data'	=>  array( 
						'1' =>[ 'th'		=> 'Title',
							'field' 	=> 'title',
							'attr'		=> ['class' => ' txt_size_14 b ',
									    'width'  => '20%'],
							'is_sort'	=> 1],
					   
						'2' =>['th'		=> 'Content',                                                                
							    'field' 	=> 'content'],
					),
			
			'key_id'        => 'id',    				
			'is_user_id'   	=> 'user_id',			    
			
			# controls
			'action'        => array('is_edit' => 1),									
			'add_button'    => array('is_add'  => 1,'page_link'=>'fx=demo__page'),						
			'del_permission'=> array('able_del' =>1), 
		);
	
?>