<?PHP

	$temp		  = [];	
		
	$temp['param']    = json_decode($G->decrypt($_GET['req'],$_GET['trans_key']),true);
	
	$_GET['key']      = $temp['param']['key'];
	
	$temp['param']['field'] = $G->get_one_column([	'field'       => "ea_value",
							'table'       => 'eav_addon_text',
							'manipulation'=> " WHERE ea_code='ECDT' AND parent_id = $_GET[key]"]);
	
	
	$temp['param']['field'] = json_decode(stripcslashes($temp['param']['field']));
	
	$T_SERIES       =   array(
		
                                'table'		=> 'entity_child',
				 
				'data'		=>  array(),	
				
				'key_id' 	=> 'id',
				
				'key_filter'	=> '',
				
				'show_query'	=> 1,
				  
				'template'      => get_config('theme_path').'/'.$temp['param']['theme'].'/blend/source/'.$temp['param']['file_name'].'.less',
				
				'save_as'=> array(
						
						array('type'		=> 'less',
						      'file_name'	=> $temp['param']['page_code'],
						      'path'		=> get_config('theme_path').'/'.$temp['param']['theme'].'/blend/')
						  
				)

                        );
	
	foreach($temp['param']['field'] as $key => $value){
		
		if(!empty($value[1])){
		
		$T_SERIES['data'][$value[0]] = ['field'=> "'$value[1]'"];
		
		}
	}
	
?>