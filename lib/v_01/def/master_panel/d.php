<?PHP
	include($LIB_PATH."def/entity_key_value/d.php");

	$D_SERIES['key_filter'] = "AND entity_code='MP'";
	
	unset($D_SERIES['data'][1]);
	
	$D_SERIES['custom_filter']=array(array(  'field_name' => 'Domain:',
									      
						'field_id' => 'cf2', // 
						
						'filter_type' =>'option_list', 
								    
						'option_value'=> $G->option_builder('entity_child',"md5(get_eav_addon_vc128uniq(id,'CHCD')),get_eav_addon_varchar(id,'ECSN')","  WHERE entity_code='CH' ORDER BY get_eav_addon_varchar(id,'ECSN') ASC"),
			    
						'html'=>'  title="Select Domain"   data-width="160px"  ',
				    
						'cus_default_label'=>'Show All',
			    
						'filter_by'  => "domain_hash"  // main table value
					),
				);
	
	$D_SERIES['add_button']['page_link']='f=master_panel';
		
	
?>