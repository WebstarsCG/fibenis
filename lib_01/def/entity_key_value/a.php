<?PHP
       
	 
        $A_SERIES       =   array(
		
		
					
					
					
					'ECAI'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
																					
									$param['rdsql']->exec_query("UPDATE
												entity_key_value
											   SET
												entity_value=$inline_param->fv
											   WHERE
												id=$inline_param->id 
											   ",'0');
									
									# one column
									
									return $param['data'];
									
								}else{
									
									return 0;			
								}
						
						
					} // end
         

                            );
	
	
	
	
	
    
?>