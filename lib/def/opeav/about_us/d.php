<?php

    include($LIB_PATH."def/opg_v2_eav/d.php");
    
    $entity= ['code'=>'HA',
			'title'=>'Home About Us ',
			'page_code'=>'about_us'
			];
    
    $D_SERIES['title'] = $entity['title'];

    $D_SERIES['add_button'] = array('is_add'=>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
    
    $D_SERIES['key_filter']=" AND  entity_code='$entity[code]' ";
    
    $D_SERIES['data'][3]['th']   = 'Title';
    $D_SERIES['data'][3]['attr'] = ['width'=>'10%'];
    
    $D_SERIES['data'][5]['th']   = 'Detail';
    $D_SERIES['data'][5]['attr'] = ['width'=>'70%'];
    
    $D_SERIES['data'][6]['th']   = 'Description';
    $D_SERIES['data'][6]['attr'] = ['width'=>'30%'];
   
     
    # unset
    unset($D_SERIES['data'][1]);   
    unset($D_SERIES['data'][2]);      
    unset($D_SERIES['data'][4]);     
    unset($D_SERIES['data'][7]);
  
    unset($D_SERIES['search']);     
    unset($D_SERIES['custom_filter']);
    
     // Start Coach //////////////////////////////////////////////////////
    
    if(@$_GET['default_addon']){
	
	$temp_parent_id=$_GET['default_addon'];
	
	$D_SERIES['key_filter']=" AND  entity_code='$entity[code]' AND get_ec_parent_id_eav(id)=$temp_parent_id";
	
	$D_SERIES['add_button']['is_add'] = 0;
	$D_SERIES['del_permission']['able_del']=1;
	
	$LAYOUT = 'layout_full';
	unset($D_SERIES['summary_data']);
   
	
    }
    
    ////////////////////////////////////////////////////// End Coach //
        

?>