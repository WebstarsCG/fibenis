<?PHP
        include($LIB_PATH."def/entity_child_eav/d.php");
	
	$D_SERIES['title']          = 'Coach';
        
        $D_SERIES['key_filter']     = "  AND entity_code='CH'  ";
        
        $D_SERIES['custom_filter']  = [];
        
        $D_SERIES['search_filter_off'] =1;
        
        $D_SERIES['is_narrow_down'] = 1;
	
	$D_SERIES['show_query'] = 0;
	
	$D_SERIES['add_button']     = array( 'is_add' =>1,'page_link'=>'f=coach_eav', 'b_name' => 'Add Coach' );
        
        $D_SERIES['del_permission'] = array(    'able_del'=>1,								  
                                                'avoid_del_field' => "if(((SELECT count(*) FROM entity_child as ec WHERE get_eav_addon_num(id,'ECPR')=entity_child.id) > 0),1,0)",								  
                                                'avoid_del_value' => 1								  
                                            );
	
	
        $D_SERIES['js']    	=	array('is_top' => 1,'top_js'=> $LIB_PATH.'/def/coach_eav/d');
	
	
	$D_SERIES['before_delete'] = 1;
	
        // 2
        
        $D_SERIES['data'][1]['th'] = 'Coach Name';
        
        
        // code
        
        $D_SERIES['data'][6] = array(   'th'        =>  'Code',
									 
                                        'field'     =>  "get_eav_addon_vc128uniq(id,'CHCD')",
                                                 
                                        'td_attr'   =>  ' class="label_child align_LM" width="15%"',
                                        
                                        'is_sort'   =>  0
									 
				    );
       
	
	
	 $D_SERIES['data'][7] = array(   'th'       	=>  'Domain Name',
									 
                                        'field'     	=>  "get_eav_addon_varchar(id,'CHDN')",
                                                 
					'td_attr'       =>  ' class="clr_gray_c align_CM" width="25%"',	 
						 
                                        'attr'  	=>  ['class'=>' txt_size_13 b clr_dark_blue'],
                                                                                                                                                               
                                        'is_sort'   	=>  0
									 
				    );
	 
	 
//	 $D_SERIES['data'][8] = array(   'th'       	=>  'Theme',
//									 
//                                        'field'     	=>  iSELECT sn FROM entity_child  as ec2 WHERE ec2.id=get_eav_ec_id(entity_child.id,'CHTH'))",
//                                                 
//                                        'attr'  	=>  ['class'=>' txt_size_13 b clr_dark_blue'],
//                                                                                                                                                               
//                                        'is_sort'   	=>  0
//									 
//				    );
	  
        $D_SERIES['data'][9] = array(   'th'        =>  'Content',
									 
                                        'field'     =>  "JSON_OBJECT('code',get_eav_addon_varchar(id,'CHDN'),
                                                                     'name',lower(get_eav_addon_vc128uniq(id,'CHCD'))
                                                                )",
                                                 
                                        'td_attr'   =>  ' class="clr_gray_c align_CM" width="20%"',
                                                                                 
                                        'filter_out'=> function($data_in){
							
                                                                $lo = json_decode($data_in);
                                                                            
								return  "<a target='_blank' class='ficon' href='?d=one_page_eav&default_addon=$lo->code'><i class='fa fa-file-text-o'></i>Sections</a>&nbsp;|".
								        "<a class='ficon'  href='JavaScript:coach_content(\"$lo->code\",\"$lo->name\");'><i class='fa fa-send'></i>Publish</a>";
                        
                                        }, // end of function
                                                                              
                                        'is_sort'   =>  0
									 
				    );
                        
        unset($D_SERIES['data'][3]);    // 3
        unset($D_SERIES['data'][5]);    // 5
	
	
	// before delete
	
	function before_delete($param){
                
                // delete pages
		$param['rdsql']->exec_query("DELETE FROM entity_child WHERE get_eav_ec_id(id,'PGCH')=$param[key_id]",'');
		
		// get ones column		
		$temp_domain    	= 	$param['g']->get_one_column(['field'        => "get_eav_addon_varchar(id,'CHDN')",
									     'table'        => 'entity_child',
									     'manipulation' => "WHERE id=$param[key_id]"
									]);		
		
		$temp_domain_hash       =       md5($temp_domain);
		
		// delete entity key value
		$param['rdsql']->exec_query("DELETE FROM entity_key_value WHERE domain_hash='$temp_domain_hash'",'');
				
		$temp_coach_path        = get_config('coach_path');		    
				       
		$temp_coach_domain_path = $temp_coach_path."/$temp_domain";
		
						    
        } // end

?>