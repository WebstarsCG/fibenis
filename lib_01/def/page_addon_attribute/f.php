<?PHP

    include("$LIB_PATH/def/external_attribute/f.php");
    
    $F_SERIES['back_to']  = array( 'is_back_button' =>1, 'back_link'=>'?d=page_addon_attribute', 'BACK_NAME'=>'Back');
    
    $F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn',"WHERE code = 'EA' ORDER by sn ASC"); 
    
    $no_row = $G->table_no_rows( array('table_name'=>'entity_child_base',
                                           'WHERE_FILTER'=>"AND entity_code = 'EA'"
                                           ));
	
    $line_order= $no_row[0]+1;	
	
    $F_SERIES['data']['17'] = array(
				       'field_name'=> 'Line Order', 
                                                               
					'field_id' => 'line_order',
				       
					'type' => 'text',
					
					'is_mandatory'=>1,
					
					'input_html'=>'class="w_50" value='.$line_order,				
						
				);
?>