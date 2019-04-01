<?PHP
		define("PAGE_CODE","EXT");
		
		//header('Location:index.php');
		
		$redirect = 'index.php';
		
		$SG->s_destroy($redirect);
		
		//set_system_log
		$param = array('user_id'=>$USER_ID,
			       
				'page_code'=>PAGE_CODE,
				
				'action_type'=>'View',
				
				'action'=>'Exit the application');
		
		$G->set_system_log($param);
				
?>