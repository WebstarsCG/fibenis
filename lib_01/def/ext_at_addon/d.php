<?PHP
	    
	    include($LIB_PATH."/def/external_attribute/d.php");
        
    
            $D_SERIES['data'][7] = array(	'th'=>'Edit ',
								
						'field' =>"concat(id,':',get_ecb_addon_varchar(entity_child_base.id,'APIT'))",
						
						'td_attr' => ' class=" align_RM" width="10%"',
						
						'filter_out'=>function($data_in){
								
							    return '<a class="pointer clr_gray_b tip_bottom" onclick="JavaScript:ex_edit('."'$data_in'".');">'.
								    '<i class="fa fa-edit clr_green txt_size_15" aria-hidden="true"></i>&nbsp;'.
								    'Edit</a><span class="tooltiptext">Edit</span>';
						}
								
					);
                                        
            $D_SERIES['action']  = array('is_action'=>1, 'is_edit' => 0, 'is_view' =>0);
                                       
				       
?>