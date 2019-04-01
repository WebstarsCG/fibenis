<?php

    include($LIB_PATH."def/opg_v2/d.php");
    
    $entity= ['code'=>'TB',
			'title'=>'Tab Content',
			'page_code'=>'tab'
			];
    
    $D_SERIES['title']      = $entity['title'];

    $D_SERIES['add_button'] = array('is_add'=>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
    
    $D_SERIES['key_filter'] = " AND  entity_code='$entity[code]'";
    
    //sn
    $D_SERIES['data'][3]['th']      = 'Title';
    $D_SERIES['data'][3]['td_attr'] = ' width="20%" ';
    
    //ln
    $D_SERIES['data'][5]['th']      = 'Content';
    $D_SERIES['data'][5]['td_attr'] = ' width="60%" ';
     
    
    unset($D_SERIES['data'][1]); 
    unset($D_SERIES['data'][2]);     
    unset($D_SERIES['data'][4]);     
    unset($D_SERIES['data'][6]);    
    unset($D_SERIES['data'][7]);    
    
    unset($D_SERIES['search']);     
    unset($D_SERIES['custom_filter']);
    
     // Start Coach //////////////////////////////////////////////////////
    
    if(@$_GET['default_addon']){
	
	$temp_parent_id=$_GET['default_addon'];
	
	$D_SERIES['key_filter']=" AND  entity_code='$entity[code]' and parent_id=$temp_parent_id";
	
	$D_SERIES['add_button']['is_add'] = 0;
	$D_SERIES['del_permission']['able_del']=1;
	
    }
    
    ////////////////////////////////////////////////////// End Coach //
        

?>