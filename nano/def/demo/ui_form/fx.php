<?PHP
    
        include_once($LIB_PATH."/inc/lib/f_addon.php");
			    
	$F_SERIES	=	array(
				   
				    'title'	=>'Form',
				    
				    'gx'=>1,
				    
				    #Table field
			
				    'data'	=>   array(),
					
				    'table_name'    => 'entity_child',
				    
				    'key_id'        => 'id',
				    
				    #'is_user_id'       => 'created_by',
								    
				    'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?dx=demo__ui_form', 'BACK_NAME'=>'Back'),
				    
				    'prime_index'   => 2,
				    
				    'form_layout'   => 'form_100',
				    
			
				    
				   
				    
			    );
	
		$default_addon = 'FT';
			
		$F_SERIES['deafult_value']    = array('entity_code' => "'$default_addon'");
		
		@$F_SERIES['temp']=f_addon(['g'		   => $G,
					    'rdsql'		   => $rdsql,
					    'field_label'      => 'ln',
					    'hide_addon_tab'   => 1,
					    'f_series'     	   => ['data'=>$F_SERIES['data']],
					    'default_addon'	   => json_encode(['en'=>$default_addon])	
				    ]);
			
		$F_SERIES['data']=$F_SERIES['temp']['data'];
		
	
		
		
		
	
?>
