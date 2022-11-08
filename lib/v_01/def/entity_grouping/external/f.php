<?PHP
	include(get_lib_path()."/def/entity_grouping/core/f.php");
	$F_SERIES['title'] = 'External Entity Grouping';
	
	// entities
	$F_SERIES['data']['_ET']['option_id_name']=$G->get_id_name('entity','code,sn',' WHERE is_lib=0 ORDER BY sn ');
	
	// lib
	$F_SERIES['data']['_IL']['attr']['value']=0;	
	
?>