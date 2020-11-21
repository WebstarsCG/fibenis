<?PHP

    $T_SERIES	=   array(
	
			'table'		=>	'demo',
				 
			'data'  	=>	array(						
							'text'        => array('field' => 'text_flat'),
							'text_area'   => array('field' => 'text_area'),
							
							'grid_info'=>array('field' => 'fiben_table', // table field name
                               
										    // counter match to the index 
										    // 1 will fetch the name from index 0       
						     
										   'data'  => array( '1'=>array('key'=>'Name'),
														 '2'=>array('key'=>'DoB'))
									     )
						),	
			
			'key_id' 	=> 'id',
			
			'template'       => dirname(__FILE__)."/tx.html",
			
			// save data 
			'save_as'	=> array(
					
						array('type'	 => 'html',
						      'file_name'=> 'sample_page',
						      'path'   	 => dirname(__FILE__)),
						)
		);
	
?>