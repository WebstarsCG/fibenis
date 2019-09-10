<?PHP
    
    $sec_id = $_GET['default_addon'];
    
    $LAYOUT	    = 'layout_full';
                            
    $F_SERIES	=	array(
				#Title
				
				'title'	=>'Section Template',
				
				#Table field
                    
				'data'	=>   array(
				    
						    '1' =>array( 'field_name'=> 'Page ',
                                                               
								'field_id' => 'child_comm_id',
                                                               
								'type' => 'option',
								
								'option_data'=>$G->option_builder("eav_addon_varchar","parent_id,ea_value","WHERE ea_code='ECSN' AND parent_id=".$sec_id),
                                                               
								'avoid_default_option' => 1,
								
								'is_mandatory'=>1,
								
								'input_html'=>'class="w_150"',
								
                                                               
                                                             ),
						    
						    '2' =>array( 'field_name'=> 'Template ',
                                                               
								'field_id' => 'note',
                                                               
								'type' => 'option',
								
								'option_data'=>$G->option_builder("entity_child_base","token,sn","WHERE entity_code='SC' ORDER BY sn ASC"),
                                                               
								'avoid_default_option' => 0,
								
								'is_mandatory'=>1,
								
								'input_html'=>'class="w_150"',
								
								//'attr' => ['data-update-prefill-off' => 1,
								//	    'class' => 'w_150'],
								//				  
                                                               
                                                             ),
						   
					    ),
				
                                    
				'table_name'    => 'status_info',
				
				'key_id'        => 'id',
				
				'is_user_id'       => 'user_id',
				
				'back_to'  => NULL,
				
				'default_fields'    => array('status_code' => "'PGTM'",
							    'entity_code' => "'PG'",),
                                
				'show_query' => 1,
                               				
				'flat_message' => 'Sucesssfully Updated',
				
				'show_query'    =>0,
				
				'after_add_update'=>1,
                                
			);
    
     function after_add_update($key_id){
	
	    global $rdsql,$USER_ID,$G;
	    
	    $sec_id = $_GET['default_addon'];
    
	    $tmpl = $_POST['X2'];
	    
	    $insert = "INSERT INTO eav_addon_exa_token (parent_id,ea_code,exa_value_token,user_id) VALUES ($sec_id,'PGTM','$tmpl',$USER_ID)";
	    
	    $update = "UPDATE eav_addon_exa_token SET exa_value_token = '$tmpl' WHERE parent_id = $sec_id AND ea_code='PGTM'";
	    
	    $no_row = $G->table_no_rows( array('table_name'=>'eav_addon_exa_token',
                                           'WHERE_FILTER'=>"AND ea_code = 'PGTM' AND parent_id=$sec_id"
                                           ));
	
	
	    if($no_row[0]==0){	
	
		$update = $rdsql->exec_query($insert,"Section template insert Failed");
	    
	    }else{
		
		$update = $rdsql->exec_query($update,"Section template update Failed");
	    
	    }
	    
	    return null;	
		
    } 
?>