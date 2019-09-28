<?php

    include($LIB_PATH."def/opg_v2/d.php");
    
    $entity= ['code'=>'AB',
			'title'=>'Action Box',
			'page_code'=>'action_box'
	    ];
    
    $D_SERIES['title'] = $entity['title'];

    $D_SERIES['add_button'] = array('is_add'=>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
    
    $D_SERIES['key_filter']=" AND  entity_code='$entity[code]' ";
    
    $D_SERIES['data'][3]['th']   = 'Name';
    $D_SERIES['data'][3]['attr'] = ['width'=>'10%'];
    
    $D_SERIES['data'][4]['th']   = 'URL';
    $D_SERIES['data'][4]['attr'] = ['width'=>'20%'];
    
    $D_SERIES['data'][5]['th']   = 'Short Hint';
    $D_SERIES['data'][5]['attr'] = ['width'=>'30%'];
   
    # unset
    unset($D_SERIES['data'][1]);   
    unset($D_SERIES['data'][2]);      
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