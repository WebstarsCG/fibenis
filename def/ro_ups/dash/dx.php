<?PHP


$D_SERIES   =   array(
	
							'title' 	=> 'Entity Dashboard',
	
							'data'		=> array(
							
												6=> array(
													   
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
												),
											),
							'mode'  =>'graph'
							);
							
							
							
?>