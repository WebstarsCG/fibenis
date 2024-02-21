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

			'flat_message'	=> 'User Role Permission Update Successfully',
			'is_cc'			=>1,
                             
	);
    
    # Edit

    if(@$_GET['default_addon']){
	
	    $F_SERIES['data']['2']['option_id_name'] = $G->get_id_name('ecb_parent_child_matrix','id,get_ecb_parent_child_name(id,\'  \')'," WHERE ecb_parent_id IN(SELECT id FROM entity_child_base WHERE entity_code='DF')  ");
	    
	    $F_SERIES['data']['1']['avoid_default_option'] = 1;
	    $F_SERIES['data']['1']['attr']                 = ['value'=>$_GET['default_addon']];
	    
	    $F_SERIES['back_to']['back_default_addon']     = @$_GET['default_addon'];
    
    }
    
    // after add update
    
    function after_add_update($key_id){
      
		global $rdsql,$USER_ID;		  
			  
		$param   = $_POST;
		
		$user_role_id  = $param['X1'];
		
		$current_items = explode(',',$param['X2']);
		
		$new_item_text = '';
		
		$delete_existing_query="DELETE FROM
											user_role_permission_matrix
										WHERE
											user_role_permission_matrix.user_role_id=$user_role_id";
		
		
		$rdsql->exec_query($delete_existing_query,'UPU');
		
		// take new one	
		
		foreach ($current_items as &$item) {
				
			$new_item_text.="($user_role_id,$item,$USER_ID),";
		}
		
		// if new item there		
		if(strlen($new_item_text)>0){
			
				$new_item_text=substr($new_item_text,0,-1);
			
				$new_item_query = "INSERT INTO
										user_role_permission_matrix (user_role_id,user_permission_id,user_id)
									VALUES
										$new_item_text";							
							
				$rdsql->exec_query($new_item_query,"UPI");
			
		} // end
      
   } // end
    
    
?>