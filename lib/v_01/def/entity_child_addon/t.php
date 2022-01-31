<?PHP
	       
	include("$LIB_PATH/inc/lib/t_addon.php");	
		   
		   
	 $T_SERIES	=   array(
	
			'table'		=>	'entity_child',
				 
			'data'  	=>	array(),	
			
			'key_id' 	=> 'id',
			//'key_filter'=> " AND entity_code='FT'",
			
			'show_query'=>0,
			
			
			// save data 
			'save_as'	=> array(
					
						array('type'	 => 'html',
						      'file_name'=> 'view',
						      'path'   	 => dirname(__FILE__)),
						)
		);
		
		
	if(@$_GET['default_addon']){	
	
<<<<<<< HEAD
		$default_addon = $_GET['default_addon'];
		
		$T_SERIES['temp'] = t_addon(['default_addon'=>['entity_code'=>$_GET['default_addon']],
									  't_series'     => ['data'=>$T_SERIES['data']],
									  'rdsql'        => $rdsql
							]);
							
		$T_SERIES['data'] = $T_SERIES['temp']['data'];
		
		$T_SERIES['key_filter'] = " AND entity_code='$default_addon'";	
		
		$T_SERIES['template_content'] =  "<TMPL_LOOP DATA_INFO>".$T_SERIES['temp']['template_content']."</TMPL_LOOP>";
										
	}
=======
	$T_SERIES['key_filter'] = $T_SERIES['temp']['key_filter'];
	
	$T_SERIES['template_content'] =  "<TMPL_LOOP DATA_INFO>".$T_SERIES['temp']['template_content']."</TMPL_LOOP>";

>>>>>>> 2fe97dd8a7804845670f74f0a1f65463e1e785cd

	
?>