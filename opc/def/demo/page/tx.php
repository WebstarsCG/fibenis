<?PHP

    $T_SERIES	=   array(
	
			'table'		=>	'demo_page_info',
				 
			'data'  	=>	array(						
							'page_title'  => array('field' => 'title'),
							'page_content'=> array('field' => 'content'),
						),	
			
			'key_id' 	=> 'id',
			
			'template'       => dirname(__FILE__)."/tx.html",
			
			// save data 
			'save_as'	=> array(
					
						array('type'	 => 'html',
						      'file_name'=> 'sample_page',
						      'path'   	 => "terminal/test/content/"),
						)
		);
	
?>