<?PHP


    $F_SERIES=array(
		    
		    'title'=> 'Entity Grouping',
		    
		    'data'=>array(
			
						'_SN' => array(
						     
							'field_name' 		  => 'Group Name',
							'field_id'			  => 'ea_value',
							'type' 				  => 'text',
							'child_table'         => 'eav_addon_varchar', 	
							'parent_field_id'     => 'parent_id',    		
							'child_attr_field_id' => 'ea_code',   		
							'child_attr_code'     => 'ECSN',           		
							'is_mandatory'		  => 1,
							'allow'				  => 'x50',
							'attr'				  => [ 'class'=> ' w_300']
						),
						
						
						'_TK' => array(
						     
							'field_name' 		  => 'Group Token',
							'field_id'			  => 'ea_value',
							'type' 				  => 'text',
							'child_table'         => 'eav_addon_vc128uniq', 	
							'parent_field_id'     => 'parent_id',    		
							'child_attr_field_id' => 'ea_code',   		
							'child_attr_code'     => 'ECCD',           		
							'is_mandatory'		  => 1,
							'allow'				  => 'w32[_]',
							'attr'				  => [ 'class'=> ' w_300'],
							'hint'			  => "Give the token without space & special characters(expect '_')"
						),
				    
				    '_LN' => array(
						     
							'field_name' 		  => 'Group Description',
							'field_id'			  => 'ea_value',
							'type' 				  => 'textarea',
							'child_table'         => 'eav_addon_varchar', 	
							'parent_field_id'     => 'parent_id',    		
							'child_attr_field_id' => 'ea_code',   		
							'child_attr_code'     => 'ECLN',           		
							'is_mandatory'		  => 0,
							'allow'				  => 'x200',
							'attr'				  => [ 'class'=> ' w_300']
						),
				    
				    							       
				    '_ET' => array(						  
							'field_name' 		  => 'Entities',
							'field_id'			  => 'ea_value',						
							'child_table'         => 'eav_addon_text', 	
							'parent_field_id'     => 'parent_id',    		
							'child_attr_field_id' => 'ea_code',   		
							'child_attr_code'     => 'ECDT',
							'attr'				  => [ 'class'=> ' w_400','rows'=>5,'style'=>'height:200px !important'],					
						    'type'         		  => 'list_left_right',
							'option_is_quick_search'=>1, 
						    'is_mandatory' 		  =>  1
						),
						
					'_IL' => array(						  
							'field_name' 		  => 'Is Core Library Module',
							'field_id'			  => 'ea_value',						
							'child_table'         => 'eav_addon_bool', 	
							'parent_field_id'     => 'parent_id',    		
							'child_attr_field_id' => 'ea_code',   		
							'child_attr_code'     => 'GPIL',
							'attr'				  => [ 'value'=> 1],					
						    'type'         		  => 'hidden',
							'option_is_quick_search'=>1, 
						    'is_mandatory' 		  =>  1
						),	
				    
				   ),
		     
			'table_name'    => 'entity_child',
			            
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
								
			'back_to'  => array( 'is_back_button' =>1),
                                
			'prime_index'   => 1,
			
			'is_cc'=>1
			      
                    );
    
    # Edit
    
    if(@$_GET['key']){		
		/* $F_SERIES['data'][1]['input_html'] = ' readonly';		
		$F_SERIES['data'][2]['input_html'] = ' readonly';
		$F_SERIES['data'][3]['input_html'] = 'class="w_100" readonly';	 */	
    } 
 
    // after add update
    
    function after_add_update($key_id){
      
		global $rdsql;
		
		$param   = $_POST;
		
		$entity_group_id  = $key_id;

			
		$current_items = explode(',',$param['X_ET']);
		
		$new_item_text = '';
			
		$delete_existing_query="DELETE FROM
						eav_addon_entity_code
					WHERE
						eav_addon_entity_code.parent_id=$entity_group_id AND ea_code='GPEN'";
		
		
		$rdsql->exec_query($delete_existing_query,'Entity grouping delete');
		
		foreach ($current_items as &$item){				
			$new_item_text.="($entity_group_id,'GPEN','$item'),";
		}
		
		// if new item there
		
		if(strlen($new_item_text)>0){
			
				$new_item_text=substr($new_item_text,0,-1);
			
				$new_item_query = "INSERT INTO
							eav_addon_entity_code (parent_id,ea_code,entity_code)
						values
							$new_item_text";
							
							
				$rdsql->exec_query($new_item_query,"Entity grouping insert");
			
		} // end
	
      
   } // end
    
    
?>