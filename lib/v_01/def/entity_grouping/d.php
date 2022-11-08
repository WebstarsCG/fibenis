<?PHP
	include(__DIR__."/core/d.php");
	
	$D_SERIES['title'] = 'Core Entity Grouping';
	
	// is lib
	$D_SERIES['key_filter'].= " AND get_eav_addon_bool(id,'GPIL')=1";
?>