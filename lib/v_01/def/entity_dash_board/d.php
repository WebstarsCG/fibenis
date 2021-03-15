<?PHP

    $D_SERIES   =   array(
	
							'title' 	=> 'Entity Dashboard',
	
							'data'		=> array(
							
												1=> array(
													   
													   'field_composite'=> [  
																
																'fields'=>[ 'x'	   => ' (SELECT sn FROM entity WHERE code=entity_code)',
																			'Total'=> 'count' ],
														
																'table' =>'entity_count' 
														],
													   
													   'js_call'	=> 'c3001.graphDonut',
													   
													   'attr' 		=> [	'class'	   	=> 'col-md-12 pad_lr mar_top_25',
																			'data-title'=> 'Entity Count',
																		
																		]
												),
						
												2=> array(
													  
													   'field_composite'=>  ['fields'=>['Users'		=> 'page_action',
																						'Sessions'	=> 'total_count'],
																			 'table' => 'page_access_count'],													   
													   'js_call'		=> 'c3001.graphBase',													   
													   'attr' 			=> ['class'      	=> "col-md-12 pad_lr mar_top_25",
																			'data-title' 	=> "Page Access Count",
																			'data-type'  	=> 'area',
																			#'data-bar-width'=> 50,
																			'data-grid-x'	=> true,
																			'data-grid-y'	=> true]
													   ),	
						
						
					    3=> array(
						      
						       'field_composite'=>  [
									      
									      'fields'=>['x'=>'date',
													'Total'=>'total'
											],
									      
									      'table' => 'page_view_log_by_day',
									      'filter'=> " page_code='7f84cf049cd1ca1ec04c0150d4d0c356' ORDER BY DATE ASC "
									    ],
						       
						       'js_call'	=> 'c3001.timeSeries',
						       
						       'attr' 		=> [
								  
										'class'      	=> "col-md-12 pad_lr mar_top_25",
										'data-title' 	=> "Login Count by Day",
										'data-type'  	=> 'area',
										#'data-bar-width'=> 50,
										'data-grid-x'	=> true,
										'data-grid-y'	=> true
									    ]
						       ),						
						
					), # columns
			    			    
			    'mode' 	=> 'graph',
			  
		    );    
?>