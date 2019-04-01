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
                                                               
                                                                'is_mandatory'=>1,
                                                                
                                                                'allow'     => 'w4[1,2,3,4,5,6,7,8,9,0]',
                                                                
                                                                'input_html'=>'class="w_50" onchange="check_en_code(this);"',
                                                                
                                                                ),
                                                   
                                                   '2' =>array( 'field_name'=> 'Name',
                                                               
                                                               'field_id' => 'sn',
                                                               
                                                               'type' => 'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_200"',
                                                               
                                                               'allow'     => 'x50',
                                                                
                                                               
                                                               'hint'   => 'Give Entity Name'
                                                               
                                                               ),
				   
						   '3' =>array('field_name'=>'Long Name',
                                                               
                                                               'field_id'=>'ln',
                                                               
                                                               'type'=>'text',
                                                               
                                                                'allow'     => 'x1000',
                                                                
                                                                'input_html'=>'class="w_200"',
                                                               
                                                               'is_mandatory'=>0
                                                               
                                                               ),
                                                   
                                                   '4' =>array('field_name'=>'Core Entity',
                                                               
                                                               'field_id'=>'is_lib',
                                                               
                                                               'type'=>'option',
                                                               
                                                               'type'                => 'option',
                                                                
                                                               'option_data'         => '<option value=0>No</option><option value=1>Yes</option>',                                                               
                                                                
                                                               'is_mandatory'=>0,
                                                               
                                                               'avoid_default_option' => 1
                                                               
                                                               
                                                            ),
									
				    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity',
				
				#Primary Key
                                
			        'key_id'        => 'id',
                                
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
                                
                                'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/entity/f'],
                                
                                //'default_fields' => array ('is_lib' => '"0"'),
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1,
                                
				# File Include
                                
				//'js'            => 'q_details',
				
				#Page Code
				
				'page_code'	=> 'FETY',
                                
                                'show_query'    => 0
                                
			);
    
        
    

?>
