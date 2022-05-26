<?PHP
	       
include("$LIB_PATH/inc/lib/d_addon.php");

$D_SERIES       =   array(

		'title'		=> 'Call Desk',

		'table_name' =>'entity_child',

		'data'			=> array(),

		'key_id'   =>'id',								

		'action'=> array('is_action'=>1, 'is_edit' =>1, 'is_view' =>0 ),		

		'summary_data'		 => array(
                                  ['name'=>'No.','field'=>'count(id)','html'=>'class=summary']
                                     ),

		'del_permission'=> array('able_del'=>0), 
		
		'add'=> array('is_add'=>1,'b_name'=>'Add Call'),
		
		'export_csv'    => array('is_active' => 1),		
		
		'is_narrow_down' =>1,
		
		'date_filter'  => array( 'is_date_filter' =>1,'date_field' =>'creation'),	
		
		//search
		'search' => array(
							  
					array(  'data'  =>	array('table_name' 	=> 'exav_addon_num',
											  'field_id'		=> 'parent_id',
											  'field_name' 	=> "exa_value",
											  'filter'		=> " AND exa_token='RUSNO' "
										),
							      
							'title' 			=> 'Ticket No',										
							'search_key' 		=> "id",													       
							'is_search_by_text' => 0,
						)
					),
					
		//custom filter
		
		  'custom_filter' => array(
            
                        array(

								'field_name' => 'Call For Reason ',

								'field_id' => 'cf1', 

								'filter_type' =>'option_list', 

								'option_value'=> $G->option_builder('entity_child_base','token,sn'," WHERE entity_code='RUCF' ORDER BY sn ASC"),
									  
								'cus_default_label' => 'Show All',

								'html' => ' class="w_100"',

								'filter_by'  => "get_exav_addon_varchar(id,'RUCR')"
							),
							
						array(

							'field_name' => 'Status ',

							'field_id' => 'cf2', 

							'filter_type' =>'option_list', 

							'option_value'=> $G->option_builder('entity_child_base','token,sn'," WHERE entity_code='RUST' ORDER BY sn ASC"),
								  
							'cus_default_label' => 'Show All',

							'html' => ' class="w_100"',

							'filter_by'  => "get_exav_addon_varchar(id,'RUST')"
						),
						
						array(

							'field_name' => 'Assigned To',

							'field_id' => 'cf3', 

							'filter_type' =>'option_list', 

							'option_value'=> $G->option_builder('user_info','id,get_user_internal_name(id)','ORDER BY id ASC'),
								  
							'cus_default_label' => 'Show All',

							'html' => ' class="w_100"',

							'filter_by'  => "get_exav_addon_varchar(id,'RUASN')"
						),
						
							),
                           // End of custom filter
       'show_query'=>1,
        'avoid_transist_key_direct'=>0		

                 );
		           
				  $D_SERIES['data']['10']=array("th"=>"Serial Num",
												'field'=>"get_exav_addon_num(id,'RUSNO')",
												"td_attr" => 'width="6%" class="label_grand_child align_RM"'
													);
			// addon																									
					$D_SERIES['temp']=d_addon(['default_addon'=>'RU',
												'd_series'     => ['data'=>$D_SERIES['data']],
												'rdsql'        => $rdsql
												]);
					array_unshift($D_SERIES['temp']['data'],$D_SERIES['data']['10']);
				
					foreach($D_SERIES['temp'] as $akey => $aval){																																																
													$D_SERIES[$akey]=$aval;
					}

					if(@$_GET['menu_off']==1){	
													$LAYOUT= 'layout_full';
													$D_SERIES['filter_off']= 1;		
													$D_SERIES['is_narrow_down']= 1;
													$D_SERIES['action']['action_menu_off']    = 1;
													$D_SERIES['action']['action_narrow_down'] = 1;
					}
					
					//View Status Log using narrow down
						$D_SERIES["data"]["v"] = [
												"th" => "View Log",

												"field" => "id",

												//"attr" => ["class" => "brdr_right align_CM", "width" => "5%"],

												"filter_out" => function ($data_in) {
													$temp = $data_in;

													$data_out = [
														"id" => $temp,
														"link_title" => "View",
														"is_fa" => " fa fa-file-text-o clr_dark_blue fa-lg",
														"title" => "Status",
														'src'=>"?d=status&menu_off=1&mode=simple&default_addon=$data_in",
														//"src" => "?tx=fit__base&menu_off=1&clear_cache=1&key=$temp",
														"style" => "border:none;width:100%;height:600px;",
													];

													return json_encode($data_out);
												},

												"js_call" => "d_series.set_nd",
											]; //End Status Log
											
                 $D_SERIES["data"]["12"] = [
											"th" => "Created By",
											"field" => "concat(get_user_internal_name(user_id),',',date_format(creation,'%d-%b-%y %T'))",
											"td_attr" => 'width="12%" class="label_grand_child align_RM"',		
                                            'js_call'	=> 'show_user_info_2l',
											 'is_sort' 	=> 'creation',											
											];
				$D_SERIES['data']['13']		= array('th'		=>'Updation',
											'field'		=>"concat(get_user_internal_name(user_id),',',date_format(timestamp_punch,'%d-%b-%y %T'))",
											  'td_attr' 	=> 'width="10%"',
											  'js_call'	=> 'show_user_info_2l',
											  'is_sort' 	=> 'timestamp_punch',
											  );				
				
				if($USER_ROLE=='SAD'){
					
					//$D_SERIES['key_filter']=;
				}else{
					
				$D_SERIES['key_filter']=" AND get_exav_addon_varchar(id,'RUASN')=$USER_ID ";
				}
                //print_r($USER_ROLE);
					
?>