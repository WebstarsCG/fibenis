<?PHP
		ini_set('display_errors', 1);
		
		ini_set('display_startup_errors', 1);
		
		error_reporting(E_ALL);
		
		use GuzzleHttp\Client;
				
		use GuzzleHttp\Query;
		
 		include("YfSLT9CRm55cBPGH.php");
		
		$P_V['lib_path']      =  get_lib_path();
		
		$LIB_PATH             =  $P_V['lib_path'];		
			
		include($LIB_PATH.'/inc/lib/header_wo_template.php');
		
		# lwp - guzzle lib
		
		$lwp_lib = $LIB_PATH.'/comp/guzzle_rest/vendor/autoload.php';
		
		require_once $lwp_lib ;
				
		$lwp = new Client([
		     // You can set any number of default request options.
		     'timeout'  => 2.0,
		]);
				
		@$session_off = 0;
	
		
		# actions
		
		$ROUTER_ACTION['RCPC']=function($param){
				
				
				
				$page_id_list = $param['get']['page_id_list'];				
				
				$page_result=$param['rdsql']->exec_query("SELECT code,addon,sn FROM entity_child WHERE id IN($page_id_list) AND entity_code='PG'","0");
				
				$recreated_pages = [];
				
				while($row=$param['rdsql']->data_fetch_object($page_result)){
						
						$script_name= $_SERVER["SCRIPT_NAME"];
						
						$script_name=str_replace("router.php","index.php",$script_name);
						  
						$req = $param['lwp']->GET($_SERVER["HTTP_HOST"].$script_name,
										['query'=>['t_series'=>$row->addon,
											   'key'     =>$row->code
											   ]
										]
									    );	
						
						array_push($recreated_pages,$row->sn);
						
				} // each page
				
				$result=array("status"=>1,
					      "recreated_pages"=>implode('<br>',$recreated_pages)
					      );
				
				return json_encode($result);
		}; # end
		
		
		if(@$_GET['action']){
				
		   # path
		   		   
		   $temp_route =  $LIB_PATH.'/inc/'.@$_GET['series'].'.php';
		   
				if(is_file($temp_route)){
					     
					     include($temp_route);
					     
				} # is file
				
				if(@$ROUTER_ACTION[@$_GET['action']]){
					     
					     echo $ROUTER_ACTION['RCPC'](array('rdsql'=>$rdsql,
									  'g'       => $G,
									  'get'     => $_GET,
									  'user_id' => $USER_ID,
									  'lwp'     => $lwp,
							     ));
				} # if
		   
		   
		
		} # action
		
		
		
		
		
		
		
		
		//if( ($_GET['action'] == 'RCPC') &&
		//    ($USER_ID)){
		//		
		//		
		//		
		//		
		//		
		//						
		//} # end
		
								
		//# inline update
		//
		//if( ($_GET['action'] == 'ECIU') && ($USER_ID)){
		//		
		//		$inline_param     = json_decode($_GET['param']);
		//		
		//		$inline_value     = $_GET['sv'];
		//		
		//		//echo "UPDATE
		//		//			entity_child
		//		//		   SET
		//		//			detail='$inline_value'
		//		//		   WHERE
		//		//			id=$inline_param->id AND
		//		//			md5(sn)='$inline_param->key'
		//		//		   ";
		//						
		//		$rdsql->exec_query("UPDATE
		//					entity_child
		//				   SET
		//					detail='$inline_value'
		//				   WHERE
		//					id=$inline_param->id AND
		//					md5(sn)='$inline_param->key'
		//				   ",'0');
		//		
		//		# one column
		//		
		//		echo $G->get_one_columm(array('table'        => 'entity_child',
		//					      'field'        => 'count(*)',
		//					      'manipulation' => "WHERE
		//									id=$inline_param->id AND
		//									md5(sn)='$inline_param->key'"
		//				));
		//
		//} # end
		
		
		//////////////////////////////////////////////////////////////////////////////
		
	
	
?>