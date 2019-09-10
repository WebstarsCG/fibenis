<?PHP

    //F_series definition:
                            
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Parent Child',
				
				#Table field
                    
				'data'	=>   array(
                                                   '6' =>array( 'field_name'=> 'Entity Child Base',
                                                               
                                                               'type' => 'heading',
                                                              ),
                                                   
                                                   '1' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                              // 'option_data'=>$G->option_builder('entity','code,sn'," WHERE code='DF' ORDER by sn ASC"),
                                                               
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
                                                               
                                                               'input_html'=>'class="w_350"',
                                                               
                                                             //  'allow'        => 'd10',
                                                               
                                                               ),
						    
                                                    '4' =>array('field_name'=>'Long Name',
                                                               
                                                               'field_id'=>'ln',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>'class="w_350"'
                                                               
                                                               ),
                                                    
												
						   '5' =>array('field_name'=>'Child',
                                                               
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
    
    else{   $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',"id,sn",""); }
    
    // before_update
    
    function before_update($key_id){
	
	global $G,$F_SERIES,$rdsql;
        
	if($key_id){
	    
	    
	    # get role id
	    
	    $get_item_id    =    $G->get_one_columm(array('table'	 => 'entity_child_base',
			  				  'field'	 => 'token',
							  'manipulation' => " WHERE  id=$key_id  "
					    ));	        
	
	    # option prefill data
	    
            $F_SERIES['temp']['option_data']                 = "WHERE id NOT IN (SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE ecb_parent_id=$key_id)";
	    
	    $F_SERIES['data']['5']['option_data']		= $G->option_builder('entity_child_base','id,sn',$F_SERIES['temp']['option_data'].' ORDER BY sn ASC');
	    
            
            # existing
            
	    $F_SERIES['temp']['where_option_existing_data']  = "WHERE ecb_parent_id=$key_id ";
              
            $F_SERIES['data']['5']['option_existing_data']	= $G->option_builder('ecb_parent_child_matrix ','ecb_child_id,(SELECT sn FROM entity_child_base WHERE id=ecb_child_id)',$F_SERIES['temp']['where_option_existing_data'].' ORDER by id ASC');
	    
	    
	} # edit
	
    } # end of add update action
    
    
    // after_add_update
    
    $F_SERIES['after_add_update']=function ($key_id){
        
        global $G,$F_SERIES,$rdsql,$USER_ID;
        
        $lv;
        $lv['content']=[];
                
        # empty matrix
        
        $rdsql->exec_query("DELETE FROM ecb_parent_child_matrix WHERE ecb_parent_id=$key_id","0");
        
        # insert data
        
        $lv['temp_options'] = $_POST['X5'];
       
        if($lv['temp_options']){
        
            foreach(preg_split("/,/",$lv['temp_options']) as $key){
                
                array_push($lv['content'],"($key_id,
                                            $key,
                                            md5(concat((SELECT token FROM entity_child_base WHERE id=$key_id),'__',
                                            (SELECT token FROM entity_child_base WHERE id=$key))),
                                            $USER_ID)");
            }
            
        } // end
        
        if(count($lv['content'])>0){
            
            $lv['matrix_data'] = implode(',',$lv['content']);
            
            $lv['matrix_query'] = " INSERT INTO ecb_parent_child_matrix(ecb_parent_id,ecb_child_id,parent_child_hash,user_id) VALUES $lv[matrix_data] ";
            
            $rdsql->exec_query($lv['matrix_query'],$lv['matrix_query']);
            
        } // end
        
        before_update($key_id);       
        
    } # end
    
    
    
?>