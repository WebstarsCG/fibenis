<?PHP

    $F_SERIES=array( 'title'=>'Entity key value',
                    
                     'data'=>array('1' => array( 'field_name'=> 'Entity Code',
						
						'field_id' => 'entity_code',
						
						'type' => 'option',
						
						'option_data'=>$G->option_builder("entity","code,sn","WHERE is_lib=0 ORDER BY sn ASC"),
						
						'is_mandatory'=>1,
						
						'avoid_default_option' => 0
						
						),
				   
				    '2' => array( 'field_name'=> 'Coach Name',
						
						'field_id' => 'coach_id',
						//get_eav_addon_vc128uniq(id,'CHCD')
						'option_data'=>$G->option_builder('entity_child',"id,get_eav_addon_varchar(id,'ECSN')",
										" WHERE entity_code='CH' ORDER BY get_eav_addon_varchar(id,'ECSN') ASC"),
						
						'type' => 'option',
						
						'is_mandatory'=>1,
						
						//'input_html'=>'onKeyPress="return PR_All_Numeric(event);"'
						
						),
				   
				   
				   '3' => array( 'field_name'=> 'Entity key',
						
						'field_id' => 'entity_key',
						
						'type' => 'text',
						
						'is_mandatory'=>1,
						
						'input_html'=>'class="w_200"',
                                                               
                                                'allow'     => 'x100',
						
						//'input_html'=>'onKeyPress="return PR_All_Numeric(event);"'
						
						),
				   
				    
				   
				   '4' => array( 'field_name'=> 'Entity Value',
						
						'field_id' => 'entity_value',
						
						'type' => 'text',
						
						'is_mandatory'=>1,
						
						'input_html'=>'class="w_200"',
                                                               
                                                'allow'     => 'x200',
						
						//'input_html'=>'onKeyPress="return PR_All_Numeric(event);"'
						
						
						),
				   
					'5' => array( 'field_name'=> 'Domain Hash',
						
									'field_id' => 'domain_hash',
									
									'type' => 'hidden'
									
									)
			   
				),
                    'table_name'    => 'entity_key_value',
                                
                    'key_id'        => 'id',
                                
                    
		    # Default Additional Column
                                
                    'is_user_id'       => 'user_id',
								
                    
		    # Communication
		    
		    'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child_base', 'b_name' => 'Add Entity child' ),
				
		    'back_to'  => array( 'is_back_button' =>1, 'back_link'=>'?d=entity_key_value', 'BACK_NAME'=>'Back'),
                                
                    'prime_index'   => 3,
                           
                    );
    
        if(isset($_GET['default_addon'])){  
	
		$default_addon = $_GET['default_addon'];
		$F_SERIES['data'][1]['option_data'] = $G->option_builder('entity','code,sn',"WHERE code = (SELECT code FROM entity WHERE id = $default_addon)");
                $F_SERIES['data'][1]['avoid_default_option'] = 1;
                $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
		$LAYOUT	    = 'layout_full';
	}



	// before addupdte

	$F_SERIES['before_add_update'] = function(){

			global $G;

			$lv 			= 	(object)['coach_id'=>@$_POST['X2'],'coach_hash'=>''];
			$lv->coach_hash = 	$G->get_one_column(['table'=>'entity_child',
												  'field'=>"md5(get_eav_addon_vc128uniq(id,'CHCD'))",
												  'manipulation'=>" WHERE md5(id)=md5($lv->coach_id)"
								]);
			$_POST['X5'] 	= 	$lv->coach_hash;

	} // end

?>