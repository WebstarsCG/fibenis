<?PHP
       
        
	$A_SERIES =   array(
			
	
			'SECT'=>function($param){
					
				$data = get_object_vars(json_decode($param['data']));
		
				if($param['user_id']){ 
		
					global $lwp;
					
					$url   		= get_config('domain_name');
					
					$lwp_res = 	$lwp->GET($url, ['query'=>['t' => 'page_section',
										   'key'=>$data['key_id'],
										]
									]
							);
					
					return 1;
					
				}else{
					
					return 0;			
				}
					
					
			}, // end
				

		    );
	
	
	
	
	
    
?>