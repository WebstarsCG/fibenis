<?PHP
    
        include_once($LIB_PATH."/inc/lib/f_addon.php");
			    
	$F_SERIES	=	array(
				   
				    'title'	=>'Form',
				    
				    'gx'=>1,
				    
				    #Table field
			
				    'data'	=>   array(),
					
				    'table_name'    => 'entity_child',
				    
				    'key_id'        => 'id',
				    
				    'is_user_id'       => 'created_by',
								    
				    'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?dx=programme', 'BACK_NAME'=>'Back'),
				    
				    'prime_index'   => 2,
				    
				    'form_layout'   => 'form_100',
				    
				    'js'=> ['is_top'=>1, 'top_js'=>"def/cbmi/fx"], 
				    
				    'after_add_update'	=>1,
				    
				    'session_off'     =>0, 
				    
				    'divider' => 'accordion', 
				    
				    'page_code'	=> 'CBMI',
				    
				    'button_name'	=> 'Submit Form',
				    
				    'is_save_form'=>1,
				    
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
		
		$F_SERIES['header'] = array('header_content'=>'<div class="col-md-12 pad_lr align_LM">&nbsp;</div>
					                      <div><h4 class="pad_10_t">FORM using UI</h4></div>
					                      <div class="col-md-12 pad_lr align_LM">&nbsp;</div>',
							      'header_style'=>'col-md-12 align_CM row');
		
		
		
	
?>
