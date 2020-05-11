<?PHP

	$temp		 									 = [];	
		
	$temp['param']    = json_decode($G->decrypt($_GET['req'],$_GET['trans_key']),true);
	
	$_GET['key']      = $temp['param']['entity_code'];
	
	$T_SERIES         =   array(		
                                 'table'									=> 'entity',
				 
																																	'data'										=>  array('title'   => array('field'=>'sn'),
																																																											'entity_code'    => array('field'=>'code'), 
																																																											
																																																					),	
																																	
																																	'key_id' 							=> 'code',
																																	
																																	'key_filter'				=> '',
																																	
																																	'show_query'				=> 0,
																																			
																																	'template'      => dirname(__FILE__).'/t.html',
																																	
																																	'save_as'							=> array(																																			
																																																												array('type'		    => 'php',
																																																																		'file_name'	=> 'dx',
																																																																		'path'		    => $temp['param']['def_path'])
																																																				)
																							); // end
																									
?>