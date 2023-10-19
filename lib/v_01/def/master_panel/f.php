<?PHP
	include($LIB_PATH."def/entity_key_value/f.php");

	$F_SERIES['default_fields'] = array("entity_code"=>"'MP'");
	$F_SERIES['back_to']['back_link'] = '?d=master_panel';
	$F_SERIES['is_cc'] = 1;

	// unset fields	
	unset($F_SERIES['data'][1]);

	// after update 
	$F_SERIES['after_add_update'] = function($key_id){
			
		global $G,$COACH;
		// update ekv_session
		$G->setCEKV(@$_POST['X2'],'CH','ekv_session',$G->hashKeyGenerator('AA','ZZ'));

	};
	

?>