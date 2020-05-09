<?php	
			
		# Query function                
		
		include($LIB_PATH."/inc/lib/".get_config('db_engine').".php");		
		
		# Template library file for accessing the template
		
		include($LIB_PATH."template/template.php");				
				
		#general function
		
		include($LIB_PATH."/inc/lib/general.php");
		
		#session file
		
		include($LIB_PATH."/inc/lib/s_gate.php");
		
		# mailer
		
		include($LIB_PATH."/comp/PHPMailer/smtp.php");
		
		# db customization
		
		include($LIB_PATH."/inc/lib/dbh_customization.php");
		
		# filter
		
		include($LIB_PATH."/inc/lib/filter.php");
		
		list($USER_ID,$USER_NAME,$USER_EMAIL,$PASS_ID,$USER_ROLE ) = $SG->get_user_detail();
		
		#
		
		$USER_COMM_KEY =  @$_SESSION['COMM_KEY'];
		
                //
		//$split_prm = explode(',',$USER_PERMISSION);
		//	
		//for($prm_i = 0; $prm_i< count($split_prm); $prm_i++){
		//		
		//		$_SESSION[$split_prm[$prm_i]] = $split_prm[$prm_i];
		//}
		
		
		
		
?>