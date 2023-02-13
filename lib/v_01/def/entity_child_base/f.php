<?PHP

    //F_series definition:
                            
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Entity Child Base',
				
				#Table field
                    
				'data'	=>   array('1' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity','code,sn',' ORDER by sn ASC'),
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_100"',
                                                               
                                                               'avoid_default_option' => 0,
                                                            
                                                               ),
                                                   
                                                    '8' =>array('field_name'=>'Parent',
                                                               
                                                               'field_id'=>'parent_id',
                                                               
                                                               'type'=>'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity_child_base','id,sn',' ORDER by sn ASC'),
                                                                                                                        
                                                               'option_default'=> array('label'=>'Select Parent','value'=>0),
                                                               
                                                               'input_html'=>'class="w_200"'                                                               
                                                               ),
                                                  
						   '2' =>array('field_name'=>'Token',
                                                               
                                                               'field_id'=>'token',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'allow'     => 'x30',
                                                               
                                                               'input_html'=>'class="w_200"',
                                                               
                                                               'input_html'=>'onchange="check_token(this);"',
                                                               
                                                               ),
                                                   
						   '3' =>array('field_name'=>'Short Name',
                                                               
                                                               'field_id'=>'sn',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'allow'     => 'x50',
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
						   

						   
						   
						   '4' =>array('field_name'=>'Long Name',
                                                               
                                                               'field_id'=>'ln',
                                                               
                                                               'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'allow'     => 'x1000',
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
						   
						    '5' =>array('field_name'=>'DNA',
                                                               
                                                               'field_id'=>'dna_code',
                                                               
                                                               'type'=>'option',
                                                       
                                                               'option_data'=>$G->option_builder('entity_child_base',
                                                                                                 'token,sn',
                                                                                                 " WHERE entity_code='EB' AND  dna_code='EBMS' AND token IN ('EBUC','EBMS','EBAX','EBFA') ORDER by sn ASC"
                                                                                            ),                                                               
                                                               
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>' class="w_350"'
						   
                                                               ),
                                                     
                                                     
						   '6' =>array('field_name'=>'Note',
                                                               
                                                               'field_id'=>'note',
                                                               
                                                               'type'=>'textarea',
							       
							       'is_mandatory'=>0,
                                                               
                                                               'input_html'=>' class="w_300"'
						   
                                                               ),
                                                   
                                                   
                                                   '9' =>array('field_name'=>'Line order',
                                                               
                                                               'field_id'=>'line_order',
                                                               
                                                               'type'=>'text',
							       
							       'allow'=>'d5[.]',
                                                               
                                                               'input_html'=>' class="w_50"'
						   
                                                               ),
															   
								    '10' =>array('field_name'=>'Active',
                                                               
                                                               'field_id'=>'is_active',
                                                               
                                                               'type'=>'toggle',
							       
																'on_label'            => 'Active',
                                                                'off_label'            => 'Inactive',
                                                                'show_status_label'  => 1,
						   
                                                               ),
                                                   
                                                   
                                                   
                                    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child_base',
				
				#Primary Key
                                
			        'key_id'        => 'id',
                                
				# Default Additional Column
                                
				'is_user_id'       => 1,
                                
                                'is_created_by'    => 1,
								
				# Communication
				
                                'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child_base', 'b_name' => 'Add Entity child' ),
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_child_base', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 2,
                                
				# File Include
                                'after_add_update'	=>0,
                                
                                'js'=> ['is_top'=>1,'top_js'=>$LIB_PATH.'def/entity_child_base/f'],
                                
                                'show_query'=>0,
                                'avoid_trans_key_direct'=>0,
								
								'is_cc'=>1
				
				
                                
			);
    
    // disable parent
    unset($F_SERIES['data'][8]);
    
    if(isset($_GET['default_addon'])){  
	
		$default_addon = $_GET['default_addon'];
		$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn',"WHERE code ='$default_addon'");
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
                $F_SERIES['back_to']['is_back_button'] = 1;
                $F_SERIES['back_to']['back_menu_off']=@$_GET['menu_off'];
				$F_SERIES['back_to']['back_default_addon']=@$_GET['default_addon'];
		
                $F_SERIES['add_button']['is_add'] = 0;
                $LAYOUT	    = 'layout_full';
                
                // line order & not update
		if(!@$_GET['key']){		   
		   $temp['where']=(@$default_addon)?"WHERE entity_code='$default_addon' AND dna_code <> 'EBAT' ":''; 
		   $temp['line_order_value']=($G->get_count(['table'=>'entity_child_base','where'=>$temp['where']])+1);
		   $F_SERIES['data']['9']['input_html']=" class='w_50' value='$temp[line_order_value]'";  
		}
    }
    
     
    $F_SERIES['after_add_update']=function ($key_id){
        
        global $G,$F_SERIES,$rdsql,$USER_ID;
        
        $lv;
        $lv['content']=[];
                
        # empty matrix
        
        $rdsql->exec_query("DELETE FROM ecb_parent_child_matrix WHERE ecb_child_id=$key_id","0");
        
        # insert data
        
        $lv['parent_id'] = $_POST['X8'];
        $lv['child_id']  = $key_id;
       
        if($lv['parent_id']){
        
                array_push($lv['content'],"($lv[parent_id],
                                            $lv[child_id],
                                            md5(concat((SELECT token FROM entity_child_base WHERE id=$lv[parent_id]),'__',
                                            (SELECT token FROM entity_child_base WHERE id=$lv[child_id]))),
                                            $USER_ID)");
            
        } // end
        
        if(count($lv['content'])>0){
            
            $lv['matrix_data'] = implode(',',$lv['content']);
            
            $lv['matrix_query'] = " INSERT INTO ecb_parent_child_matrix(ecb_parent_id,ecb_child_id,parent_child_hash,user_id) VALUES $lv[matrix_data] ";
            
            $rdsql->exec_query($lv['matrix_query'],$lv['matrix_query']);
            
        } // end
            
        
    } # end
     
?>