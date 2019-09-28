<?php

    include($LIB_PATH."def/one_page_general/d.php");
    
    $D_SERIES['title'] = 'Testimonial';

    $D_SERIES['add_button'] = array( 'is_add'=>1,'page_link'=>'f=testimonial', 'b_name' => 'Add Testimonial' );
    
    $D_SERIES['key_filter']=" AND  entity_code='TM'  ";
    
    $D_SERIES['data'][1]['th'] = 'Heading';
    
    $D_SERIES['data'][5]['th'] = 'Name';
    
    $D_SERIES['data'][1]['td_attr'] = ' width="30%" ';
    
    $D_SERIES['data'][5]['td_attr'] = ' width="50%" ';
    
     unset($D_SERIES['data'][3]);
     
     unset($D_SERIES['data'][4]);
     
     unset($D_SERIES['data'][7]);
     
    unset($D_SERIES['data'][8]);
    
    unset($D_SERIES['data'][9]);
     
     unset($D_SERIES['search']);
     
     unset($D_SERIES['custom_filter']);
    
    if(@$_GET['default_addon']){

		$D_SERIES['add_button']['is_add'] = 0;
	}
	
     // Start Coach //////////////////////////////////////////////////////
    
    if(@$_GET['default_addon']){
	
	$temp_parent_id=$_GET['default_addon'];
	
	$D_SERIES['key_filter']=" AND  entity_code='TM' and parent_id=$temp_parent_id";
	
	$D_SERIES['add_button']['is_add'] = 0;
	$D_SERIES['del_permission']['able_del']=1;
	
    }
    
    ////////////////////////////////////////////////////// End Coach //
    
?>