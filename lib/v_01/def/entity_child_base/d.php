<?PHP

$ECB_ATTR_ARRAY_TO_TEXT = function($data_in) {
    $lv = (object)[
        'option_data' => '',
        'grid_data' => '',
        'out_text' => ''
    ];

    if ($data_in !== null) {
        $lv->option_data = json_decode($data_in, true);

        foreach ($lv->option_data as $index => $option_item) {

			if(!empty($option_item[0])){

				$cleaned_data = implode(',', array_map(function ($value) {
					return ($value !== "") ? $value : '';
				}, $option_item));   // End of implode
	
				if (!empty($cleaned_data)) {
					if ($index > 0) {
						$lv->out_text .= "[C]";
					}
				
					$lv->out_text .= $cleaned_data;
				} // end of if
			}

        } // end of foreach 

        return $lv->out_text;
    } else {
        return $data_in;
    }
};
               
        $D_SERIES       =   array(
					'title'=>'Entity Child Base',
                                    
					 #table data
                                    
					'data'=> array(
					                
							1=>array('th'      => 'Entity',
								 'field'   => '(SELECT sn FROM entity WHERE entity.code=entity_code)',
								 'td_attr' => ' class="clr_gray_8 align_LM" width="15%"',
								 'is_sort' => 1),
													
                                                        2=>array('th'		=> 'Token',									 
								 'field'	=> 'token',								
								 'is_sort' 	=> 1,								
								 'td_attr' 	=> ' class="label_father align_LM" width="10%"'								),
							
							3=>array('th'		=> 'Short Name',								 
								'field'		=> 'sn',								     															
								'is_sort'	=> 1,								
								'td_attr' 	=> ' width="25%" '), 
						
							// 
							//4=>array('th'=>'Long Name',
							//		 
							//	'field'=>'ln',
							//	
							//	'is_sort' => 1,
							//		 
							//	'td_attr' => ' class="label_child align_LM" width="25%"',
							//		 
							//	),
							
							5=>array('th'=>'DNA',
									 
								#'field'=>'(SELECT ecb.sn FROM entity_child_base as ecb WHERE ecb.token=dna_code)',
								'field'=>'dna_code',
								
								'is_sort' => 1,
									 
								'td_attr' => ' class="label_father" width="10%"',
									 
								),
							
							6=>array('th'=>'Line order',
								 
								'field'=>'line_order',
								     															
								'is_sort'      => 1,
									
								'td_attr' => ' width="5%" ',
							                                                                     
								),
							
							8=>array('th'=>'Updation',
									 
								'field'=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
							        									 
								'td_attr' => 'width="20%"',
								
								'js_call'=> 'show_user_info',
								
								'is_sort' => 'timestamp_punch'
									 
								),
								
                                                    ),
				    
                                    
                                       'action' => array('is_edit' =>1),
                                       
                                       'order_by'   =>' ORDER BY token ASC ' ,
				       		
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child_base',
                                    
                                    'key_id'    =>'id',
				    
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 3,
				    
				    'search'=> 	array(
							  
							
							array(  'data'  =>array('table_name' 	=> 'entity_child_base',
										'field_id'	=> 'token',
										'field_name' 	=> 'token',
										'filter'	=> "AND dna_code IN ('EBUC','EBMS','EBAX','EBFA')"
										
									 ),
							      
								'title' 		=> 'Token',										
								'search_key' 		=> 'token',													       
								'is_search_by_text' 	=> 1, //( For Text search case)	      
							),
							
								
						),
				    
				    'custom_filter' => array(  			     						   
							      
									array(  'field_name' => 'Entity:',
									      
										'field_id' => 'cf1', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity','code,sn'," ORDER BY sn ASC"),
									  
										'html'=>'  title="Select Client"   data-width="160px"  ',
									   
										'cus_default_label'=>'Show All',
									  
										'filter_by'  => "entity_code"  // main table value
									),
									
									
									array(  'field_name' => 'DNA:',
									      
										'field_id' => 'cf2', // 
										
										'filter_type' =>'option_list', 
												    
										'option_value'=> $G->option_builder('entity_child_base','token,sn',"WHERE entity_code='EB' AND dna_code='EBMS' ORDER BY sn ASC"),
									  
										'html'=>'  title="Select Client"   data-width="160px"  ',
									   
										'cus_default_label'=>'Show All',
									  
										'filter_by'  => "dna_code"  // main table value
									),
							),
				
                                
                                    # File Include
                                
                                  //'js'            => array('is_top'=>0, 'top_js' => 'js/d_series/entity_child_base'),
                                    
				#'key_filter'	=> " AND dna_code IN ('EBUC','EBMS','EBAX','EBFA') ",
				
				#summary:
				
				'summary_data'=>array(
							array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
				
				                   ),
				
				#check_field
								
					#'check_field'   =>  array('user_id' => @$_GET['user_id'],'page_code' => @$_GET['page_code']),								
								
					'add_button' => array( 'is_add' =>1,'page_link'=>'f=entity_child_base', 'b_name' => 'Add Child Base' ),
								
					'del_permission' => array('able_del'=>1), 
								
					
				#export data
				
					'show_query'   =>0,
					
					
				                            
                            );


	$D_SERIES['export_csv'] =  array(
		
		'is_active' => 1,
		'export_csv_data' => array(
				array(
					'th' => 'Short Name',	
					'field' => 'sn'
				),
				array(
					'th' => 'Token', 
					'field' => 'token'
				),
				// array(
				// 	'th' => 'Long Name',	
				// 	'field' => 'ln'
				// ),
				array(
					'th' => 'Line Order',
					'field' => 'line_order'
				),
				array(
					'th' =>'Is Active',
					'field'=>'is_active'
				),
				array(
					'th' => 'Label Content',
					'field' => 'note'
				),
				array(
					'th' => 'APIT',
					'field' => "get_ecb_av_addon_varchar(id, 'APIT')"
				),
				array(
					'th' => 'APAL',
					'field' => "get_ecb_av_addon_varchar(id, 'APAL')"
				),
				array(
					'th' => 'APMA',
					'field' => "get_ecb_av_addon_varchar(id, 'APMA')"
				),
				array(
					'th' => 'APHT',
					'field' => "get_ecb_av_addon_varchar(id, 'APHT')"
				),
				array(
					'th' => 'APCL',
					'field' => "get_ecb_av_addon_varchar(id, 'APCL')"
				),
				array(
					'th' => 'APIH',
					'field' => "get_ecb_av_addon_varchar(id, 'APIH')"
				),
				array(
					'th'=>'APHD',
					'field' => "get_ecb_av_addon_varchar(id, 'APHD')"
				),
				array(
					'th' => 'APSL',
					'field' => "get_ecb_av_addon_varchar(id, 'APSL')",
					'fun' =>$ECB_ATTR_ARRAY_TO_TEXT
				),
				array(
					'th' => 'APLL',
					'field' => "get_ecb_av_addon_varchar(id, 'APLL')"
				),
				array(
					'th' => 'APOL',
					'field' => "get_ecb_av_addon_varchar(id, 'APOL')"
				),
				array(
					'th' => 'APAD',
					'field' => "get_ecb_av_addon_varchar(id, 'APAD')"
				),
				array(
					'th' => 'APTS',
					'field' => "get_ecb_av_addon_varchar(id, 'APTS')"
				),
				array(
					'th' => 'APTN',
					'field' => "get_ecb_av_addon_varchar(id, 'APTN')"
				),
				array(
					'th' => 'APTF',
					'field' => "get_ecb_av_addon_varchar(id, 'APTF')"
				),
				array(
					'th' => 'APTD',
					'field' => "get_ecb_av_addon_varchar(id, 'APTD')"
				),
				array(
					'th' => 'APFR',
					'field' => "get_ecb_av_addon_varchar(id, 'APFR')"
				),
				array(
					'th' => 'APMR',
					'field' => "get_ecb_av_addon_varchar(id, 'APMR')"
				),
				array(
					'th' => 'APGR',
					'field' => "get_ecb_av_addon_varchar(id, 'APGR')"
				),
				array(
					'th' => 'APFO',
					'field' => "get_ecb_av_addon_varchar(id, 'APFO')",
					'fun'=>$ECB_ATTR_ARRAY_TO_TEXT				
				),
				array(
					'th' => 'APMD',
					'field' => "get_ecb_av_addon_varchar(id, 'APMD')"
				),
				array(
					'th' => 'APXD',
					'field' => "get_ecb_av_addon_varchar(id, 'APXD')"
				),
				array(
					'th' => 'APMY',
					'field' => "get_ecb_av_addon_varchar(id, 'APMY')"
				),
				array(
					'th' => 'APXY',
					'field' => "get_ecb_av_addon_varchar(id, 'APXY')"
				),
				array(
					'th' => 'APDD',
					'field' => "get_ecb_av_addon_varchar(id, 'APDD')"
				)
			)
				);
	
	
	if(@$_GET['default_addon']){
		
		$default_addon = @$_GET['default_addon'];
        	$D_SERIES['key_filter'] ="AND  entity_code='$default_addon' ";
		unset($D_SERIES['data'][1]);
		unset($D_SERIES['export_csv']);
		$D_SERIES['action']['is_edit']=1;
		$D_SERIES['action']['action_menu_off']=@$_GET['menu_off'];
		$D_SERIES['action']['action_default_addon']=@$_GET['default_addon'];
		$D_SERIES['add_button']['is_add']=0;
		$D_SERIES['del_permission']['able_del']=1;
		$D_SERIES['summary_data'] = [];
		
		$LAYOUT	    = 'layout_full';
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['search_filter_off']	=1;
		$D_SERIES['hide_show_all'] = 1;
		$D_SERIES['hide_pager'] = 1;
		$D_SERIES['show_all_rows']=1;
		$D_SERIES['filter_off'] = 1;
	}
	
	if(@$_GET['mode']=='EXT'){
		
		$D_SERIES['key_filter'].= " AND dna_code <> 'EBAT' ";		
	}
    
?>