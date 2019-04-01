<?PHP
    
    $F_SERIES =array('title'=>'Entity Attribute',
                     
                     'data'=>array('1'=>array('field_name'=>'Entity Name',
                                              
                                              'field_id'=>'entity_code',
                                              
                                              'type'=>'option',
                                              
                                              'option_data'=>$G->option_builder('entity','code,sn','WHERE is_lib=1 order by sn ASC'),
                                              
                                              'is_mandatory'=>1,
                                              
                                              'avoid_default_option'=>0,
                                              
                                              'input_html' => 'class=w_60',
                                              
                                              ),
                                   
                                   '5'=>array('field_name'=>'Attribute Code',
                                              
                                              'field_id'=>'code',
                                              
                                              'type'=>'text',
                                              
                                              'is_mandatory'=>0,
                                              
                                              'input_html'=>' maxlength=4 class=w_50 onchange="check_code(this);"',
					      
					      'allow'	  => 'w4',
			    
                                   	      'hint'	  => 'Four Letter Code',
                                              
                                              ),
                                   
                                   '2'=>array('field_name'=>'Short Name',
                                              
                                              'field_id'=>'sn',
                                              
                                              'type'=>'text',
					      
					      'input_html'=>'class="w_200"',
                                                               
                                                'allow'     => 'x50',
                                              
                                              'is_mandatory'=>1
                                              
                                              ),
                                   
                                   '3'=>array('field_name'=>'Long Name',
                                              
                                              'field_id'=>'ln',
                                              
                                              'type'=>'text',
                                              
					      'allow'     => 'x1000',
                                                                
                                            'input_html'=>'class="w_200"',
					      
                                              'is_mandatory'=>0
                                              
                                              ),
                                   
                                   '4'=>array('field_name'=>'Line Order',
                                              
                                              'field_id'=>'line_order',
                                              
                                              'type'=>'text',
                                              
                                              'is_mandatory'=>1,
                                              
                                              'input_html'=>' class=w_50 ',
					      
					      'allow'     => 'd5[.]',
                                              
                                              ),
                                   
                                   
                                   
                                  ),
                     
                     'table_name'=>'entity_attribute',
                     
                     'key_id'    =>'id',
		     
		     'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/entity_attribute/f'],
				
                     'is_user_id' =>'user_id',
                     
                     'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_attribute', 'b_name' => 'Add Entity Attribute' ),
                     
                     'back_to'  =>array('is_back_button'=>1,'back_link'=>'?d=entity_attribute', 'BACK_NAME'=>'Back'),
                     
                     'message'=> " concat((SELECT sn FROM entity WHERE code=entity_code),' - ',sn) ",
                     
                     'page_code'=>'FETA'
                                   
                    );
    
    
    if(isset($_GET['default_addon'])){  
	
		$default_addon = $_GET['default_addon'];
		$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn',"WHERE code = (SELECT code FROM entity WHERE id = $default_addon)");
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
		
		$LAYOUT	    = 'layout_full';
	}
     
?>