<?PHP


    $F_SERIES=array(
		    
		    
		    'title'=>'User Role',
                   
		    
		    'data'=>array(
				  
				    '1' => array(
						    
						   'field_name'  => 'User Role Page',
						   'field_id' 	 => 'user_role_id',
						   'type' 	 => 'hidden',
						   'is_mandatory'=> 1,						   
						   'attr'	 => [ 'class'=> ' w_200']
						    
					         ),
				    
				    '3' => array(
						
						'field_name'   => 'Page Name',
						'field_id'     => 'sn',
						'type'         => 'text',
						'is_mandatory' =>  1,
						
						'attr'   	=>  ['class'=>'w_200'],
						'allow'		=> 'x64', 
						
					    ),
					
											       
				    '2' => array(
						    
						    'field_name'   => 'User Page',
						    'field_id'     => 'user_page_ids',
						    'type'         => 'list_left_right',
						    'option_data'  =>'',
						    'option_id_name' => $G->get_id_name('ecb_parent_child_matrix','id,get_ecb_parent_child_name_mode(id,\'  \',\'PAGE\')'," WHERE ecb_parent_id IN(SELECT id FROM entity_child_base WHERE entity_code='DF')  "),
						    'is_mandatory' =>  1,
						    'option_is_quick_search'=>1,						    
						    'input_html'   =>  ' class="w_400" rows="5"  style="height:200px !important"  '
						    
						    
					        ),
				    
				    '4' => array(
						
						'field_name'   => 'Line Order',
						'field_id'     => 'line_order',
						'type'         => 'text',
						'is_mandatory' =>1,
						'attr'		=> ['class'=>'w_50'],
						'allow'		=> 'c5,c2',
						'is_line_order' =>1,
						
					    ),
				    
				   ),
		     
			'table_name'    => 'user_role_page',
			            
			'key_id'        => 'id',
			
			'form_layout'    =>'form_100',
			
		     
			'cascade_action'=>1,
		     
			'after_add_update' => 1,
			            
                    # Default Additional Column
                                
			'is_user_id'       => 'user_id',
								
                    # Communication
								
			'back_to'  => array( 'is_back_button' =>0, 'back_link'=>'?d=user_role_page'),
                                
			'prime_index'   => 1,
			
                             
                    );
    
    # Edit

    if(@$_GET['default_addon']){
	    $F_SERIES['data']['1']['attr']['value']    = $_GET['default_addon']; 
	    $F_SERIES['back_to']['back_default_addon'] = @$_GET['default_addon'];
	    $F_SERIES['back_to']['back_menu_off']      = @$_GET['menu_off'];
    }
    
    if(@$_GET['key']){
	    $F_SERIES['back_to']['is_back_button']     = 1;
    }    

    // after add update
    
    function after_add_update($key_id){
      
	global $rdsql;
      
	global $G,$USER_ID;
	
	//2->items, 3->title
	
	$lv      = [];
      
	$session = $_SESSION;
      
	$param   = $_POST;
	
	$current_items            = explode(',',$param['X2']);
	
	$lv['current_item_count'] = count($current_items);
	
	$lv['item_counter']       = 1;
	
	// delete existing item	
	$delete_existing_query="DELETE FROM
					user_role_page_matrix
				WHERE
					user_role_page_matrix.user_role_page_id=$key_id";
					
	$rdsql->exec_query($delete_existing_query,'UPU');
	
	// comments	
	if($lv['current_item_count'] > 0){	
		   
	    if($lv['current_item_count']==1){		    
		    $lv['parent_id']   = 0;
		    $lv['parent_tite'] = $param['X3'];
	    }else{
		    
		    $parent_query   =  "INSERT INTO
						user_role_page_matrix (user_role_page_id,user_page_id,parent_id,sn,line_order,user_id)
					    values
						($key_id,$current_items[0],0,'$param[X3]',$param[X4],$USER_ID)";
		    
		    $rdsql->exec_query($parent_query,"UPI");
		    
		    $lv['parent_tite'] = '';
		    
		    $lv['parent_id'] = $rdsql->last_insert_id($table_name);
	    }
	    
	    $new_item_text    = '';
	    
	    // take new one    
	    foreach($current_items as &$item) {		    
		    
		    $new_item_text.="($key_id,$item,$lv[parent_id],'$lv[parent_tite]',$lv[item_counter],$USER_ID),";
		    
		    $lv['item_counter'] ++;
	    }
	    
	    // if new item there	    
	    if(strlen($new_item_text)>0){
		
			$new_item_text  =  substr($new_item_text,0,-1);
		
			$new_item_query =  "INSERT INTO
						user_role_page_matrix (user_role_page_id,user_page_id,parent_id,sn,line_order,user_id)
					    values
						$new_item_text";						
						
			$rdsql->exec_query($new_item_query,"UPI");		
	    } // end
	
	} // if new item
	
   } // end of func
    
    
?>