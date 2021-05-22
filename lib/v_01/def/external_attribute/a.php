<?PHP
       
	 
        $A_SERIES       =   array(
		
					
				    # active inactive					
				    
				    'ECBIA'=>function($param){
					    
							    
							    if($param['user_id']){ 
					    
								    $inline_param     = json_decode($param['data']);
								    
								        if($inline_param->ia==1){
										    $action  = ' is_active =1 ';
										    $message = 'Successfully Updated';																		
									}else{
										    $action  = ' is_active =0 ';
										    $message = 'Successfully Updated';
									}
																				    
								    $param['rdsql']->exec_query("UPDATE
												     entity_child_base
												 SET
												     $action
												 WHERE
												     id IN ($inline_param->ids) 
												   ",'0');
								    
								    # one column
								    
								    return $message;
								    
							    }else{
								    
								    return 0;			
							    }
				    }, // end
					
					
					'ELOU'=>function($param){
					    
							    if($param['user_id']){ 
					    
								    $inline_param     = json_decode($param['data']);
																				    
								   $param['rdsql']->exec_query("UPDATE
														 entity_child_base
													 SET
														 line_order=$param[sv]
													 WHERE
														 id=$inline_param->id 
													   ",'0');
								     
								    # one column
									return 1;
						
							    }else{
								    
								    return 0;			
							    }
				    }, // end
         

		);
	
	
	
	
	
    
?>