<?PHP
	
	list($page_id,$page_code,$page_addon,$page_coach_code)    = explode('[C]',$G->decrypt($_GET['req'],
									          $_GET['trans_key']));			
	$_GET['key']    = $page_id;
	 
        $T_SERIES       =   array(
		
                                'table'		=> 'entity_child',
				 
				'data'		=>  array(						
								'detail'=>array('field' => "get_eav_addon_text(id,'ECDT')"),
								
													
								'text'=>array(
										'field' => "get_exav_addon_varchar(id,'TEXT')",
									),	    
									    
								'text_area'=>array(
										    'field' => "get_exav_addon_text(id,'TEAR')",
										),
								'text_area_editer'=>array(
										    'field' => "get_exav_addon_text(id,'TEED')",
										),
								
								'toogle_switch'=>array(
										    'field' => "get_exav_addon_text(id,'TOSW')",
										),
								
								'number'=>array(
										    'field' => "get_exav_addon_num(id,'NUMB')",
										),
								'twin_box'=>array(
										    'field' => "get_exav_addon_decimal(id,'TWBX')",
										),
								
								
							),	
				
				
				'key_id' 	=> 'id',
				
				'key_filter'	=> '',
				
				'show_query'	=> 1,
				  
                                'template'      => dirname(__FILE__).'/t.html',
				
				
				// saving the output
				
				'save_as'=> array(
						
						array('type'		=> 'html',
						      'file_name'	=> $page_code,
						      'path'		=> "terminal/$page_coach_code/content/")
						  
				)

                        );
?>