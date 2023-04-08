<?PHP
       
	 
        $A_SERIES       =   array(
		
		
					'CODE'=>function($param){
						
						//print_r($param);
								
						if($param['user_id']){ 
						
								$lv = ['coach_code'=>''];
								
								$lv['coach_code'] = $param['data'];
								
								$lv['is_exist']=$param['G']->get_one_column(['table'=>'entity_child',
																				'field'=>"id",
																				'manipulation'=> " WHERE entity_code='CH' AND get_eav_addon_vc128uniq(id,'CHCD')='$lv[coach_code]'"
																				]);
								
								
									
							return ($lv['is_exist'])?1:0;
							
						}else{
							
							return 0;			
						}
						
						}, // end
					);
	
	
	
	
	
    
?>