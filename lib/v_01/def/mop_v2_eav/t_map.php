<?php

    $T_SERIES['temp']['map']=[
			
			# Home Banner
			
			'AC' => ['accordion_heading','accordion'],
			
			'HB' => ['home_banner']	,
			
			'HA' => ['home_aboutus_heading','home_aboutus'],
			
			'HI' => ['home_images'],
			
			'CX' => [
				
				  'contact',
				  'contact_info'
				 ],
			
			'MQ' => ['marquee'],
			
			
			//'HF' => ['feature_heading','features'],
			// 'CM' => ['contact_info_map'],
			//
			//'HT' => ['team_heading','team'],
			//
			//
			//
			//'HG' => ['portfolio_heading','portfolio'],
			//
			//'HC' => ['counter_heading','counter'],
			//
			//'HL' => ['clients_heading','clients'],
			//
			//'AB' => ['action_box_heading','action_box'],
			//
			//'TB' => ['tab_heading','home_tab_title','home_tab_content'],
			//
			//'HX' => ['current_year','footer_info'],
			//
			//'G1' => ['g1_heading','g1'],
			//
			//'G2' => ['g2_heading','g2'],
	];
    
	
	$T_SERIES['temp']['temp_op'] = [];
	
	foreach($T_SERIES['temp']['map'] as $op_code => $op_code_param){
	    
	   array_push($T_SERIES['temp']['temp_op'],$op_code); 
	    
	}
	
	$T_SERIES['op_code'] = "'".implode("','", $T_SERIES['temp']['temp_op'])."'";

?>