<?PHP
    
    $LAYOUT	    = 'layout_full';
                            
    $F_SERIES	=	array(
				#Title
				
				'title'	=>'Section Template',
				
				#Table field
                    
				'data'	=>   array(
							 '1' =>array( 'field_name'=> 'Name',
                                                               
								'field_id' => 'sn',
                                                               
								'allow' => 'x25',
								
								'type'  => 'text',
								
								'is_mandatory'=>1,								
                                                             ),
						
						    
						    '2' =>array( 'field_name'=> 'Content',
                                                               
								'field_id' => 'note',
                                                               
								'type' => 'code_editor'
																
                                                             ),
						   
					    ),
				
                                    
				'table_name'    => 'entity_child_base',
				
				'key_id'        => 'id',
				
				'back_to'=> array( 'is_back_button' => 1,
						   'back_link'      => '?d=page_section__template',
						   ),
				
				'is_user_id'       => 'user_id',
				
				'default_fields'    => array('entity_code' => "'SC'",'dna_code'=>"'EBMS'"),
                                			
				'flat_message' => 'Template Sucesssfully Added',
				
			);
    
   
?>