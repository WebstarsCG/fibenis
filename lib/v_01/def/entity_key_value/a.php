<?PHP
       
	 
        $A_SERIES       =   array(
		
		
					'EKVU'=>function($param){
						
								
						                if($param['user_id']){ 
						
									$inline_param     = json_decode($param['data']);
									
									$inline_value     = $param['sv'];									
													
									$param['rdsql']->exec_query("UPDATE
												entity_key_value
											   SET
												entity_value='$inline_value'
											   WHERE
												id=$inline_param->id",'0');
									
									# one column
									
									return $param['G']->get_one_columm(array('table'        => 'entity_child',
												      'field'        => 'count(*)',
												      'manipulation' => "WHERE
																id=$inline_param->id"
											));
									
								}else{
									
									return 0;			
								}
						
						
					}, // end
					
         

                            );
	
	
	
	
	
    
?>