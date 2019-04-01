<?PHP 

    $F_SERIES   =   array(


                    #title
                    'title'             =>  'Writers Group',

                    #table name
                    'table_name'        =>  'entity_child',

                    #unique key
                    'key_id'            =>  'id',

                    #To Show DB Query
                    'show_query'        =>  0,

                    #Button Name
                    #'button_name'       =>  'Add Writers Group',
                    
                    #form divider
                    'divider'           =>  'tab',

                    
                    #user id
                    'is_user_id'        =>  'user_id',

                    #default fields
                    'default_fields'    =>  array(

                                            'entity_code'   =>  "'WG'",

                                    ),//default fields ends here...

                    #back button
                    'back_to'           =>  array(

                                        'is_back_button'    =>  1,
                                        'back_link'         =>  '?dx=writer_group',
                                        'BACK_NAME'         =>  'Back',

                ),//back button ends here...

        #*******Form Data Starts******#

                    'data'              =>  array(

                                            '0' =>  array(

                                                'field_name'            =>  'Basic Info',
                                                'type'                  =>  'heading',

                                            ),

                                            '1'  =>  array(

                                                    'field_name'            =>  'Group Name',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    //'hint'                  =>  'Enter Group Name',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGGN',

                                                ),//'1' ends here...

                                            '2'  =>  array(

                                                    'field_name'            =>  'Writer Group Id',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    //'hint'                  =>  'Enter Group Id',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGID',

                                                ),//'2' ends here...

                                            '3'  =>  array(

                                                    'field_name'            =>  'Publishing Interval',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGPI',

                                                ),//'3' ends here...
                                            
                                            '4'  =>  array(

                                                    'field_name'            =>  'Keep Alive Time',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGKT',

                                                ),//'4' ends here...

                                            '5'  =>  array(

                                                    'field_name'            =>  'Priority',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    //'hint'                  =>  'Enter Priority',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGPR',

                                                ),//'5' ends here...

                                            '6'  =>  array(

                                                    'field_name'            =>  'Security Group Id',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGSI',

                                                ),//'6' ends here...

                                            '7'  =>  array(

                                                    'field_name'            =>  'Max Network Message Size',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGMS',

                                                ),//'7' ends here...

                                            '8'  =>  array(

                                                    'field_name'            =>  'Security Mode',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(

                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='SM' 
                                                                                            ORDER BY sn ASC"

                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGSM',

                                                ),//'8' ends here...
                                            
                                            

                                            '9'  =>  array(

                                                    'field_name'            =>  'Transport Settings',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(

                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='TS' 
                                                                                            ORDER BY sn ASC"

                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGTS',

                                                ),//'9' ends here...
                                            
                                            '21'  => ['field_name'=>'Message & Offset',
								 'type'=>'heading'					 
								], 




                                            '10'  =>  array(

                                                    'field_name'            =>  'Message Repeat Count',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGMC',

                                                ),//'10' ends here...
                                            
                                            

                                            '11'  =>  array(

                                                    'field_name'            =>  'Message Repeat Delay',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGMD',

                                                ),//'11' ends here...


                                            '12'  =>  array(

                                                    'field_name'            =>  'Message Settings',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(

                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='SE' 
                                                                                            ORDER BY sn ASC"

                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGSE',

                                                ),//'12' ends here...

                                            '13'  =>  array(

                                                    'field_name'            =>  'Group Version',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGGV',

                                                ),//'13' ends here...
                                            
                                            
                                            

                                            '14'  =>  array(

                                                    'field_name'            =>  'Data Set Ordering',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(

                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='DS' 
                                                                                            ORDER BY sn ASC"

                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGDS',

                                                ),//'14' ends here...

                                            '15'  =>  array(

                                                    'field_name'            =>  'Sampling Offset',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGSO',

                                                ),//'15' ends here...
                                            
                                            

                                            '16'  =>  array(

                                                    'field_name'            =>  'Publishing Offset',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGPO',

                                                ),//'16' ends here...

                                            '17'  =>  array(

                                                    'field_name'            =>  'Header Layout URI',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGHU',

                                                ),//'17' ends here...
                                            
                                            '22'  => ['field_name'=>'Content Mask',
								 'type'=>'heading'					 
								], 



                                            '18'  =>  array(

                                                    'field_name'            =>  'Uadp Network Message Content Mask',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'is_list'                  =>  1,
                                                    'option_data'           =>  $G->option_builder(

                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='UN' 
                                                                                            ORDER BY sn ASC"

                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'hint'                  => 'Use ctrl to select multiple value',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGUN',
                                                    'input_html'            =>  ' class="w_200"  style="height:225px !important"  ',
                
                                                ),//'18' ends here...
                                            
                                            '19'  =>  array(

                                                    'field_name'            =>  'Publisher ID',
                                                    'field_id'              =>  'exa_value',
                                                    'type'         	=> 'toggle',
                                                    'is_round'      	=> 1,  		# toggle will be in round type, by default it will be square     
                                                    'show_status_label' => 1, 	# show labels for on & off toggle status
                                                    'on_label'      	=> 'Yes',  	# shows during on status
                                                    'off_label'     	=> 'No', 	# shows during off status
                                                    'is_default_on' 	=> 0,
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGP1',

                                                ),//'19' ends here...
                                            
                                            '20'  =>  array(

                                                    'field_name'            =>  'Group Header',
                                                    'field_id'              =>  'exa_value',
                                                    'type'         	=> 'toggle',
                                                    'is_round'      	=> 1,  		# toggle will be in round type, by default it will be square     
                                                    'show_status_label' => 1, 	# show labels for on & off toggle status
                                                    'on_label'      	=> 'Yes',  	# shows during on status
                                                    'off_label'     	=> 'No', 	# shows during off status
                                                    'is_default_on' 	=> 0,
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'WGP2',

                                                ),//'20' ends here...



                                            
                    ),//data ends here...


    );//F_series ends here...
    
    
     if(isset($_GET['default_addon'])){  
	
		$default_addon = $_GET['default_addon'];
	        $F_SERIES['back_to']['is_back_button'] = 0;
                $F_SERIES['add_button']['is_add'] = 0;
                $LAYOUT	    = 'layout_full';
    }
    
?>