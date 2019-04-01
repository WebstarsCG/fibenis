<?PHP

    $F_SERIES	=   array(
	
			    'title'		=> 'Page',
			    'table_name'    => 'demo_page_info',
			    
			    # columns
			    'data'	=>  array( 
						    '1' =>array('field_name'	=> 'Title',
								'field_id' 	=> 'title',
								'type' 		=> 'text',
								'is_mandatory'	=>1),
					       
						    '2' =>array('field_name'	=> 'Content',                                                                
								'field_id' 	=> 'content',								   
								'type' 		=> 'textarea_editor',								    
								'input_html'	=>'class="w_100"',								    
								 'is_mandatory'	=>1),
					    ),
			    
			    'key_id'           	=> 'id',    				
			    'is_user_id'   		=> 'user_id',
			    
			    # communication		    
			    'back_to'  		=> array( 'is_back_button' =>1,
							  'back_link'=>'?dx=demo__page'),                                
			    'flat_message'	=> 'Successfully Added',				
			    'show_query'  	=> 0 	#for debugging				
			    
		    );
	
?>