<?PHP

$T_SERIES= array(
	
    'title'     => 'Entity Info',
    
	'table'     => 'entity',
    
    'data'      =>  array(
                        
                        'code'  => ['field' => 'code'],
                        'name'  => ['field' => 'sn'],
                        
                        'attributes'    => [    'is_child_addon'=> 1,
                                                'child_data'    =>array(
                                                                        1=>array('key'=>'code','field'=>'code'),
                                                                        2=>array('key'=>'sname','field'=>'sn')
                                                                    ),
                                                                         
                                                'table'         => ' entity_attribute',
                                                             
                                                'key_filter'    =>" AND entity_code='[[parent.code]]' ORDER BY id"    
                        ]
                        
                    ),
    
    
	'key_filter'=>' AND is_lib=1 ORDER BY code',
    
    'template'       => dirname(__FILE__)."/t.html",
    
    'cache_off' =>1
    
   # 'key_id'    => 'code'    
);

?>