<?php
        
        //http://assam/wa_dev/fibenis/app/index.php?f=ext_at_addon&default_addon=TX
        
        include($LIB_PATH."/def/external_attribute/f.php");
        
        $LAYOUT - 'layout_right';
        
        $temp = [];
        
        $temp ['input_type'] = ['EX' => [0,1,2,3,4,5,6,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45],
                                'GN' => [0,1,2,3,4,5,6,9,10,11,12,14,15,16,17],
                                'ITTX' => [2,3,4,5,6,7,13,],
                                ];
        
        if(@$_GET['default_addon']){
                
                $F_SERIES['data'][6]['option_data']=$G->option_builder('entity_attribute','code,sn'," WHERE entity_code='IT' AND code= '$_GET[default_addon]' ORDER by sn ASC");
                
                $F_SERIES['data'][6]['avoid_default_option']= 1;
                
                $temp['to_set']=array_merge($temp ['input_type']['GN'],$temp ['input_type'][$_GET['default_addon']]);
                
                $temp['to_set_final']=array_diff($temp['input_type']['EX'],$temp['to_set']); 
        }else{
                
                $temp['to_set_final']=array_diff($temp ['input_type']['EX'],$temp['input_type']['GN']);
                
        }
        
        
        foreach($temp ['to_set_final'] as $key => $val){
                
                unset($F_SERIES['data'][$val]);
                
        };
        
                // default addon
        
        if(@$_GET['key']){
            
            $F_SERIES['data'][1]['option_data']=$G->option_builder('entity','code,sn'," WHERE code='$_GET[key]'");
        
        }else{
            
            $F_SERIES['data'][1]['option_data']=$G->option_builder('entity','code,sn',"WHERE is_lib=0 ORDER by sn ASC");
        
        } // default addon
    
?>

?>