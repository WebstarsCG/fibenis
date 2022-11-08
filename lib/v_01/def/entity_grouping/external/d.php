<?PHP
	include(get_lib_path()."/def/entity_grouping/core/d.php");
	
	$D_SERIES['title'] = 'External Entity Grouping';
	
	$D_SERIES['key_filter'].= " AND get_eav_addon_bool(id,'GPIL')=0";
?>