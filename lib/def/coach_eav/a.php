<?PHP
       
	 
        $A_SERIES       =   array(
		
		
					'GENC'=>function($param){
						
								
						                if($param['user_id']){ 
						
									global $lwp;
									
									$inline_param   = json_decode($param['data'],true);
									
									//echo $inline_param['coach_code'];
									
									$url   		= get_config('domain_name');
									
									//echo print_r($lwp);
									
									$lwp_res = 	$lwp->GET($url, ['query'=>['t' => 'mop_v2_eav',
													           'key'=>$inline_param['coach_code'],
														   'user_id'=> $param['user_id']
													        ]
												        ]
											);
									
									//echo $lwp_res->getStatusCode().'-'.$_SERVER["HTTP_HOST"];
									
									//echo print_r($lwp_res);
									
									return 1;
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
         

                            );
	
	
	
	
	
    
?>