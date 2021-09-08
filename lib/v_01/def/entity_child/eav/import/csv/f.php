<?PHP

    $LAYOUT	    = 'layout_basic';
    
    $F_SERIES	=	array(
	
	
				'title'	=>'EAV DB',
				
                    'table_name'    => 'entity_child_base',
				
				'key_id'        => 'id',
				
				'default_fields'    => array('entity_code' => "'IM'"),
				
                                
				'data'		      =>array('1' =>array( 'field_name'=> 'CSV File',
							                                                        
									    'field_id' => 'ea_value',
									       
									    'type' => 'file',
									       
									    'upload_type' => 'docs',
									    
									    'save_file_name_prefix'=> 'entity_chid_base_export_',
								    
									    'allow_ext'   => array('csv'),
									    
									    'max_size'    => 5000,
								    
									    'location'    => 'doc/',
									    
									    'child_table'         	=> 'ecb_av_addon_varchar', 	
								       
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
				
				'show_query'  => 0,
				
				'after_add_update' =>1,
				
				'avoid_trans_key_direct'=>1,
				
                                
			);
    
	
				$F_SERIES['after_add_update'] =function($key_id){
		    
								global $G,$rdsql,$USER_ID;
						
								$lv    = [];
								
								$lv['field_map']['primary']    = ['token'	  => 2,
														    'sn'	 	  => 1,
														    'ln'		  => 1,
														    'line_order' => 8];
							
									
								$lv['field_map']['addon'] = ['APIT'		=> 3,
														'APAL'		=> 4,
														'APCL'		=> 5,
														'APMA'		=> 6,
														'APHT'		=> 7];
								
								$lv['field_map']['net']		= array_merge($lv['field_map']['primary'],
																	$lv['field_map']['addon']);
								
								$lv['attributes']	= [];
								
								
								$default = ['query_block_limit'=>64];
								
								$lv['csv_model'] 	= $G->get_one_cell(['table'=>'entity_child_base',
																	'field'=>"get_ecb_av_addon_varchar(id,'IMFL')",
																	'manipulation'=> " WHERE id=$key_id"
																	]);
								
								$lv['entity_attribute_content'] = fopen($lv['csv_model'],"r");
								
								// entity detail
								$lv['entity_head']	  		  		    = fgetcsv($lv['entity_attribute_content']);
								$lv['entity_detail']  		  		    = fgetcsv($lv['entity_attribute_content']);
								
								
								list($lv['entity_code'],$lv['entity_name']) = $lv['entity_detail'];
								
								// entity clear up
							//	$rdsql->exec_query("DELETE from entity_child WHERE entity_code='$lv[entity_code]'",'Remove entity_child');
								$rdsql->exec_query("DELETE from entity_child_base WHERE entity_code='$lv[entity_code]'",'Remove entity_child_bae');
								$rdsql->exec_query("DELETE from entity WHERE code='$lv[entity_code]'",'Remove entity');
								
								// entity insert
								$rdsql->exec_query("INSERT INTO entity(code,sn,is_lib,user_id) VALUES('$lv[entity_code]','$lv[entity_name]',0,$USER_ID)",'insert entity');
																				
								
								// attribute detail
								$lv['entity_attribute_head']	  = fgetcsv($lv['entity_attribute_content']);
																								// each line
								while(!feof($lv['entity_attribute_content'])){
									
									$lv['entity_attribute']	  = fgetcsv($lv['entity_attribute_content']);
									
									if(@$lv['entity_attribute'][0]){
																		
										$lv['param']	= [];
										
										foreach($lv['field_map']['net'] as $token => $col_index){
											
												$lv['param'][$token] = $lv['entity_attribute'][$col_index];
										}
																				
										array_push($lv['attributes'],$lv['param']);
										
									} // set
									
								
								} // end of line
								
								
								add_external_attribute($lv['entity_code'],
												   $lv['attributes'],
												   ['g'		=>$G,
												    'rdsql'	=>$rdsql,
												    'user_id'	=>$USER_ID,
												    'addon_cols'=>$lv['field_map']['addon']]);
												  
								
								// close 
								fclose($lv['csv_model']);
				}; // end
				
				
				// external 
				function add_external_attribute($entity,$attributes,$addon){
					
						$lv = [];	
					
						// each atrribute
						foreach($attributes as $token => $attr){
											
								$lv['attr_query'] 		= "INSERT INTO
															entity_child_base(entity_code,
															                  token,sn,ln,
																		   line_order,dna_code,created_by,user_id)
															VALUES
															('$entity','$attr[token]','$attr[sn]','$attr[ln]','$attr[line_order]','EBAT',$addon[user_id],$addon[user_id])";
																																																
								$addon['rdsql']->exec_query($lv['attr_query'],'ecb');
																																																								
								$lv['ecb_id']    		= $addon['rdsql']->last_insert_id('entity_child_base');
								
								$lv['addon_query_text']  = '';
								
								// addon cols
								foreach($addon['addon_cols'] as $col_token => $col_index){									
											
									$lv['addon_query_text'].="($lv[ecb_id],'$col_token','$attr[$col_token]',$addon[user_id]),";
									
								} // col
								
								if($lv['addon_query_text']){
																												
									$lv['addon_query_text_neutral']=substr($lv['addon_query_text'],0,-1);
												
									$lv['addon_query'] = "INSERT INTO
																ecb_av_addon_varchar(parent_id,ea_code,ea_value,user_id)
									                             VALUES
																$lv[addon_query_text_neutral]";
												
									$addon['rdsql']->exec_query($lv['addon_query'],"ecb varchar");
												
								} // addon attribute query
								
						} // for
					
				} // end
?>