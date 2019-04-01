<?PHP

    define('PAGE_PERM', $_SESSION['MANAGE_SETUP']);

    $F_SERIES =array('title'=>'Entity Attribute',
                     
                     'data'=>array('1'=>array('field_name'=>'Entity Name',
                                              
                                              'field_id'=>'entity_code',
                                              
                                              'type'=>'option',
                                              
                                              'option_data'=>$G->option_builder('entity','code,sn','order by sn ASC'),
                                              
                                              'is_mandatory'=>1
                                              
                                              ),
                                   
                                   '2'=>array('field_name'=>'Start Status',
                                              
                                              'field_id'=>'status_code_start',
                                              
                                              'type'=>'option',
                                              
                                              'option_data'=>$G->option_builder('entity_attribute','code,sn','where entity_code = \'PS\' order by sn ASC'),
                                              
                                              'is_mandatory'=>1
                                              
                                              ),
                                   
                                   '3'=>array('field_name'=>'End Status',
                                              
                                              'field_id'=>'status_code_end',
                                              
                                              'type'=>'option',
                                              
                                              'option_data'=>$G->option_builder('entity_attribute','code,sn','where entity_code = \'PS\' order by sn ASC'),
                                              
                                              'is_mandatory'=>1
                                              
                                              ),
                                   //'3'=>array('field_name'=>'Detail',
                                   //           
                                   //           'field_id'=>'ln',
                                   //           
                                   //           'type'=>'textarea',
                                   //           
                                   //           'is_mandatory'=>0
                                   //           
                                   //           ),
                                   //
                                   //'4'=>array('field_name'=>'Attribute Code',
                                   //           
                                   //           'field_id'=>'code',
                                   //           
                                   //           'type'=>'text',
                                   //           
                                   //           'is_mandatory'=>0,
                                   //           
                                   //           'input_html'=>' maxlength=4 class=w_50 '
                                   //           
                                   //           )
                                  ),
                     
                     'table_name'=>'status_map',
                     
                     'key_id'    =>'id',
                     
                     'is_user_id' =>'user_id',
                     
                     'back_to'  =>array('is_back_button'=>1,'back_link'=>'?d=entity_attribute', 'BACK_NAME'=>'Back'),
                     
                     'prime_index'=>1,
                     
                     'page_code'=>'FSTM'
                                   
                    )
     
     
?>