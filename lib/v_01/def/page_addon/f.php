<?PHP

    include("$LIB_PATH/def/ecb_parent_child/f.php");
    
    $F_SERIES['title'] = 'Page Addon';
    
    $F_SERIES['data']['1']['option_data']=$G->option_builder('entity','code,sn'," WHERE code='AT' ORDER by sn ASC");
    
    $F_SERIES['data']['6']['field_name'] = 'Page Addon';
    
    $F_SERIES['back_to']['back_link']    = '?d=page_addon';
    
    $F_SERIES['gx']=1;
    
    $F_SERIES['form_layout']='form_100';
    
    # token
    
    $F_SERIES['data']['2'] =array('field_name'=>'Template',
                                                               
                                    'field_id'=>'token',
                                    
                                    'type'=>'option',
                                    
                                    'option_data'=>"<option id='opt_t' value='t'>Global Template</option>".
                                                   "<option id='opt_tx'    value='tx'>Application Template</option>",
                                    
                                    'is_mandatory'=>1,
                                    
                                    //'is_avoid_default_option'=>1,
                                    
                                    //'default_option_value'   =>'t',
                                    
                                   'input_html'=>" class='w_150'  onchange='(function(element){ G.$(\"X7\").value=(G.$(\"X2\").value+\"[S]\"+G.$(\"X3\").value);   })(this);' "
                                    
                                    );
    
        //$F_SERIES['data']['3']['input_html'] = " class='w_150'  onchange='(function(element){ G.$(\"X7\").value=(G.$(\"X2\").value+\"[S]\"+G.$(\"X3\").value);  })(this);' ";
    
    	
	# from X2+X3	
	$F_SERIES['data']['7'] = array(     'field_name'          => 'Input Type',                                                                
                                            'field_id'            => 'ea_value',				       
                                            'type'                => 'hidden',
                                                                                                
                                            //child table                                                                            
                                            'child_table'         => 'ecb_av_addon_varchar', // child table 
                                            'parent_field_id'     => 'parent_id',            // parent field                                                                                            
                                            'child_attr_field_id' => 'ea_code',              // attribute code field
                                            'child_attr_code'     => 'ATKH',                 // attribute code
                                                                                    
                                            'filter_in'=>function($data_in){
                                                
                                                    return md5($data_in);                
                                            }
						   
                            );
                                                   
    
    
        
    $F_SERIES['data']['3']['field_name']  = 'Definition Name';
    $F_SERIES['data']['4']['field_name'] = 'Name';
    
    array_push($F_SERIES['data'],array( 'field_name'=> 'Template',
							         'type'=>'heading'),
							   												
				array( 'field_name'          => 'Content',                                                                
								'field_id'            => 'ea_value',				       
								'type' 	              => 'code_editor',
								'is_mandatory'        => 0,
								'input_html'          => '  class="w_100" rows=10 ',
								
									
								 'child_table'         => 'ecb_av_addon_text', // child table 
								 'parent_field_id'     => 'parent_id',    // parent field
											 
								 'child_attr_field_id' => 'ea_code',   // attribute code field
								 'child_attr_code'     => 'ATTM',           // attribute code
						   
                                                               ));
    
    # customization
    $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',"id,concat(sn,' (',token,')')","  WHERE entity_code='EA' ");
    
    if(@$_GET['key']){
     
        $F_SERIES['js']=['is_bottom'    => 1,
                         'bottom_js'    => $LIB_PATH.'/def/page_addon/f'];
        
        $F_SERIES['data']['2']['avoid_default_option']=1;
        $F_SERIES['data']['3']['input_html'].=' readonly=1';
        
        
    }
    
?>
