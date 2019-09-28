<?PHP

    //F_series definition:
                            
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Manage Defination',
				
				#Table field
                    
				'data'	=>   array(
                                                   '6' =>array( 'field_name'=> 'Base',
                                                               
                                                               'type' => 'heading',
                                                              ),
                                                   
                                                   '1' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity','code,sn'," WHERE code='DF' ORDER by sn ASC"),
                                                               
                                                               'avoid_default_option'=>1,
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_100"'
                                                            
                                                               ),
                                                   
                                                  
						   '2' =>array('field_name'=>'Token',
                                                               
                                                               'field_id'=>'token',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_350"'
                                                               
                                                               ),
                                                   
						   '3' =>array('field_name'=>'Name',
                                                               
                                                               'field_id'=>'sn',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_350"'
                                                               
                                                               ),
						  
												
						   '5' =>array('field_name'=>'Permissions',
                                                               
                                                               'field_id'=>'note',
                                                               
                                                                'type'         => 'list_left_right',
                                                                
                                                                'option_data'  =>'',
                                                                
                                                                'is_mandatory' =>  0,
                                                                
                                                                'input_html'   =>  ' class="w_200" rows="5"  style="height:200px !important"  '
						   
                                                    ),
//                                               
                                                   
                                    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child_base',
				
				#Primary Key
                                
			        'key_id'        =>  'id',
                                
                                # divider
                                
                                'divider'       =>  'tab',
                                
				# Default Additional Column
                                
				'is_user_id'    =>  'user_id',
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=page_addon', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1,
                                
				# File Include
                                'after_add_update'	=>1,
				
				'page_code'	=> 'FECB',
				
                                
			);
    
    
        if(     @$_GET['key']){    before_update(@$_GET['key']);  }
    
        else{   $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',"id,sn","  WHERE entity_code='EG' "); }
    
        // after add update / option builder action
    
    function before_update($key_id){
	
	global $G,$F_SERIES,$rdsql;
	
	if($key_id){
	    
	    
	    
	    # get role id
	    
	    $get_item_id    =    $G->get_one_columm(array('table'	 => 'entity_child_base',
			  				  'field'	 => 'token',
							  'manipulation' => " WHERE  id=$key_id  "
					    ));
	    
	    
	
	    # option prefill data
	    
            $F_SERIES['temp']['option_data']                 = "WHERE  entity_code='PR' AND id NOT IN (SELECT xa_id FROM ecb_xa_matrix WHERE ecb_id=$key_id)";
	    
	    $F_SERIES['data']['5']['option_data']		= $G->option_builder('entity_child_base','id,sn',$F_SERIES['temp']['option_data'].' ORDER BY sn ASC');
	    
            
            # existing
            
	    $F_SERIES['temp']['where_option_existing_data']  = "WHERE ecb_id=$key_id ";
              
            $F_SERIES['data']['5']['option_existing_data']	= $G->option_builder('ecb_xa_matrix','xa_id,(SELECT sn FROM entity_child_base WHERE id=xa_id)',$F_SERIES['temp']['where_option_existing_data'].' ORDER by id ASC');
	    
	    
	} # edit
	
	  
	
    } # end of add update action
    
    
    function after_add_update($key_id){
        
        global $G,$F_SERIES,$rdsql,$USER_ID;
        
        $lv;
        $lv['content']=[];
        
       
                
        
        # empty matrix
        
        $rdsql->exec_query("DELETE FROM ecb_xa_matrix WHERE ecb_id=$key_id","0");
        
        # insert data
        
        $lv['temp_options'] = $_POST['X5'];
       
        if($lv['temp_options']){
        
            foreach(preg_split("/,/",$lv['temp_options']) as $key){
                
                array_push($lv['content'],"($key_id,$key,$USER_ID)");
            }
        } // end
        
        if(count($lv['content'])>0){
            
            $lv['matrix_data'] = implode(',',$lv['content']);
            
            $lv['matrix_query'] = " INSERT INTO ecb_xa_matrix(ecb_id,xa_id,user_id) VALUES $lv[matrix_data] ";
            
            $rdsql->exec_query($lv['matrix_query'],$lv['matrix_query']);
            
        }
        
         before_update($key_id);
        
        
    } # end
    
    
    
?>