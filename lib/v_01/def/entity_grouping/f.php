<?PHP
	include(__DIR__."/core/f.php");
	$F_SERIES['title'] = 'Core Entity Grouping';
	
	// entities
	$F_SERIES['data']['_ET']['option_id_name']=$G->get_id_name('entity','code,sn',' WHERE is_lib=1 ORDER BY sn ');
?>