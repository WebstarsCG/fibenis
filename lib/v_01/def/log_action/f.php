<?PHP

    include("$LIB_PATH/def/ecb_parent_child/f.php");
    
    $F_SERIES['title'] = 'Definition';
    
    # option data
    
    $F_SERIES['data']['1']['option_data']   =   $G->option_builder('entity','code,sn'," WHERE code='LX' ORDER by sn ASC");
                                      
    $F_SERIES['data']['2']['field_id']      = 'token';
    
    $F_SERIES['data']['3']['field_id']      = 'sn';
                                             
    $F_SERIES['data']['6']['field_name']    = 'Definition';
    
    $F_SERIES['back_to']['back_link']       = '?d=log_action';
    
    
    
    $F_SERIES['default_fields'] = array("dna_code" => "EBAX");
      
    #$F_SERIES['show_query']                 = 1;
    
    #$F_SERIES['avoid_trans_key_direct']     = 1;
    
    # customizatiol
    
    //if(@$_GET['key']){    
    //    $F_SERIES['temp']['option_data']      = "WHERE  entity_code='LX' AND dna_code='EBMS' AND id NOT IN (SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE ecb_parent_id=$_GET[key])";            
    //    $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base','id,sn',$F_SERIES['temp']['option_data'].' ORDER BY sn ASC');                
    //}else{
        $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',"id,concat(ln,' (',sn,')')","  WHERE entity_code='LX' AND dna_code='EBMS'");
        $F_SERIES['data']['5']['input_html']=" class='w_300'  style='height:200px !important' " ;
    //}height='200px'"
    
     // after_add_update
    
    $F_SERIES['after_add_update']=function ($key_id){
        
        global $G,$F_SERIES,$rdsql,$USER_ID;
        
        $lv;
        $lv['content']=[];
                
        # empty matrix
        
        $rdsql->exec_query("DELETE FROM ecb_parent_child_matrix WHERE ecb_parent_id=$key_id","0");
        
        # insert data
        
        $lv['temp_options'] = $_POST['X5'];
       
        if($lv['temp_options']){
        
            foreach(preg_split("/,/",$lv['temp_options']) as $key){
                
                array_push($lv['content'],"($key_id,
                                            $key,
                                            md5(concat((SELECT token FROM entity_child_base WHERE id=$key_id),'__',
                                            (SELECT token FROM entity_child_base WHERE id=$key))),
                                            $USER_ID)");
            }
            
        } // end
        
        if(count($lv['content'])>0){
            
            $lv['matrix_data'] = implode(',',$lv['content']);
            
            $lv['matrix_query'] = " INSERT INTO ecb_parent_child_matrix(ecb_parent_id,ecb_child_id,parent_child_hash,user_id) VALUES $lv[matrix_data] ";
            
            $rdsql->exec_query($lv['matrix_query'],$lv['matrix_query']);
            
        } // end
        
       //before_update($key_id);       
        
    } # end
    
?>