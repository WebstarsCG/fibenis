<?PHP


    $F_SERIES=array(
		    
		    
		    'title'=>'<li><a href="?d=user_role">User Role</a></li><li>User Role Permission</li>',
                    
		    'data'=>array(
				  
				    '1' => array(
						    
						   'field_name' => 'User Role',
						   'field_id' => 'user_role_id',
						   'type' => 'hidden',						 
						   'is_mandatory'=>1,						   
						   'attr'	=> [ 'class'=> ' w_200']
						    
					         ),
											       
				    '2' => array(
						    
						    'field_name'   => 'User Permission',
						    'field_id'     => 'user_permission_ids',
						    'type'         => 'list_left_right',
						    'option_data'  =>'',
						    'is_mandatory' =>  1,
						    'option_is_quick_search'=>1,						    
						    'input_html'   =>  ' class="w_400" rows="5"  style="height:200px !important"  '
						    
						    
					        ),
				   ),
		     
			'table_name'    => 'user_role_permission',
			            
			'key_id'        => 'id',
			
			'form_layout'    =>'form_100',
			
			'button_name'    => ' User Role Permission ',
		     
			'cascade_action'=>1,
		     
			'after_add_update' => 1,
			            
                    # Default Additional Column
                                
			'is_user_id'       => 'user_id',
								
                    # Communication
								
			'back_to'  => array( 'is_back_button' =>0, 'back_link'=>'?d=user_role_permission', 'BACK_NAME'=>'Back'),
                                
			'prime_index'   => 1,
			
			'page_code'	=> 'FURP'
                             
                    );
    
    # Edit

    if(@$_GET['default_addon']){
	
	    $F_SERIES['data']['2']['option_id_name'] = $G->get_id_name('ecb_parent_child_matrix','id,get_ecb_parent_child_name(id,\'  \')'," WHERE ecb_parent_id IN(SELECT id FROM entity_child_base WHERE entity_code='DF')  ");
	    
	    $F_SERIES['data']['1']['avoid_default_option'] = 1;
	    $F_SERIES['data']['1']['attr']                 = ['value'=>$_GET['default_addon']];
	    
	    $F_SERIES['back_to']['back_default_addon']     = @$_GET['default_addon'];
    
    }
    
    
    //
    //
    //if(     @$_GET['key']){    before_update(@$_GET['key']);  }    
    //else{   $F_SERIES['data']['2']['option_data'] = $G->option_builder('ecb_parent_child_matrix','id,get_ecb_parent_child_name(id,\'  \')'," WHERE ecb_parent_id IN(SELECT id FROM entity_child_base WHERE entity_code='DF')  ");
    //       
    //}
    
    // after add update / option builder action
    
    function before_update($key_id){
	
	global $G,$F_SERIES;
	
	if($key_id){
	    
	    
	    
	    # get role id
	    
	    $get_role_id    =    $G->get_one_columm(array('table'	 => 'user_role_permission',
			  				  'field'	 => 'user_role_id',
							  'manipulation' => " WHERE  id=$key_id  "
					    ));
	    
	    
	    
	    # role option data
	    //
	    //$F_SERIES['data']['1']['option_data']		= $G->option_builder('user_role','id,ln','where id='.$get_role_id.'');
	    //$F_SERIES['data']['1']['avoid_default_option']	= 1;
	    
	    # option prefill data
	    
	   
	    
	    $F_SERIES['temp']['user_permission_present_data']   = " WHERE  id NOT IN ( SELECT user_permission_id FROM user_role_permission_matrix WHERE user_role_id=$get_role_id)";
	   
	    $F_SERIES['temp']['user_permission_existing_data']  = " WHERE  id IN( SELECT user_permission_id FROM user_role_permission_matrix WHERE user_role_id=$get_role_id)"; 
	    
	    
	    //$F_SERIES['temp']['user_permission_existing_data']='';
	    
	    $F_SERIES['data']['2']['option_data']		= $G->option_builder('ecb_parent_child_matrix','id,get_ecb_parent_child_name(id,\'->\')',$F_SERIES['temp']['user_permission_present_data'].' ');
	    
	    $F_SERIES['data']['2']['option_existing_data']	= $G->option_builder('ecb_parent_child_matrix','id,get_ecb_parent_child_name(id,\'->\')',$F_SERIES['temp']['user_permission_existing_data'].' ');
	    
	    $F_SERIES['data']['2']['option_id_name']            = $G->get_id_name('ecb_parent_child_matrix','id,get_ecb_parent_child_name(id,\'->\')',$F_SERIES['temp']['user_permission_present_data'].' ');
	    
	} # edit
	
	  
	
    } # end of add update action
    
    // after add update
    
    function after_add_update($key_id){
      
	global $rdsql;
      
	global $G;
      
	$session = $_SESSION;
      
	$param   = $_POST;
	
	$user_role_id  = $param['X1'];
	
	$current_items = explode(',',$param['X2']);
	
	$new_item_text = '';
		
	// Delete old one
	// comments
	
	//$delete_existing_query="DELETE FROM
	//				user_role_permission_matrix
	//			WHERE
	//				user_role_permission_matrix.user_role_id=$user_role_id AND
	//				LOCATE(user_permission_id,(SELECT user_permission_ids FROM user_role_permission WHERE user_role_permission.user_role_id=$user_role_id))=0";
	
	$delete_existing_query="DELETE FROM
					user_role_permission_matrix
				WHERE
					user_role_permission_matrix.user_role_id=$user_role_id";
	
	
	$rdsql->exec_query($delete_existing_query,'UPU');
	
	// take new one
	
	//$existing_available_items  =    $G->get_one_columm(array('table'	=> ' user_role_permission_matrix',
	//							'field'		$current_itemsoncat(user_permission_id)',
	//							'manipulation'	=> " WHERE  user_role_id=$user_role_id  "
	//				    ));
	//
	//
	//$existing_items = explode(',',$existing_available_items);	
	
	//$new_items      = array_diff($current_items,$existing_items);
	
	foreach ($current_items as &$item) {
	        
		$new_item_text.="($user_role_id,$item),";
        }
	
	// if new item there
	
	if(strlen($new_item_text)>0){
	    
		    $new_item_text=substr($new_item_text,0,-1);
	    
		    $new_item_query = "INSERT INTO
					    user_role_permission_matrix (user_role_id,user_permission_id)
					values
					    $new_item_text";
					    
					    
		    $rdsql->exec_query($new_item_query,"UPI");
	    
	} // end
	
	
	before_update($key_id);
      
   } // end
    
    
?>