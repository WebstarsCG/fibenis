<?PHP
	
	$T_SERIES['temp']['param']    = json_decode($G->decrypt($_GET['req'],$_GET['trans_key']),true);
	
	$_GET['key']    = $T_SERIES['temp']['param']['key'];
	 
        $T_SERIES       =   array(
		
                                'table'		=> 'entity_child',
				 
				'data'		=>  array(						
								'content'=>array('field' => "get_eav_addon_text(id,'ECDT')")								
								
							),	
				
				
				'key_id' 	=> 'id',
				
				'key_filter'	=> '',
				
				'show_query'	=> 1,
				  
                                'template'      => dirname(__FILE__).'/t.css',
				
				// saving the output
				
				'save_as'=> array(
						
						array('type'		=> 'html',
						      'file_name'	=> $T_SERIES['temp']['param']['page_code'],
						      'path'		=> $T_SERIES['temp']['param']['blend_route'])
						  
				)

                        );
?>