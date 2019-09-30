<?PHP

     $LAYOUT = 'layout_full';
     
     $parent = @$_GET['default_addon'];

     $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Theme Blend',
				
				#Table field
                    
				'data'	=>   array(
						   
						//   '1' =>array( 'field_name'=> 'Basic',
						//	        
						//		'type'=>'heading'),
						//   
						   
						   '2' =>array( 'field_name'=> 'Theme',
                                                               
                                                               'field_id' => 'ec_id',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECLN')"," WHERE entity_code='TH' AND id =".$parent),
                                                               
                                                               'is_mandatory'=>1,
							       
							        'child_table'         => 'eav_addon_ec_id', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECPR',           // attribute code
							       
							       'avoid_default_option'=>1,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                            
                                                               ),
						   

						  '3' =>array('field_name'=>'File name',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
							       'allow'=>'w32[_]',
							       
							        'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECSN',           // attribute code
							       
							       'input_html'=> ' class="w_150" '
                                                               
                                                               ),
                                                   
						   '4' =>array('field_name'=>'Name',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
							       
							        'child_table'         => 'eav_addon_varchar', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECLN',           // attribute code
							       
                                                               'input_html'=>'class="w_150"'
                                                               
                                                               ),
						   
						   '5' =>array('field_name'=>'Field',
                                                               
                                                               'field_id'=>'ea_value',
                                                               
                                                               'type'=>'fibenistable',
							       
								'is_fibenistable'   => 1,
								
								'is_index'	=>1 ,
							       
							       'colHeaders'=> array(array(
											    'column'    => 'Field',
											    'width'     => '10',
											    'type'      => 'text',
                                                                                    )
										),
                                                            
                                                               
                                                               'is_mandatory'=>0,
							       
							        'child_table'         => 'eav_addon_text', // child table
							       
							       'parent_field_id'     => 'parent_id',    // parent field
										       
							       'child_attr_field_id' => 'ea_code',   // attribute code field
							       
							       'child_attr_code'     => 'ECDT',           // attribute code
							       
                                                               'input_html'=>'class="w_100"'
                                                               
                                                               ),
						
						   
						'6' =>array( 'field_name'=> 'LESS File',
							                                                        
								    'field_id' => 'ea_value',
								       
								    'type' => 'file',
								       
								    'upload_type' => 'docs',
								    
								    'allow_ext'   => array('less'),
								    
								    'max_size'    => 1024,
							    
								    'child_table'         	=> 'eav_addon_varchar', 	
							       
								    'parent_field_id'     	=> 'parent_id',    		
										       
								    'child_attr_field_id' 	=> 'ea_code',   		
							       
								    'child_attr_code'     	=> 'ECIA',
								       
								    'is_mandatory'		=>0,
								       
								    'input_html'=>'class="w_200"',
							                                                        
							       ),
							   												
						//   '7' =>array(  'field_name'          => 'Content',                                                                
						//		
						//		 'field_id'            => 'ea_value',
						//		 
						//		 'type' 	       => 'code_editor',
						//		 
						//		 'is_mandatory'        => 0,
						//		 
						//		 'child_table'         => 'eav_addon_text', // child table
						//	       
						//		 'parent_field_id'     => 'parent_id',    // parent field
						//				       
						//		 'child_attr_field_id' => 'ea_code',   // attribute code field
						//		 
						//		 'child_attr_code'     => 'ECDT',           // attribute code
						//		 
						//		 'input_html'          => '  class="w_100" rows=10 ',
						//          
						//   ),
						   
						   
                                                   
                                    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child',
				
				#Primary Key
                                
			        'key_id'        => 'id',
				
				 "default_fields"=>array("entity_code" => "BE"),
				
				'divider'       => 'tab',
                                
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=theme__blend_source', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 4,
                                
				# File Include
                                'after_add_update'	=>0,
				
				'before_add_update'	=> 1,
				
				'avoid_trans_key_direct'=>1,
				
				'page_code'	=> 'FECB',
			);
    
     #before add update
     function before_add_update($param){
	  
	  global $G,$LIB_PATH,$F_SERIES;
	  
	  $parent = @$_GET['default_addon'];
	  
	  $path   = 	$G->get_one_column(['field'       => "ea_value",
					'table'       => 'eav_addon_varchar',
					'manipulation'=> " WHERE ea_code='ECSN' AND parent_id=$parent"]);
	        
	  
	  $F_SERIES['data'][6]['location'] = get_config('theme_path').'/'.$path.'/blend/source/';
		
		
	  //$F_SERIES['data'][6]['location'] = $LIB_PATH.'def/create_theme/template/'.$path.'/';
	  
	  $F_SERIES['data'][6]['save_file_name'] = $param['X3'];
	  
     }

     /*
     
     use GuzzleHttp\Client;
     
     use GuzzleHttp\Query;
     
     # after add update
     function after_add_update($key_id){
	 
		  global $rdsql,$G,$LIB_PATH,$PASS_ID;
		  
		  $lv         = [];		  
		  $lv['temp'] = [];
		  
		  $lv['param'] = $_POST;
		  
		  $lib = $LIB_PATH.'/comp/guzzle_rest/vendor/autoload.php';				
		  
		  require_once $lib ;
		  
		   $client = new Client([
		       'timeout'  => 2.0,
		  ]);
		   
		  
		    $lv['theme']   = 	$G->get_one_column(['field'       => "ea_value",
						  	    'table'       => 'eav_addon_varchar',
						  	    'manipulation'=> " WHERE ea_code='ECSN' AND parent_id=".$lv['param']['X2'].""]);
	        
		    
		    $lv['req']     = 	json_encode([  'blend_route'	=>	$LIB_PATH.'/def/create_theme/template/'.$lv['theme'].'/',
						       'page_code'      =>      $lv['param']['X3'],
						       'key'            =>      $key_id
					]);
		    
		    $lv['trans_key']=time().rand().$PASS_ID;
		    
		    $lv['temp_req']=$G->encrypt($lv['req'],$lv['trans_key']);
		   
		  		  
		    $node_res = $client->GET($_SERVER["HTTP_HOST"].$_SERVER["SCRIPT_NAME"],['query'=>['t'         => $_GET['f'],
												      'req'       => $lv['temp_req'],
												      'trans_key' => $lv['trans_key']
												    ]
											       ]
					     );
		  
		  
    } // end
    
 */
        if(isset($_GET['default_addon'])){  
	
	       //$F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
		
		$F_SERIES['back_to']['is_back_button'] = 1;
                $F_SERIES['back_to']['back_menu_off']=@$_GET['menu_off'];
		$F_SERIES['back_to']['back_default_addon']=@$_GET['default_addon'];
		
		$LAYOUT	    = 'layout_full';

	}
?>