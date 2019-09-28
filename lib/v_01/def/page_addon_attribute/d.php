<?PHP
    include("$LIB_PATH/def/external_attribute/d.php");
    
    $D_SERIES['title']      = 'Page Addon Attributes';   
	
    $D_SERIES['add_button'] = array( 'is_add' =>1,'page_link'=>'f=page_addon_attribute', 'b_name' => 'Add Page Addon' );
					
    $D_SERIES['key_filter']= "AND entity_code = 'EA'";
    
    $D_SERIES['custom_filter'] = array(array(  'field_name' => 'Input Type:',
				      
					'field_id' => 'cf2', // 
					
					'filter_type' =>'option_list', 
							    
					'option_value'=> $G->option_builder('entity_attribute','code,sn'," WHERE entity_code='IT' ORDER by sn ASC"),
		    
					'html'=>'  title="Select Client"   data-width="160px"  ',
			    
					'cus_default_label'=>'Show All',
		    
					'filter_by'  => "(SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=entity_child_base.id AND ea_code='APIT')"  // main table value
				),
		);
    
    
     
				    
?>