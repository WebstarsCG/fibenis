<?PHP

    $D_SERIES   =   array(
	
							'title' 	=> 'Entity Dashboard',
	
							'data'		=> array(
							
												/* 6=> array(
													   
													   'field_composite'=> [  
																
																'fields'=>[ 'Entity Code'	   => 'entity_code',
																			'Total'=> 'entity_child_count' ],
														
																'table' =>'external_ec_count' 
														],
													   
													   'js_call'	=> 'c3001.graphBase',
													   
													   'attr' 		=> [	'class'	   	=> 'col-md-12 pad_lr mar_top_25',
																			'data-title'=> 'Entity Child Count',
																			'data-type'  	=> 'bar',
																			#'data-bar-width'=> 50,
																			'data-grid-x'	=> true,
																			'data-grid-y'	=> true
																		
																		]
												), */
							
												1=> array(
													   
													   'field_composite'=> [  
																
																'fields'=>[ 'Entity Code'	   => 'entity',
																			'Total'=> 'total_count' ],
														
																'table' =>'entity_internal_external' 
														],
													   
													   'js_call'	=> 'c3001.graphDonut',
													   
													   'attr' 		=> [	'class'	   	=> 'col-md-5 pad_lr mar_top_25',
																			'data-title'=> 'Entity Count',
																			
																		
																		]
												),
						
												2=> array(
													   
													   'field_composite'=> [  
																
																'fields'=>[ 'Entity Code'	   => 'entity',
																			'Total'=> 'total_count' ],
														
																'table' =>'internal_entity_count' 
														],
													   
													   'js_call'	=> 'c3001.graphDonut',
													   
													   'attr' 		=> [	'class'	   	=> 'col-md-7 pad_lr mar_top_25',
																			'data-title'=> 'Internal Entity Count',
																		
																		]
												),
						
												3=> array(
													  
													   'field_composite'=>  ['fields'=>['Users'		=> 'user_name',
																						'Sessions'	=> 'total_count'],
																			 'table' => 'user_session_30_days'],													   
													   'js_call'		=> 'c3001.graphBase',													   
													   'attr' 			=> ['class'      	=> "col-md-12 pad_lr mar_top_25",
																			'data-title' 	=> "User Sessions",
																			'data-type'  	=> 'bar',
																			#'data-bar-width'=> 50,
																			'data-grid-x'	=> true,
																			'data-grid-y'	=> true,
																			//'data-rotate-axis'=>true
																			]
													   ),	
													   
										/* 	    4=> array(
													  
													   'field_composite'=>  ['fields'=>['Users'		=> 'user_name',
																						'Desk Engine'	=> 'desk',
																						'Form Engine'	=> 'form'
																						],
																			 'table' => 'user_engine_sessions'],													   
													   'js_call'		=> 'c3001.graphBase',													   
													   'attr' 			=> ['class'      	=> "col-md-12 pad_lr mar_top_25",
																			'data-title' 	=> "User Sessions",
																			'data-type'  	=> 'spline',
																			#'data-bar-width'=> 50,
																			'data-grid-x'	=> true,
																			'data-grid-y'	=> true]
													   ),
						
						
					    5=> array(
						      
						       'field_composite'=>  [
									      
									      'fields'=>['x'=>'date',
													'Total Sessions'=>'total_count'
											],
									      
									      'table' => 'session_by_date',
									      //'filter'=> " page_code='7f84cf049cd1ca1ec04c0150d4d0c356' ORDER BY DATE ASC "
									    ],
						       
						       'js_call'	=> 'c3001.timeSeries',
						       
						       'attr' 		=> [								  
												'class'      	=> "col-md-12 pad_lr mar_top_25",
												'data-title' 	=> "Session By Date",
												'data-type'  	=> 'area',
												'data-bar-width'=> 3,
												'data-grid-x'	=> true,
												'data-grid-y'	=> true,
												'data-format'	=> '%d-%b-%Y'
											]
						       ),	*/				
						
					), # columns 
			    			    
			    'mode' 	=> 'graph',
			  
		    );    
?>