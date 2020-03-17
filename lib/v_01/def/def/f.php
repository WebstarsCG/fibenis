<?PHP

    include("$LIB_PATH/def/ecb_parent_child/f.php");
    
    $F_SERIES['title'] = 'Definition';
    
    # option data
    
    $F_SERIES['data']['1']['option_data']=$G->option_builder('entity','code,sn'," WHERE code='DF' ORDER by sn ASC");
                                      
    $F_SERIES['data']['2']['field_id'] = 'sn';
    
    $F_SERIES['data']['3']['field_id'] = 'ln';
                                             
    $F_SERIES['data']['6']['field_name'] = 'Definition';
    
    $F_SERIES['back_to']['back_link']    = '?d=def';
    
    $F_SERIES['show_query']=0;
    
    $F_SERIES['default_fields']=array('dna_code'=>'EBDF');
      
    // unset  
    unset($F_SERIES['data'][4]);
    
    # customization
    $F_SERIES['data']['5']['field_name']  = 'Engines';
    $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',"id,sn","  WHERE entity_code='EG' ");
    
    // after_add_update    
    $F_SERIES['after_add_update']=function ($key_id){
        
        global $G,$F_SERIES,$rdsql,$USER_ID;
        
        $lv;
        $lv['content']=[];
                
        # update def
        
        $rdsql->exec_query("UPDATE entity_child_base SET token=md5(sn) WHERE id=$key_id","0");
                
        # empty matrix
        
        $rdsql->exec_query("DELETE FROM ecb_parent_child_matrix WHERE ecb_parent_id=$key_id","0");
        
        # insert data
        
        $lv['temp_options'] = $_POST['X5'];
       
        if($lv['temp_options']){
        
            foreach(preg_split("/,/",$lv['temp_options']) as $key){
                
                array_push($lv['content'],"($key_id,
                                            $key,
                                            md5(concat((SELECT sn FROM entity_child_base WHERE id=$key_id),'__',
                                            (SELECT token FROM entity_child_base WHERE id=$key))),
                                            $USER_ID)");
            }
            
        } // end
        
        if(count($lv['content'])>0){
            
            $lv['matrix_data'] = implode(',',$lv['content']);
            
            $lv['matrix_query'] = " INSERT INTO ecb_parent_child_matrix(ecb_parent_id,ecb_child_id,parent_child_hash,user_id) VALUES $lv[matrix_data] ";
            
            $rdsql->exec_query($lv['matrix_query'],$lv['matrix_query']);
            
        } // end
        
       # before_update($key_id);       
        
    } # end
    
?>