<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $F_SERIES	=	array(
				'title'	=>'EAV DB',
				
                                'table_name'    => 'entity_child',
				
				'key_id'        => 'id',
				
				'default_fields'    => array('entity_code' => "'IM'"),
				
                                
				'data'		      =>array('1' =>array( 'field_name'=> 'XML File',
							                                                        
									    'field_id' => 'ea_value',
									       
									    'type' => 'file',
									       
									    'upload_type' => 'docs',
									    
									    'save_file_name_prefix'=> 'entity_export_',
								    
									    'allow_ext'   => array('xml'),
									    
									    'max_size'    => 5000,
								    
									    'location'    => 'doc/',
									    
									     'child_table'         	=> 'eav_addon_varchar', 	
								       
									    'parent_field_id'     	=> 'parent_id',    		
											       
									    'child_attr_field_id' 	=> 'ea_code',   		
								       
									    'child_attr_code'     	=> 'IMFL',
									       
									    'is_mandatory'		=>0,
									       
									    'is_mandatory'=>0,
									       
									    'input_html'=>'class="w_200"',
															
								       )
							),
				
				'is_user_id'       => 'user_id',
				
				# Communication
				
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?dx=demo__eav', 'BACK_NAME'=>'Back'),
                                
				'flat_message'	=> 'Successfully Added',
				
				'show_query'  => 1,
				
				'after_add_update' =>1,
				
				'avoid_trans_key_direct'=>1,
								
                                
			);
    
	
				$F_SERIES['after_add_update'] =function($key_id){
		    
							global $G,$rdsql,$USER_ID;
					
							$lv    = [];							
							$default = ['query_block_limit'=>64];
							
							$lv['model_xml'] = $G->get_one_cell(['table'=>'entity_child',
																'field'=>"get_eav_addon_varchar(id,'IMFL')",
																'manipulation'=> " WHERE id=$key_id"
																]);
							
							$xml = simplexml_load_file($lv['model_xml']);
							
								 // Check of codes id
								 if(is_object($xml->codes)){
									 
									// id of entity_code
									function xml_attribute_value($object, $attribute)
									{
										if(isset($object[$attribute]))
											return (string) $object[$attribute];
									}
									
								    $lv['codes_attibute_value']= xml_attribute_value($xml->codes, 'id');
								
									// remove existing entity_child
									$rdsql->exec_query("DELETE from entity_child WHERE entity_code='".$lv['codes_attibute_value']."'",'Remove entity_child');
									
									
									} // end of attribute codes  
									
								 if(is_object($xml->ec)){
									
									foreach($xml->ec as $ec_idx=>$ec){	
												
												$ec->id=$ec->id.'';
												$ec->code=$ec->code.'';
												$ec->line_order=$ec->line_order.'';
																				
										// insert entity_child
											$lv['entity_child']=[];
											
											array_push($lv['entity_child'],"'$ec->code'");
											array_push($lv['entity_child'],"'$ec->line_order'");
											array_push($lv['entity_child'], $USER_ID);
											
											//inert into entity_child
											$rdsql->exec_query("INSERT INTO entity_child(entity_code,line_order,user_id) VALUES(".implode($lv['entity_child'],',').")",'insert entity_child'); 
											
											//get last_insert_id											
									        $lv['ec_id']    = $rdsql->last_insert_id('entity_child');
											
											$lv['varchar']=[];
										
										// each atrribute
										if(is_object($ec->varchar->vc)){
										
											foreach($ec->varchar->vc as $vc_idx => $vc){
											    $lv['ec_key_value']=(array)$vc;
                                                $lv['ec_values']=array_values($lv['ec_key_value']);
												array_unshift($lv['ec_values'],$lv['ec_id']);
												//array_with_string
												$lv['array_with_string']=array_map(function($val){return sprintf("'%s'", $val);}, $lv['ec_values']);
												$lv['ec_values_text']= "(".implode(",",$lv['array_with_string']).')';
												// passing entity_child values
												array_push($lv['varchar'],$lv['ec_values_text']);	
                                                 												
											}
												
											//check varchar
											if($lv['varchar']){
												
												$lv['varchar_query_values']=implode(",",$lv['varchar']);
																								
												$lv['varchar_insert_query'] = "INSERT INTO exav_addon_varchar(parent_id,exa_token,exa_value,user_id)
																		        VALUES $lv[varchar_query_values]";
																												
												$rdsql->exec_query($lv['varchar_insert_query'],"ec query");
													
													
													
											} // end of varchar
																							
										} // each attribute
																						
									} // has attribute
																												
								} // each entity_child
								
								
											
						}//end
						
						
					
	?>
	
	