<?PHP
    
    $LAYOUT    = 'layout_full';
    
    $parent = @$_GET['default_addon'];
    
    $field = $G->get_one_column(['field'       => "ea_value",
				'table'       => 'eav_addon_text',
				'manipulation'=> " WHERE ea_code='ECDT' AND parent_id = $parent"]);
	        
     $data_count= 0;
     
     foreach(json_decode(stripcslashes($field)) as $key => $value){
		
		if(!empty($value[0])){
		
		    $data_count++;
		}
     }

    $F_SERIES	=	array(
				'title'	=>'Blend',
				
				'data'	=>   array(
						   
						   '1' =>array( 'field_name'=> 'Blend',
                                                               
                                                               'field_id' => 'ec_id',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECLN')"," WHERE id =".$parent),
                                                               
                                                               'is_mandatory'=>1,
							       
							        'child_table'         => 'eav_addon_ec_id', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECPR',           // attribute code
							       
							       'avoid_default_option'=>1,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                            
                                                               ),
						   
						   
						     '2' =>array('field_name'=>'File name',
                                                               
                                                               'type'=>'text',
							       
							       'field_id'=>'ea_value',
                                                               
							       'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECSN',           // attribute code
							       
							       'is_mandatory'=>1,
							       
							       'allow'     => 'w50[_]',
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
                                                   
                                                    '3' =>array('field_name'=>'Name',
                                                               
                                                               'type'=>'text',
                                                               
							       'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECLN',           // attribute code
							       
							       'allow'     => 'w32[ ]',
                                                               
							       'input_html'=>'class="w_200"',
							       
							       'is_mandatory'=>0,
                                                               
                                                               ),
						   
						   
						    '4' =>array('field_name'=>'Field',
                                                               
                                                               'type'=>'fibenistable',
							       
								'is_fibenistable'   => 1,
							       
							       'colHeaders'=> array(array(
											    'column'    => 'Field',
											    'width'     => '10',
											    'type'      => 'text',
											    'input_html' => 'readonly'
                                                                                    ),
										    array(
											    'column'    => 'Value',
											    'width'     => '10',
											    'type'      => 'text',
                                                                                    )
										),
                                                            
                                                               
							       'field_id'=>'ea_value',
                                                               
                                                               'child_table'         => 'eav_addon_text', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECDT',           // attribute code
							       
							       'input_html'=>'class="w_100"',
							       
							       'default_data'  => $field,
							       
							       'default_rows_prop'=>array('start_rows'=> $data_count ,'max_row'=>$data_count),
										       
							       'is_mandatory'=>0,
                                                               
                                                            ),
						    
//						    '5' =>array('field_name'=>'Secondary color',
//                                                               
//                                                               'type'=>'text',
//                                                               
//							       'field_id'=>'ea_value',
//                                                               
//                                                               'child_table'         => 'eav_addon_varchar', // child table
//							       
//							       'parent_field_id'     => 'parent_id',    // parent field
//										       
//							       'child_attr_field_id' => 'ea_code',   // attribute code field
//							       
//							       'child_attr_code'     => 'NBPM',           // attribute code
//							       
//							       'allow'     => 'w50[_]',
//                                                               
//							       'input_html'=>'class="w_100"',
//							       
//							       'is_mandatory'=>0,
//                                                               
//                                                               ),
						  
						   
				    
                                ),
                                    
				'table_name'    => 'entity_child',
				
				'key_id'        => 'id',
                                
				'is_user_id'       => 'user_id',
				
				'after_add_update' => 1,
				
				'default_fields'   => array('entity_code' => "'NB'"),
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=create_theme', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 1,
                                
				'page_code'	=> 'FECA',
				
                                
			);
    
    use GuzzleHttp\Client;
     
    use GuzzleHttp\Query;
     	
	  
    $F_SERIES['after_add_update']=function ($key_id){
        
         global $rdsql,$G,$LIB_PATH,$PASS_ID;
	 
		  
		  $lv         = [];
		  
		  $lv['temp'] = [];
		  
		  $lv['param'] = $_POST;
		  
		  $d_a = $_GET['default_addon'];
		  
		  $lib = $LIB_PATH.'/comp/guzzle_rest/vendor/autoload.php';				
		  
		  require_once $lib ;
		  
		  $client = new Client(['timeout'  => 2.0,]);
		   
		    $lv['theme']   	= $G->get_one_column(['field'     => "ea_value",
							    'table'       => 'eav_addon_varchar',
							    'manipulation'=> " WHERE ea_code='ECSN' AND parent_id = get_eav_addon_ec_id($d_a,'ECPR')"]);
	        
		  
		    $lv['file_name']   	= $G->get_one_column(['field'     => "ea_value",
							    'table'       => 'eav_addon_varchar',
							    'manipulation'=> " WHERE ea_code='ECSN' AND parent_id=".$lv['param']['X1'].""]);
	        
		    
		    $lv['req']     	= json_encode([ 'page_code'     =>      $lv['param']['X2'],
							'theme'		=>	$lv['theme'],
							'file_name'	=>	$lv['file_name'],
							'key'           =>      $key_id]);
		    
		    $lv['trans_key']=time().rand().$PASS_ID;
		    
		    $lv['temp_req']=$G->encrypt($lv['req'],$lv['trans_key']);
		   
		    $node_res = $client->GET($_SERVER["HTTP_HOST"].$_SERVER["SCRIPT_NAME"],['query'=>['t'         => $_GET['f'],
												      'req'       => $lv['temp_req'],
												      'trans_key' => $lv['trans_key']
												    ]
											       ]
					     );
		  
	
    } # end
    
     
?>