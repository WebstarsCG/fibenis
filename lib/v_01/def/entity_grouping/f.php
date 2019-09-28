<?PHP


    $F_SERIES=array(
		    
		    'title'=> 'Entity Grouping',
		    
		    'data'=>array(
				     '1' => array(
						    
						   'field_name' => 'Name',
						   'field_id' => 'sn',
						   'type' => 'text',
						   'is_mandatory'=>1,
						   'attr'	=> [ 'class'=> ' w_100']
						),
				    
				    '2' => array(
						    
						   'field_name' => 'Long Name',
						   'field_id' => 'ln',
						   'type' => 'text',
						   'is_mandatory'=>0,
						   'attr'	=> [ 'class'=> ' w_100']
						),
				    
				    '3' => array(
						   'field_name' => 'Code',
						   'field_id' => 'token',
						   'type' => 'text',
						   'is_mandatory'=>1,
						    'allow' => 'x4',
						    'input_html'=>'class="w_60" onchange="check_token(this);"',
                                                               
						),
				    
				    							       
				    '4' => array(
						    
						    'field_name'   => 'Search',
						    'field_id'     => 'note',
						    'type'         => 'list_left_right',
						    'option_data'  =>'',
						    'is_mandatory' =>  1,
						    'option_is_quick_search'=>1,						    
						    'input_html'   =>  ' class="w_400" rows="5"  style="height:200px !important"  '
						    
						),
				    
				   ),
		     
			'table_name'    => 'entity_child_base',
			            
			'key_id'        => 'id',
			
			'form_layout'    =>'form_100',
			
			'default_fields' => array('entity_code' => "'GP'"),	
			
			'button_name'    => '',
		     
			'cascade_action'=>1,
			
			'after_add_update' => 1,
			            
                    # Default Additional Column
                                
			'is_user_id'       => 'user_id',
			
			'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/entity_child_base/f'],
				
								
                    # Communication
								
			'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_grouping', 'BACK_NAME'=>'Back'),
                                
			'prime_index'   => 1,
			      
                    );
    
    # Edit
    
    if(@$_GET['key']){	
	
	$F_SERIES['data'][1]['input_html'] = 'class="w_100" readonly';
	
	$F_SERIES['data'][2]['input_html'] = 'class="w_100" readonly';
	
	$F_SERIES['data'][3]['input_html'] = 'class="w_100" readonly';
	
	before_update(@$_GET['key']);	
    
    }else{
	    
	    $F_SERIES['data']['4']['option_data']		= $G->option_builder('entity','code,sn',' ');
	   
	    $F_SERIES['data']['4']['option_id_name']            = $G->get_id_name('entity','code,sn',' ');
	    
    }
    
    // after add update 
    
    function before_update($key_id){
	
	global $G,$F_SERIES;
	
	if($key_id){
	    
	    
	    $get_data    =    $G->get_one_cell(array   (  'table'	 => 'entity_child_base',
			  				  'field'	 => 'note',
							  'manipulation' => " WHERE  id=$key_id  "
					    ));
	    
	    $F_SERIES['temp']['present_data']   = " WHERE code IN (SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=$key_id AND ea_code='GPEN' )";
	    
	    $F_SERIES['temp']['not_present_data']   = "WHERE code NOT IN (SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=$key_id AND ea_code='GPEN' )";
	    
	    $F_SERIES['data']['4']['option_data']		= $G->option_builder('entity','code,sn',$F_SERIES['temp']['not_present_data'].' ');
	   
	    $F_SERIES['data']['4']['option_existing_data']	= $G->option_builder('entity','code,sn',$F_SERIES['temp']['present_data'].' ');
	   
	    $F_SERIES['data']['4']['option_id_name']            = $G->get_id_name('entity','code,sn',$F_SERIES['temp']['not_present_data'].' ');
	    
	} # edit
	
	  
	
    } # end of add update action
    
    // after add update
    
    function after_add_update($key_id){
      
	global $rdsql;
      
	global $G;
      
	$session = $_SESSION;
      
	$param   = $_POST;
	
	//$entity_group_id  = $param['X1'];

    	$entity_group_id  = $key_id;

    	
	$current_items = explode(',',$param['X4']);
	
	$new_item_text = '';
		
	$delete_existing_query="DELETE FROM
					ecb_av_addon_varchar
				WHERE
					ecb_av_addon_varchar.parent_id=$entity_group_id";
	
	
	$rdsql->exec_query($delete_existing_query,'Entity grouping delete');
	
	foreach ($current_items as &$item) {
	        
		$new_item_text.="($entity_group_id,'GPEN','$item'),";
        }
	
	// if new item there
	
	if(strlen($new_item_text)>0){
	    
		    $new_item_text=substr($new_item_text,0,-1);
	    
		    $new_item_query = "INSERT INTO
					    ecb_av_addon_varchar (parent_id,ea_code,ea_value)
					values
					    $new_item_text";
					    
					    
		    $rdsql->exec_query($new_item_query,"Entity grouping insert");
	    
	} // end
	
	
	before_update($key_id);
      
   } // end
    
    
?>