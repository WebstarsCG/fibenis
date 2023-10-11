<?PHP
  
    use GuzzleHttp\Client;
    use GuzzleHttp\Query;
   
    include("$LIB_PATH/def/def/f.php");
    
    # default
    $F_SERIES['temp']['DFTY']             =  'YOU'; // Internal
    
    # customization
    $F_SERIES['temp']['engines']          = array("'dx'","'fx'","'tx'","'ax'");
    $F_SERIES['data']['5']['field_name']  = 'Engines';
    $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',
                                                               'id,sn',
                                                               "  WHERE entity_code='EG' AND token IN(".implode(',',$F_SERIES['temp']['engines']).")");
    
    //$F_SERIES['data'][7] = ['type'      =>'heading',
    //                        'field_name'=>'User Role Access'];
    //
    $F_SERIES['data'][9] = ['type'         => 'option',
                            'field_name'   => 'Definition creation from entity',
                            'field_id'     => "parent_id",								                                
                            'option_data'  => $G->option_builder("entity","code,sn","WHERE is_lib=0 ORDER BY sn ASC"),                            
                            'input_html'   => ' class="w_200" rows="2"   ',
                            'ro'        => 1
                        ]; 

    $F_SERIES['is_cc'] = 1;
    
?>