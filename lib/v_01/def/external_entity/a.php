<?PHP
       
	 $A_SERIES       =   array(
		
					'ENCO'=>function($param){
                                            
                                                $data = $param['data'];
                                                
                                                $result = $param['rdsql']->exec_query("SELECT count(*) as count FROM entity
                                                                                      WHERE code = '$data' ",
                                                                                      "Check Query");
                                                
                                                $temp = $param['rdsql']->data_fetch_object($result);
                                                
                                                return $temp->count;
                                                
					},
                                )
?>