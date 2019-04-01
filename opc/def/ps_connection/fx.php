<?PHP 

    $F_SERIES   =   array(


                    #title
                    'title'             =>  'PubSub Connection',
                    
                    'auto_divert'       =>  ['title'=> array( 'PSCTOFL'=>function(){ return 'PubSub Offline';   },
                                                              'PSCTONL'=>function(){ return 'PubSub Online  ';   },
                                                             )
                                            ],

                    #table name
                    'table_name'        =>  'entity_child',

                    #unique key
                    'key_id'            =>  'id',

                    #To Show DB Query
                    'show_query'        =>  0,

                    #form divider
                    'divider'           =>  'accordion',

                    #Button Name
                    //'button_name'       =>  'Connect server',  
                    
                    #user id
                    'is_user_id'        =>  'user_id',

                    #default fields
                    'default_fields'    =>  array(

                                            'entity_code'   =>  "'PC'",

                                    ),//default fields ends here...

                    #back button
                    'back_to'           =>  array(

                                                    'is_back_button'    =>  1,
                                                    'back_link'         =>  '?dx=ps_connection',
                                                    'BACK_NAME'         =>  'Back',

                                             ),//back button ends here...

        #*******Form Data Starts******#

                    'data'              =>  array(

                                            '0' =>  array(

                                                'field_name'            =>  'PubSubConnection Form',
                                                'type'                  =>  'heading',

                                            ),

                                            '11'  =>  array(
                                            
                                              'field_name'            =>  'Connection Type',
                                              'field_id'              =>  'exa_value',
                                              'type'                  =>  'option',
                                              'option_data'           =>  $G->option_builder(
                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='PSCT' 
                                                                                            ORDER BY sn ASC"
                                                                                        ),
                                              'is_mandatory'          =>  1,
                                              'parent_field_id'       =>  'parent_id',
                                              'child_table'           =>  'exav_addon_varchar',
                                              'child_attr_field_id'   =>  'exa_token',
                                              'child_attr_code'       =>  'PCCT',
                                              'input_html'            =>  "select disabled readonly"
                                            
                                            
                                            ),
                                            
                                            
                                            '12'  =>  array(

                                                    'field_name'            =>  'Server IP',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCSI',
                                                    'input_html'	=>'class="w_200"',

                                                ),//'1' ends here...
                                            
                                             '13'  =>  array(

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
                                                    'child_attr_code'       =>  'PCSM',

                                                ),//'8' ends here..
                                             
                                              '14'  =>  array(

                                                    'field_name'            =>  'Security Policy',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(

                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='SP' 
                                                                                            ORDER BY sn ASC"

                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCSP',

                                                ),//'8' ends here..
                                            
                                            
                                            //'10'  =>  array(
                                            //
                                            //  'field_name'            =>  'Server IP',
                                            //  'field_id'              =>  'exa_value',
                                            //  'type'                  =>  'text',
                                            // // 'hint'                  =>  'Enter Connection Name',
                                            //  'is_mandatory'          =>  1,
                                            //  'parent_field_id'       =>  'parent_id',
                                            //  'child_table'           =>  'exav_addon_varchar',
                                            //  'child_attr_field_id'   =>  'exa_token',
                                            //  'child_attr_code'       =>  'PCCN',
                                            //
                                            //),//'1' ends here...
                                            
                                            
                                            '1'  =>  array(
                                            
                                                    'field_name'            =>  'PubSub Endpoint',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                   // 'hint'                  =>  'Enter Connection Name',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCCN',
                                                    
                                                    'input_html'            => 'class ="w_200"'
                                            
                                                ),//'1' ends here...
                                            
                                            '2'  =>  array(
                                            
                                                    'field_name'            =>  'Publisher Data Type',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(
                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='PT' 
                                                                                            ORDER BY sn ASC"
                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCPT',
                                            
                                                ),//'2' ends here...
                                            
                                            '3'  =>  array(
                                            
                                                    'field_name'            =>  'Publisher Id',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                 // 'hint'                  =>  'Enter Publisher Id',
                                                    'is_mandatory'          =>  1,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCID',
                                            
                                                ),//'3' ends here...
                                            
                                            
                                            '4'  =>  array(
                                            
                                                    'field_name'            =>  'Transport Profile URI',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'option_data'           =>  $G->option_builder(
                                            
                                                                                            'entity_child_base',
                                                                                            'token, sn',
                                                                                            "WHERE entity_code='TU' 
                                                                                             ORDER BY sn ASC"
                                            
                                                                                        ),
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_exa_token',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCTU',
                                            
                                                ),//'4' ends here...
                                            
                                            '5'  =>  array(
                                            
                                                    'field_name'            =>  'URL',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCUL',
                                                    'input_html'            => 'class ="w_200"'
                                            
                                                ),//'5' ends here...
                                            
                                            '6'  =>  array(
                                            
                                                    'field_name'            =>  'Network Interface',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                //  'hint'                  =>  'Enter Network Interface',
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCNI',
                                            
                                                ),//'6' ends here...
                                            
                                            '7'  =>  array(
                                            
                                                    'field_name'            =>  'Transport Settings',
                                                    'field_id'              =>  'exa_value_token',
                                                    'type'                  =>  'option',
                                                    'avoid_default_option'  =>  1,
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
                                                    'child_attr_code'       =>  'PCTS',
                                                    'input_html'            =>  "select disabled readonly"
                                            
                                                ),//'7' ends here...
                                            
                                            
                                            '8'  =>  array(
                                            
                                                    'field_name'            =>  'Discovery URL',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCDU',
                                            
                                                ),//'8' ends here...
                                            
                                            '9'  =>  array(
                                            
                                                    'field_name'            =>  'Discovery Network Interface',
                                                    'field_id'              =>  'exa_value',
                                                    'type'                  =>  'text',
                                                    'is_mandatory'          =>  0,
                                                    'parent_field_id'       =>  'parent_id',
                                                    'child_table'           =>  'exav_addon_varchar',
                                                    'child_attr_field_id'   =>  'exa_token',
                                                    'child_attr_code'       =>  'PCDN',
                                            
                                                ),//'9' ends here...
                                        
                    ),//data ends here...
                    
                    
                    
                    


    );//F_series ends here...
    
    
    $temp                  = [];
    $temp['default_addon'] = @$_GET['default_addon'];
    $temp['filter']        = '';
    
    if( ($temp['default_addon']=='PSCTONL') || ($temp['default_addon']=='PSCTOFL')){
        
            $temp['filter']   =   "AND token='$temp[default_addon]' ";
            
            $F_SERIES['data'][11]['avoid_default_option'] = 1;
            
            $F_SERIES['data'][0]['field_name']  = $F_SERIES['auto_divert']['title'][$temp['default_addon']]();
            
            $F_SERIES['title']  = $F_SERIES['data'][0]['field_name'];
            
            if($temp['default_addon']=='PSCTOFL'){
                
                unset($F_SERIES['data'][1]);
                unset($F_SERIES['data'][2]);
                unset($F_SERIES['data'][3]);
                unset($F_SERIES['data'][4]);
                unset($F_SERIES['data'][5]);
                unset($F_SERIES['data'][6]);
                unset($F_SERIES['data'][7]);
                unset($F_SERIES['data'][8]);
                unset($F_SERIES['data'][9]);
                
                $F_SERIES['button_name']       =  'Connect server'; 
			
            }
    }
    
    $F_SERIES['data'][11]['option_data']    =   $G->option_builder(
                                                                        'entity_child_base',
                                                                        'token, sn',
                                                                        "WHERE entity_code='PSCT' $temp[filter] ORDER BY sn ASC"
                                                                );
    
    
?>