<?PHP

    //F_series definition:
                           
    $F_SERIES	=	array(
        
                                'gx'=>1,    
        
				#Desk Title
				
				'title'	=>'Entity',
				
				#Table field
                    
				'data'	=>   array(			
						   '1' => array( 'field_name'=> 'Code', 
                                                               
                                                                'field_id' => 'code',
                                                               
                                                                'type' => 'text',
                                                                
                                                                'hint'  => 'Four Letter Code',
                                                                
                                                                //'input_html'   => ' class="w_50" ',
                                                               
                                                                'is_mandatory'=>0,
                                                                
                                                                'allow'     => 'w4[1234567890]',
                                                                
                                                                'input_html'=>'class="w_50 txt_case_upper" onchange="check_en_code(this);"',
                                                                
                                                                ),
                                                   
                                                   '2' =>array( 'field_name'=> 'Short Name Please',
                                                               
                                                               'field_id' => 'sn',
                                                               
                                                               'type' => 'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_200"',
                                                               
                                                               'allow'     => 'x50',
                                                                
                                                               'hint'   => 'Give Entity Name',
                                                               
                                                               'attr'   => ['class'=>'w_300']
                                                               
                                                               ),
				   
//						   '3' =>array('field_name'=>'Long Name',
//                                                               
//                                                               'field_id'=>'ln',
//                                                               
//                                                               'type'=>'textarea',
//                                                               
//                                                                'allow'     => 'x1000',
//                                                                
//                                                                'input_html'=>'class="w_300"',
//                                                               
//                                                               'is_mandatory'=>0
//                                                               
//                                                               ),
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity',
				
				#Primary Key
                                
			        'key_id'        => 'id',
                                
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
                                
                                'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/entity/f'],
                                
                                'default_fields' => array ('is_lib' => '"1"'),
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1			
				               
                                
			);
    
        
    

?>
