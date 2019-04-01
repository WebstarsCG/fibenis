<?PHP
	
	list($page_id,$page_code,$page_addon,$page_coach_code)    = explode('[C]',$G->decrypt($_GET['req'],
									                      $_GET['trans_key']));			
	$_GET['key']    = $page_id;
	 
        $T_SERIES       =   array(
		
                                'table'		=> 'entity_child',
				 
				'data'		=>  array(						
								'detail'=>array('field' => "get_eav_addon_text(id,'ECDT')",
										
											'filter_out'=>function($data_in){
												
													return  str_replace(['\r\n','\\'],['<br>',''],$data_in);
											}
										
										)
								
								
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