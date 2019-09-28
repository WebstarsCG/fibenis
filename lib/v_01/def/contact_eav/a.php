<?PHP
       
	 $A_SERIES       =   array(
		
					'MOBL'=>function($param){
                                            
                                                $data = $param['data'];
                                                
                                                $result = $param['rdsql']->exec_query("SELECT count(*) as count FROM eav_addon_varchar
                                                                                      WHERE ea_code= 'COMB' AND LOWER(ea_value) = LOWER('$data') ",
                                                                                      "Check Select Query");
                                                
                                                $temp = $param['rdsql']->data_fetch_object($result);
                                                
                                                return $temp->count;
                                                
					},
					
					'EMID'=>function($param){
                                            
                                                $data = $param['data'];
                                                
                                                $result = $param['rdsql']->exec_query("SELECT count(*) as count FROM eav_addon_varchar
                                                                                      WHERE ea_code= 'COEM' AND LOWER(ea_value) = LOWER('$data') ",
                                                                                      "Check Select Query");
                                                
                                                $temp = $param['rdsql']->data_fetch_object($result);
                                                
                                                return $temp->count;
                                                
					},
                                )
?>