<?php

    include($LIB_PATH."def/opg_v2_eav/d.php");
    
    $entity= ['code'=>'AC',
			'title'=>'Accordian',
			'page_code'=>'accordian'
			];
    
    $D_SERIES['title']      = $entity['title'];

    $D_SERIES['add_button'] = array('is_add'=>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
    
    $D_SERIES['key_filter'] = " AND  entity_code='$entity[code]'";
    
    //sn
    $D_SERIES['data'][4]['th']      = 'Title';
    $D_SERIES['data'][4]['td_attr'] = ' width="20%" ';
    
    //ln
    $D_SERIES['data'][5]['th']      = 'Content';
    $D_SERIES['data'][5]['td_attr'] = ' width="60%" ';
    
    $D_SERIES['prime_index']   = 4; 
    
    unset($D_SERIES['data'][1]); 
    unset($D_SERIES['data'][2]);     
    unset($D_SERIES['data'][3]);     
    unset($D_SERIES['data'][6]);    
    unset($D_SERIES['data'][7]);    
    
    unset($D_SERIES['search']);     
    unset($D_SERIES['custom_filter']);
    
     // Start Coach //////////////////////////////////////////////////////
    
    if(@$_GET['default_addon']){
	
	$temp_parent_id=$_GET['default_addon'];
	
	$LAYOUT = 'layout_full';
	unset($D_SERIES['summary_data']);
	
	$D_SERIES['key_filter']=" AND  entity_code='$entity[code]' and get_ec_parent_id_eav(entity_child.id)=$temp_parent_id";
	
	$D_SERIES['add_button']['is_add'] = 0;
	$D_SERIES['del_permission']['able_del']=1;
	
    }
    
    ////////////////////////////////////////////////////// End Coach //
        

?>