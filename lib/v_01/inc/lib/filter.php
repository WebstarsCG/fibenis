<?php	
		
		$FILTER = array();
				
		function filter_circle($data_in,$style){
		
		return 		"<span class='fa-stack fa-lg'>
					<i class='fa fa-circle $style fa-stack-2x'></i>
					<i class='fa fa-stack-1x fa-inverse'>$data_in</i>
			        </span>";
		}
		
		
		
		function filter_square($data_in,$style){
		
		return 		"<span class='fa-stack fa-lg'>
					<i class='fa fa-square $style fa-stack-2x'></i>
					<i class='fa fa-stack-1x fa-inverse'>$data_in</i>
			        </span>";
		}
		
		$FILTER['range'] = function($data_in){				
				$temp = json_decode($data_in);				
				return (($temp[0]) && ($temp[1]))?$temp[0].' - '.$temp[1]:$temp[0].$temp[1];				
		};
		
		
		$FILTER['twin_box'] = function($data_in){				
				$temp = json_decode($data_in);				
				return $temp[0].' '.$temp[1];				
		};	
		
		$FILTER['circle_red'] = function($data_in){				
				return filter_circle($data_in,'clr_red b'); 
		};
		
		$FILTER['circle_green'] = function($data_in){				
				return filter_circle($data_in,'clr_green b'); 
		};
		
		$FILTER['circle_primary'] = function($data_in){				
				return filter_circle($data_in,'clr_pri b'); 
		};
		
		$FILTER['circle_secondary'] = function($data_in){				
				return filter_circle($data_in,'clr_sec b'); 
		};
		
		$FILTER['square_red'] = function($data_in){				
				return filter_square($data_in,'clr_red b'); 
		};
		
		$FILTER['square_green'] = function($data_in){				
				return filter_square($data_in,'clr_green b'); 
		};
		
		$FILTER['square_primary'] = function($data_in){				
				return filter_square($data_in,'clr_pri b'); 
		};
		
		$FILTER['square_secondary'] = function($data_in){				
				return filter_square($data_in,'clr_sec b '); 
		};
		
		$FILTER['avoid_empty_zero'] = function($data_in){
				
				$data_in = preg_replace('/\s/','',$data_in);       				
				return ((strlen($data_in)>0)?1:0);
		};
		
		$FILTER['code_editor_neutral'] = function($data_in){				
				return preg_replace('/\//','\/',$data_in);		
		};
		
		
		
		
?>