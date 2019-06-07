<?PHP
                        
	     $F_SERIES	=	array(
				    
				    'title'	=>'Entity Child',
				    
				    # Table field
			
				    'data'	=>   array(
						       
						       
						       '1' =>array('field_name'=>'Code',
								   
								   'field_id'=>"ea_value",
								   
								   'type'=>'text',
								   
								   'is_mandatory'=>1,
								   
								   'child_table'         => 'eav_addon_vc128uniq', // child table 
								  
								   'parent_field_id'     => 'parent_id',         // parent field
											 
								   'child_attr_field_id' => 'ea_code',   	      // attribute code field
								
								   'child_attr_code'     => 'CHCD',
								   
								   'input_html'=>'onchange="check_code(this);"',
					      
								   
								//   'attr'		      => ['class'=>'w_200',
								//				      'onkeyup'=>"(function(from,to) {
								//						
								//				    		    to.value=from.value;
								//				    		  })(G.$('X1'),G.$('X4'));"
								//				  
								//				  ],
								 
								   ),
						       
				       
						       '2' =>array('field_name'=>'Name',
								   
								 'field_id'=>"ea_value",
								 
								 'type'=>'text',
								 
								 'is_mandatory'=>1,
								 
								 'child_table'         => 'eav_addon_varchar', // child table 
								 
								 'parent_field_id'     => 'parent_id',         // parent field
											 
								 'child_attr_field_id' => 'ea_code',   	      // attribute code field
								
								 'child_attr_code'     => 'ECSN', 
								   
								 'input_html'=>'class="w_150"'
								   
							),
						       
							'4'=>array(
								'field_name'          => 'Domain Name',                                                                
								
								'field_id'            => 'ea_value',				       
								
								'type' 	              => 'text',
								
								'is_mandatory'        => 1,
						
								'child_table'         => 'eav_addon_varchar', // child table 
								
								'parent_field_id'     => 'parent_id',         // parent field
											 
								'child_attr_field_id' => 'ea_code',   	      // attribute code field
								
								'child_attr_code'     => 'CHDN',          // attribute code
								 
							    ),	
						       
						      
				    ),
					
				    #Table Name
				    
				    'table_name'    => 'entity_child',
				    
				    #Primary Key
				    
				    'key_id'        => 'id',
				  				    
				    # Communication
								    
				    'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Entity child' ),
			 
				    'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=coach_eav', 'BACK_NAME'=>'Back'),
				    
				    'prime_index'   => 2,
				    
				    'default_fields' => array("entity_code" => "'CH'",),
				    
				    # File Include
				    'after_add_update'	=>1,
				    
			            'is_user_id' 	=>'user_id',
				    
				    'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/coach_eav/f'],
			
				    'page_code'	=> 'FECA',
				    
				    'show_update_query' => 0,
				    
				    'avoid_trans_key_direct' => 1,
				    
                                
			);
	     
	     
	    
	     
	     # after add update
	     
	     function after_add_update($key_id){
		 
			  global $rdsql,$USER_ID,$G;
		      
			  $lv = [];
			  
			  $lv['theme_child_query_data'] = [];
			  
			  $lv['coach_child_query_data'] = [];
			  
			  $lv['coach_code']            = $_POST['X1'];
			  
			  $lv['coach_code_hash']       = md5($lv['coach_code']);
			  
			  if(!$_POST['UPDATE']){
				       
				       $lv['coach_path']      =get_config('coach_path');		    
				       
				       $lv['coach_cache_path']=$lv['coach_path']."/$lv[coach_code]/cache/";
				       
				       mkdir($lv['coach_path']."/$lv[coach_code]",0755,true);
				       
				       mkdir($lv['coach_cache_path'],0755,true);
				       
				       mkdir($lv['coach_path']."/$lv[coach_code]/content",0755,true);
				       
				       mkdir($lv['coach_path']."/$lv[coach_code]/images",0755,true);
				       
				       $theme_content_file = fopen($lv['coach_cache_path']."/t.html","w") or die("Unable to open file!");		
				       
				       fclose($theme_content_file);
			      
			  } // end
			     
			  
	     } // end of after add update
?>
    