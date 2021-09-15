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
				
				'show_query'  => 0,
				
				'after_add_update' =>1,
				
				'avoid_trans_key_direct'=>1,
								
                                
			);
			
			 // id of entity_code
			function xml_attribute_value($object, $attribute){
				if(isset($object[$attribute]))
					return (string) $object[$attribute];
			}// end of id of entity_code
			
			// entity child addon
			function entity_child_addon($addon_type,$addon,$ec_id){	
			    global $rdsql;
				print_r($addon_type);
				$lv = [];	
				$lv['varchar'] = [];	
				$lv['query_rows']=[];
				$lv['addon'] = (array)$addon;
				$lv['addon_temp']=array_shift($lv['addon']);
				if($addon_type == 'DT'){
				$lv['addon_map']=['DT'=>['value_fields'=>['parent_id','token','value','user_id'],
										 'table_name'  =>'exav_addon_date',
										 'table_fields'=>['parent_id','exa_token','exa_value','user_id']									 
										] // DT end
								 ]; // addon_map end
				}
				$lv['addon_map']=['vc'=>['value_fields'=>['parent_id','token','value','user_id'],
				                         'table_name'  =>'exav_addon_varchar',
										 'table_fields'=>['parent_id','exa_token','exa_value','user_id']									 
										] // vc end
								 ]; // addon_map end
				$lv['addon_map_info']=$lv['addon_map'][$addon_type];
				print_r($lv['addon_map_info']);
				//array of object to get values
				foreach($lv['addon'] as $key => $rows){
					//array of array to array
					foreach($rows as $rows_idx=>$rows_value){
					   // get values of array 
					   $lv['rows_cols']=(array)$rows_value;
                       $lv['rows_cols']['parent_id']=$ec_id;		
					   $lv['cols']=[];
					   foreach($lv['addon_map_info']['value_fields'] as $val_fields_key => $val_fields_value){
							// print_r($value_fields);
							 //array_push($lv['cols'],$val_fields_value);
							 array_push($lv['cols'],sprintf("'%s'", $lv['rows_cols'][$val_fields_value]));							
						}		 						
						$lv['rows_values_text']= "(".implode(",",$lv['cols']).')';
						array_push($lv['query_rows'],$lv['rows_values_text']);	
					}
				}// end of foreach				
				// check varchar to insert query
			if($lv['query_rows']){
					$lv['query_row_values']=implode(",",$lv['query_rows']);
					$lv['query_row_field_values']="(".implode(",",$lv['addon_map_info']['table_fields']).")";
					$lv['insert_query'] = "INSERT INTO ".$lv['addon_map_info']['table_name']." $lv[query_row_field_values]
													VALUES $lv[query_row_values]";	
				//	print_r($lv['insert_query']);
					$lv['insert_query_result']=$rdsql->exec_query($lv['insert_query'],"ec query");
				}// end of varchar 			
					return $lv['insert_query_result'];
			}// end of entity child addon function	
				 
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
											$lv['varachar']=[];
											//get last_insert_id		
									        $lv['ec_id']    = $rdsql->last_insert_id('entity_child');			
										// each atrribute
										if(is_object($ec->varchar)){
											entity_child_addon('vc',$ec->varchar,$lv['ec_id']);																					
										} // each attribute 
										if(is_object($ec->date)){
											entity_child_addon('DT',$ec->date,$lv['ec_id']);																					
										} // each attribute																					
									} // has attribute
																												
								} // each entity_child							
											
						}//end
		
			
	?>
	
	