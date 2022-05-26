<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $F_SERIES	=	array(
				'title'			=>'<a href="?fx=test__text">Text</a>&nbsp/&nbsp
									<a href="?fx=test__option">Select</a>&nbsp/&nbsp
									<a href="?fx=test__toggle">Toggle</a>&nbsp/&nbsp
									<a href="?fx=test__date">Date</a>',

				'gx'			=>1,
				
				'data'			=>   array(
											'1'=> array('field_name'		=> 'Base', 
													    'type'     			=> 'heading',  
													   ),
											 
											'2' =>array('field_name'		 => 'Alphabet',													   
														'field_id' 			 => 'exa_value',
														'type' 			 	 => 'text',
														'allow'     		 => 'w15',
														'child_table'        => 'exav_addon_text', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXAL',
														'input_html'		 =>'class="w_200"',
														'hint'				 =>'Allows alphabetical words in both UPPER and LOWER Case(eg:ABC,abc,Abc)<br><code>allow=>w15</code>'
													 ),
										   
										   '3' =>array( 'field_name'		 => 'Numberic',
														'field_id' 			 => 'exa_value',
														'type' 			 	 => 'textarea',
														'allow'     		 => 'd3',
														'child_table'        => 'exav_addon_varchar', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXNM',
														'input_html'		 =>'class="w_200"',
														'hint'				=>'Allows only digits(eg:1,2,3,...n)<br><code>allow=>d3</code>'
													 ),
										   
										   '4' =>array( 'field_name'		 => 'Decimal',
														'field_id' 			 => 'exa_value',
														'type' 			 	 => 'text',
														'allow'     		 => 'c2,2',
														'child_table'        => 'exav_addon_decimal', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXDL',
														'input_html'		 =>'class="w_200"',
														'hint'				=>'Allows upto 2 digits integral part and 2 digts fractional part in decimal(eg:0.1,0.78,12.0,23.56)<br><code>allow=>c2,2</code>'
													 ),
														
										   '5' => array('field_name'		 => 'Alphabet and exception', 
														'type'     			 => 'text', 
														'field_id' 			 => 'exa_value',
														'allow'     		 => 'x15',
														'child_table'        => 'exav_addon_text', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXAE',
														'input_html'		 =>'class="w_200"',
														'hint'				=>'Allows alphabet in both UPPER and LOWER cases (eg:ABC,abc,Abc) and allows only
																			exceptional characters Underscore(_),Hyphen(-),Comma(,),Fullstop(.) and numbers(eg:1,2,3...)<br><code>allow=>x15</code>'
													 ),
										   
										  '6'=> array( 'field_name'=> 'Advance',
													  'type'     => 'heading',
													 ),
										
										 '7' => array( 'field_name'		 	 => 'Value between', 
														'type'     			 => 'text', 
														'field_id' 			 => 'exa_value',
														'allow'     		 => 'v1-10',
														'child_table'        => 'exav_addon_text', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXVB',
														'input_html'		 =>'class="w_200"',
														'hint'				 =>'Allows values between 1-10(eg:9)<br><code>allow=>v1-10</code>'
													),
										
										 '8' =>array( 'field_name'		 	 => 'Minimal digits',
														'field_id' 			 => 'exa_value',
														'type' 			 	 => 'text',
														'allow'     		 => 'd10-100',
														'child_table'        => 'exav_addon_varchar', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXMD',
														'input_html'		 =>'class="w_200"',
														'hint'				=>'Allows limited digits like(from-to)(eg:10-10000)<br><code>allow=>d10-100</code> '
													),
										'9' =>array( 'field_name'		 	 => 'Equal digits',
														'field_id' 			 => 'exa_value',
														'type' 			 	 => 'text',
														'allow'     		 => 'd10=',
														'child_table'        => 'exav_addon_varchar', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXED',
														'input_html'		 =>'class="w_200"',
														'hint'				=>'Allows exactly 10 digit not less than or greater than(eg:1234567890)<br><code>allow=>d10=</code>'
																				   
												  ),
										 '10' =>array( 'field_name'			 => 'Limted length digits',
														'field_id' 			 => 'exa_value',
														'type' 			 	 => 'text',
														'allow'     		 => 'd10[.]',
														'child_table'        => 'exav_addon_varchar', 	
														'parent_field_id'    => 'parent_id',    		
														'child_attr_field_id'=> 'exa_token',   		
														'child_attr_code'    => 'TTTXLD',
														'input_html'		 =>'class="w_200"',
														'hint'				 =>'Allows Only 10 digits and Fullstop(.)(eg:1234567890,12.345) or whatever the special characters given inside the square bracket(d10[.])<br><code>allow=>d10[.]</code>'
													),
										
										'11' =>array(	'field_name'		 => 'Input type',
														'field_id' 			 => 'exa_value',
														'type' 				 => 'option',
														'is_list' 			 => 0,
														'child_table'   	 => 'exav_addon_varchar',
														'parent_field_id'    => 'parent_id',
														'child_attr_field_id'=> 'exa_token',
														'child_attr_code'    => 'TTIT',
														'option_default'	 => array('label'=>'text','value'=>'ITTX'), 
														'input_html'  		 =>  ' class="w_200"',
														'is_hide'			 =>1,
														 ),
										),
				
				'is_user_id'       		=> 'user_id',
				'table_name'    		=> 'entity_child',
				'key_id'        		=> 'id',
				'default_fields'    	=> array('entity_code' => "'TT'"),
				'header'				=>array('header_content'=>
											'<dl><dt>Type:Text</dt><dt> Attribute:Allow</dt>
												<dd>The key Allow used to choose the relavant type of input in the field. Allow have different kind of values like W,D,C,X,V.</dd>
											<dt>Defnition:</dt>
												<dd>The word w is denoting the words. It include strictly alphabetical words.e.g : ABC, abc,Abc.</dd>
												<dd>The word d is denoting the digits. It include strictly numeric digits.e.g : 1,2,3,...n.</dd>
												<dd>The word c is denoting the decimal. It include numeric and decimal values.e.g : 1,1.1,11.0,2.22,33.33.</dd>
												<dd>The word x includes alphabet,numeric and exceptional characters Underscore(_),Hyphen(-),Comma(,),Fullstop(.). e.g :(ABC, abc,Abc),(1,2,3...),(ab_23.1).</dd>
												<dd>The word v is denoting the values. It include limited numeric digits within(1-10) .e.g :6.</dd>
											<dt>Range:</dt>
												<dd>Every notation can have the range. It is based on the needs.</dd>
												<dd>e.g: First Name should contain only 15 letters. Then we can use w15, as like we can give length for each types.</dd></dl>',
				'header_style'  		=> ''	),	
				
				# Communication
				'button_name'			=> 'Add Text Type',
				'back_to'  				=> array( 'is_back_button' =>1, 'back_link'=>'?dx=test__text', 'BACK_NAME'=>'Back'),
				'divider'       		=> 'tab',
				'show_query'  			=> 0,
			);
	
?>