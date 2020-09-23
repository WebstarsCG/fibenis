<?PHP

    include_once($LIB_PATH."/inc/lib/f_addon.php");
                        
    $F_SERIES	=	array(
				#Desk Title
				
				'title'	=>'Entity Child',
				
				#Table field
                    
				'data'	=>   array(
//						   
//						    '1' =>array( 'field_name'=> 'Basic',
//                                                               
//                                                               'field_id' => 'basic',
//                                                               
//                                                               'type' => 'heading',
//                                                               
//                                                               //'option_data'=>$G->option_builder('entity','code,sn'," ORDER by sn ASC "),
//                                                               
//                                                               'is_mandatory'=>1,
//                                                               
//                                                               'input_html'=>'class="w_100"',
//                                                               
//                                                               'avoid_default_option' => 0
//                                                               
//                                                               ),
						    
						   
						   '2' =>array( 'field_name'=> 'Entity',
                                                               
                                                               'field_id' => 'entity_code',
                                                               
                                                               'type' => 'option',
                                                               
                                                               //'option_data'=>$G->option_builder('entity','code,sn'," ORDER by sn ASC "),
                                                               
                                                               'is_mandatory'=>1,
                                                               
                                                               'input_html'=>'class="w_100"',
                                                               
                                                               'avoid_default_option' => 0,
							       
							       
                                                               
                                                               )
						
				    
                                ),
                                    
				#Table Name
				
				'table_name'    => 'entity_child',
				
				#Primary Key
                                
			        'key_id'        => 'id',
					
                                
				# Default Additional Column
                                
				'is_user_id'       => 1,
								
				# Communication
								
				'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child', 'b_name' => 'Add Entity child' ),
                     
				'back_to'  => array( 'is_back_button' =>1, 'back_link'=>''),
                                
				'prime_index'   => 2,
                                
				# File Include
                                'after_add_update'	=>0,
				
				'divider' => 'tab', 
				
				'page_code'	=> 'FECA',                                
				
                                
			);
    
			if(isset($_GET['default_addon'])){
			
				$default_addon = @$_GET['default_addon'];
				
				if($default_addon){													
									
					// faddon array										
					@$F_SERIES['temp']=f_addon(['g'		        => $G,
												'rdsql'		    => $rdsql,
												'f_series'     	=> ['data'=>$F_SERIES['data']],
												'default_addon' => json_encode(['en'=>$default_addon]),
												'coach'			=> $COACH,
												'is_cache'		=> 0,
												'page_code'		=> $default_addon.'_'.$PAGE_CODE
										]);
					
					$F_SERIES['data']=$F_SERIES['temp']['data'];
														
					$F_SERIES['data'][2]['is_hide']=1;														
					array_push($F_SERIES['data'],$F_SERIES['data'][2]);														
					unset($F_SERIES['data'][2]);
					
					$F_SERIES['back_to']['back_default_addon']=$default_addon;		

						
					
				} // end
			
			} # end
    

			if(isset($_GET['menu_off'])){

											$menu_off = @$_GET['menu_off'];
											$F_SERIES['back_to']['back_menu_off']=$menu_off;
											
											$F_SERIES['back_to']['is_back_button']=0;

			}     
?>