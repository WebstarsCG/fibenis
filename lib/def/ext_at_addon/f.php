<?php
        
        include($LIB_PATH."/def/external_attribute/f.php");
        
        $LAYOUT - 'layout_right';
        
        $temp = [];
        
        $temp ['input_type'] = ['EX' => [0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45],
                                'GN' => [0,1,2,3,4,5,6,9,10,11,12,14,15,16,17],
                                'ITTX' => [13],
                                'ITFT' => [26,27,28,29,30,31,32],
                                'ITSL' => [8],
                                'ITTA' => [13],
                                'ITIG' => [],
                                'ITFI' => [33,34,35,36,37,38,39,40],
                                'ITFD' => [33,34,35,36,37,38,39,40],
                                'ITDT' => [18,19,20,21,22,23],
                                
                                ];
        
        if(@$_GET['i_t']){
                
                //if(in_array($_GET['i_t'],$temp['input_type'])){
                //        
                //        echo "yes";
                //
                        $F_SERIES['data'][6]['option_data']=$G->option_builder('entity_attribute','code,sn'," WHERE entity_code='IT' AND code= '$_GET[i_t]' ORDER by sn ASC");
                        
                        $F_SERIES['data'][6]['avoid_default_option']= 1;
                        
                        $temp['to_set']=array_merge($temp ['input_type']['GN'],$temp ['input_type'][$_GET['i_t']]);
                        
                        $temp['to_set_final']=array_diff($temp['input_type']['EX'],$temp['to_set']); 
                
                //}else{
                //        
                //        $temp['to_set_final']=array_diff($temp ['input_type']['EX'],$temp['input_type']['GN']);
                //
                //}       
        
        }else{
                
                $temp['to_set_final']=array_diff($temp ['input_type']['EX'],$temp['input_type']['GN']);
                
        }
        
        
        foreach($temp ['to_set_final'] as $key => $val){
                
                unset($F_SERIES['data'][$val]);
                
        };
        

?>
