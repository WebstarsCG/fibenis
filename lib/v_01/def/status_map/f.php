<?PHP


	$F_SERIES =array('title'=>'Status Map',
			 
			 'data'=>array('1'=>array('field_name'=>'Entity Name',
									  
									  'field_id'=>'entity_code',
									  
									  'type'=>'option',
									  
									  'attr'=> ['class'=>'w_300'],
									  'avoid_default_option'=>1,
									  'is_mandatory'=>1,
									  ),
						   
						   '2'=>array('field_name'=>'Start Status',
									  
									  'field_id'=>'status_code_start',
									  
									  'type'=>'option',
									  'attr'=> ['class'=>'w_300'],
									    'option_default'=> array('label'=>'Select Start Status','value'=>'NANA'),
									  
									  'is_mandatory'=>1
									  
									  ),
						   
						   '3'=>array('field_name'=>'End Status',									  
									  'field_id'=>'status_code_end',
									  'option_default'=> array('label'=>'Select End Status','value'=>'NANA'),
									  
									  'type'=>'option',
									  'attr'=> ['class'=>'w_300'],
									  
									  'is_mandatory'=>1
									  
									  ),
						  
						  ),
			 
			 'table_name'=>'status_map',
			 
			 'key_id'    =>'id',
			 
			 'is_user_id' =>'user_id',
			 
			 'back_to'  =>array('is_back_button'=>1),
			 
			 'prime_index'=>1,
			 
			 'is_cc'=>1
			 
			);
			
			
	if($_GET['default_addon']){
		
		$F_SERIES['temp']['da'] = @$_GET['default_addon'];
		
		 $F_SERIES['temp']['is_da'] = $G->get_one_column(['table'=>'entity','field'=>'code',
														 'manipulation'=>" WHERE code='".$F_SERIES['temp']['da']."'"]);
		
		if($F_SERIES['temp']['is_da']==$F_SERIES['temp']['da']){
			
			$F_SERIES['data']['1']['option_data']	= $G->option_builder('entity',
															 'code,sn',
															 "where code ='".$F_SERIES['temp']['da'] ."' order by sn ASC");
	
		
		
			$F_SERIES['temp']['attr'] = $G->option_builder('entity_child_base',
																		  'token,sn',
																		  "WHERE entity_code='".@$F_SERIES['temp']['da']."' order by sn ASC");
			
			$F_SERIES['data'][2]['option_data']  = $F_SERIES['temp']['attr']; 
			
			$F_SERIES['data'][3]['option_data']  = $F_SERIES['temp']['attr']; 
			
			// customization
			$F_SERIES['back_to']['is_back_button'] = 1;
			$F_SERIES['back_to']['back_menu_off']=@$_GET['menu_off'];
			$F_SERIES['back_to']['back_default_addon']=$F_SERIES['temp']['da'];
	
			$F_SERIES['add_button']['is_add'] = 0;
			$LAYOUT	    = 'layout_full';
                
                // line order & not update
		
		}else{
				http_response_code(404);
				exit();
		}
		
	} // end
     
     
?>