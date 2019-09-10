<?PHP
       
	 $A_SERIES       =   array(
		
					'CODE'=>function($param){
                                            
                                                $data = $param['data'];
                                                
                                                $result = $param['rdsql']->exec_query("SELECT count(*) as count FROM entity_attribute
                                                                                      WHERE code = '$data' ",
                                                                                      "Check Query");
                                                
                                                $temp = $param['rdsql']->data_fetch_object($result);
                                                
                                                return $temp->count;
                                                
					},
					
                                )
?>