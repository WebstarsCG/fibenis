<?php

    include($LIB_PATH."def/opg_v2_eav/d.php");
    
    $D_SERIES['title'] = 'Home Banner';

    $D_SERIES['add_button'] = array('is_add'=>1,'page_link'=>'f=home_banner', 'b_name' => 'Add Home Banner' );
    
    $D_SERIES['key_filter'] = " AND  entity_code='HB'  ";
    
    // Data
    
    $D_SERIES['data'][3]['th'] = 'Button Title';
     $D_SERIES['data'][3]['attr'] = ['width'=>'20%'];
    
    $D_SERIES['data'][4]['th'] = 'Btn. URL';
    $D_SERIES['data'][4]['attr'] = ['width'=>'20%'];
    
    $D_SERIES['data'][5]['th'] = 'Title';
    
    $D_SERIES['data'][6]['th'] = 'Banner Image';
    
    
    
    unset($D_SERIES['data'][1]);
     
    unset($D_SERIES['data'][2]);
    
    unset($D_SERIES['data'][5]);
     
    unset($D_SERIES['data'][7]);
    
    // feature unset
    
    unset($D_SERIES['search']);
     
    unset($D_SERIES['custom_filter']);

	
     // Start Coach //////////////////////////////////////////////////////
    
    if(@$_GET['default_addon']){
	
	$temp_parent_id=$_GET['default_addon'];
	
	$D_SERIES['key_filter']=" AND  entity_code='HB' and get_ec_parent_id_eav(id)=$temp_parent_id";
	
	$D_SERIES['add_button']['is_add'] = 0;
	
	$D_SERIES['del_permission']['able_del']=1;
	
	$LAYOUT = 'layout_full';
	
	unset($D_SERIES['summary_data']);
   
	
    }
    
    ////////////////////////////////////////////////////// End Coach //
        

?>