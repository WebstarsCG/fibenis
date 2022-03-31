<?PHP
		
		$key			=	$_GET['key'];
		$wm             =   @$_GET['wm']; //a or w
		
		$key_code		=   get_csv_to_quoted_text($key);
	 
	
		$T_SERIES       = array(
								
									
								'table'	=>	'entity',
								 
								'data'=>	array(
													'code'=>array('field' => 'code'),
													'name'=>array('field' => 'sn'),
													'mode'=>array('field' => "'".$wm."'"),
													
													'ecb_info'=>array(
															'is_child_addon' =>1,
															
															
															'child_data'   =>[																
																			'1'=>array('key'=>'token','field'=>'token'),
																			'2'=>array('key'=>'sn','field'=>'sn'), 
																			'3'=>array('key'=>'ln','field'=>'ln'),
																			'5'=>array('key'=>'note','field'=>'note'),
																			'6'=>array('key'=>'dna_code','field'=>'dna_code'),
																			'7'=>array('key'=>'line_order','field'=>'line_order'),
																	

																		],
									
																			'table'		=> ' entity_child_base',												
														'key_filter'	=> " AND entity_code = '[[parent.code]]' AND dna_code <> 'EBAT' ",									
																			'show_query'	=> 1		
														),
													
												),	
								  
								
								'key_id' => '',
								

								'key_filter'=> " AND code IN ($key_code)",
								
								'show_query'=>1,
								
								'template'       => dirname(__FILE__).'/t.html',
								
								
								// save data 
								'save_as'=> array(
										
													array('type'	 => 'xml',
																'file_name'=>"csv/entity_child_base_export_".str_replace(',','_',$key)."_".time(),
															'path'	 =>  '.'
													
															)	
												)

);

	function get_csv_to_quoted_text($key){
		  
			$key			=	$_GET['key'];
			
			return implode(",",array_map('array_to_string',explode(',',$key)));
		
			
	  }
	  
	  function array_to_string($a){
			
		return "'$a'";
	  }		
        	    
?>