<?php

    include($LIB_PATH."def/about_us/d.php");
    
    $entity= ['code'=>'G2',
			'title'=>'Grid 2 ',
			'page_code'=>'g2'
			];
    
    $D_SERIES['title'] = $entity['title'];

    $D_SERIES['add_button'] = array('is_add'=>1,'page_link'=>"f=$entity[page_code]", 'b_name' => "Add $entity[title]" );
    
    $D_SERIES['key_filter']=" AND  entity_code='$entity[code]' ";
    
    // Start Coach //////////////////////////////////////////////////////
    
    if(@$_GET['default_addon']){
	
	$temp_parent_id=$_GET['default_addon'];
	
	$D_SERIES['key_filter']=" AND  entity_code='$entity[code]' and parent_id=$temp_parent_id";
	
	$D_SERIES['add_button']['is_add'] = 0;
	$D_SERIES['del_permission']['able_del']=1;
	
    }
    
    ////////////////////////////////////////////////////// End Coach //   
        

?>