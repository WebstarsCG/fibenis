<?PHP
				
	include("plugin/inc/config.php");	
	include("fE7zRhHqYfSLT9CRm55cBPGHjAGuhqhhjKGSZrB.php");
	
	# config        
	$CRm55cBPGH = get_temp_config($temp_config);
	
	set_session_config();
	
	$DB_ENGINE 		= get_config('db_engine');	
    $get_db_conn 	= get_config('db_engine').'_connection';	
    $db_conn_info 	= $get_db_conn();	
	$db_conn_close  = $get_db_conn.'_close';

?>