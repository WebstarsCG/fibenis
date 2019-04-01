<?PHP
     
     use GuzzleHttp\Client;
				
     use GuzzleHttp\Query;

     $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Page Layout',
				
				#Table field
                    
				'data'	=>   array(
						   
						   '1' =>array( 'field_name'=> 'Basic',
							        
								'type'=>'heading'),
						   
						   '8' =>array( 'field_name'=> 'Theme',
                                                               
                                                               'field_id' => 'parent_id',
                                                               
                                                               'type' => 'option',
                                                               
                                                               'option_data'=>$G->option_builder('entity_child_base','id,sn'," WHERE entity_code='TH' AND parent_id IS NULL ORDER BY sn"),
                                                               
                                                               'is_mandatory'=>1,
							       
							       'avoid_default_option'=>0,
                                                               
                                                               'input_html'=>'class="w_150"'
                                                            
                                                               ),
						   
//						   
//						   '2' =>array( 'field_name'=> 'Entity',
//                                                               
//                                                               'field_id' => 'entity_code',
//                                                               
//                                                               'type' => 'option',
//                                                               
//                                                               'option_data'=>$G->option_builder('entity','code,sn'," WHERE code='PL' "),
//                                                               
//                                                               'is_mandatory'=>1,
//							       
//							       'avoid_default_option'=>1,
//                                                               
//                                                               'input_html'=>'class="w_150"'
//                                                            
//                                                               ),
                                                   
                                                  
						   '3' =>array('field_name'=>'Token',
                                                               
                                                               'field_id'=>'token',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
							       'allow'=>'w32[_]',
							       
                                                               'input_html'=> ' class="w_150" '
                                                               
                                                               ),
                                                   
						   '4' =>array('field_name'=>'Name',
                                                               
                                                               'field_id'=>'sn',
                                                               
                                                               'type'=>'text',
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_200"'
                                                               
                                                               ),
						
						   
						   '5' =>array('field_name'=>'Note',
                                                               
                                                               'field_id'=>'ln',
                                                               
                                                               //'type'=>'text',
							       
							       'type'=>'textarea',
                                                               
                                                               'is_mandatory'=>0,
                                                               
                                                               'input_html'=>' class="w_300" rows=3'
                                                               
                                                               ),
						   
						   
						  '6' =>array( 'field_name'=> 'Content',
							         'type'=>'heading'),
							   												
						   '7' =>array(  'field_name'          => 'Content',                                                                
								'field_id'            => 'note',				       
								'type' 	              => 'code_editor',
								'is_mandatory'        => 0,
								'input_html'          => '  class="w_100" rows=10 ',
                
						   
                                                               ),
						   
						   
                                                   
                                    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child_base',
				
				#Primary Key
                                
			        'key_id'        => 'id',
				
				 "default_fields"=>array("entity_code" => "PL"),
				
				'divider'       => 'tab',
                                
				# Default Additional Column
                                
				'is_user_id'       => 'user_id',
								
				# Communication
								
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=page_layout', 'BACK_NAME'=>'Back'),
                                
				'prime_index'   => 4,
                                
				# File Include
                                'after_add_update'	=>1,
				
				'avoid_trans_key_direct'=>0,
				
				'page_code'	=> 'FECB',
				
				'before_add_update' => 1,
			);
    
    
    function before_add_update($param){
	  
	  global $G;
	  
	  $parent = $param['X8'];
	  
	  $path   = 	$G->get_one_column([ 'field'       => "token",
					     'table'       => 'entity_child_base',
					     'manipulation'=> "id=$parent"]);
	        
	  
	  $file = get_config('theme_path').'/'.$path.'/template/layout';
	  
	  if (!file_exists($file)) {
	
		mkdir($file, 0777, true);
		
	  }
	
     } 
   				
    # after add update
    
    function after_add_update($key_id){
	 
		  global $rdsql,$G,$LIB_PATH,$PASS_ID;
		  
		  $lv         = [];		  
		  $lv['temp'] = [];
		  
		  $lv['param'] = $_POST;
		  
		  $lib = $LIB_PATH.'/comp/guzzle_rest/vendor/autoload.php';				
		  
		  require_once $lib ;
		  
		   $client = new Client([
		       // You can set any number of default request options.
		       'timeout'  => 2.0,
		  ]);
		   
		  
		    $lv['theme']   = 	$G->get_one_column(['field'       => "token",
						  	    'table'       => 'entity_child_base',
						  	    'manipulation'=> " WHERE id=".$lv['param']['X8'].""]);
	        
		    $lv['req']     = 	json_encode([   'theme_route'	=>	get_config('theme_path').'/'.$lv['theme'].'/',
					    'page_code'         =>      $lv['param']['X3'],
					    'key'               =>      $key_id
					]);
		    
		    $lv['trans_key']=time().rand().$PASS_ID;
		    
		    $lv['temp_req']=$G->encrypt($lv['req'],$lv['trans_key']);
		   
		  		  
		    $node_res = $client->GET($_SERVER["HTTP_HOST"].$_SERVER["SCRIPT_NAME"],['query'=>['t'         => $_GET['f'].'__create_html',
												      'req'       => $lv['temp_req'],
												      'trans_key' => $lv['trans_key']
												    ]
											       ]
					     );
		  
		  
    } // end
    
    if(isset($_GET['default_addon'])){
     
	  $LAYOUT = 'layout_full';
     
	  $parent = $_GET['default_addon'];
	  
	  $find_theme = $rdsql->exec_query("SELECT get_eav_addon_varchar($parent,'ECSN')","Selection Fails");
		
	  $value = $rdsql->data_fetch_row($find_theme);
	    
	  $F_SERIES['data'][8]['option_data'] = $G->option_builder('entity_child_base','id,sn'," WHERE entity_code='TH' AND token = '$value[0]'");
          
	  $F_SERIES['data'][8]['avoid_default_option'] = 1;                                                     
    }

  
?>