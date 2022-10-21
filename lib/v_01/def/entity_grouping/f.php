<?PHP
	include("core/f.php");
	
	$F_SERIES['data']['_ET']['option_id_name'] = $G->get_id_name('entity','code,sn',' WHERE is_lib=1 ORDER BY sn ');
?>