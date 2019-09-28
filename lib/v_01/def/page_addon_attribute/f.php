<?PHP

    include("$LIB_PATH/def/external_attribute/f.php");
    
    $F_SERIES['title']    = 'Page Addon Attributes'; 
    
    $F_SERIES['back_to']  = array( 'is_back_button' =>1, 'back_link'=>'?d=page_addon_attribute', 'BACK_NAME'=>'Back');
    
    $F_SERIES['data'][1]['avoid_default_option'] = 1; 
    $F_SERIES['data'][1]['option_data']          = "<option value='EA'>Page Addon Attribute</a>";
    
    
    
    $no_row = $G->table_no_rows( array('table_name'=>'entity_child_base',
                                           'WHERE_FILTER'=>"AND entity_code = 'EA'"
                                           ));
	
    $line_order= $no_row[0]+1;	
	
    $F_SERIES['data'][9]['attr']=['class'=>'w_50', 'value'=>$line_order];
    
 
?>