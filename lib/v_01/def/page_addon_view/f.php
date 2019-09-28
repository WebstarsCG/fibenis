<?PHP

    //F_series definition:
    include("$LIB_PATH/def/ecb_parent_child/f.php");
    
    $temp_addon_type = @$_GET['at'];
    
    $temp_addon_view = ($temp_addon_type)?" AND id IN (SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE ecb_parent_id=$temp_addon_type )":"";
                            
    $F_SERIES['title'] = 'Page Addon';
    
    $F_SERIES['data']['1']['option_data']=$G->option_builder('entity','code,sn'," WHERE code='AT' ORDER by sn ASC");
    
    $F_SERIES['data']['6']['field_name'] = 'Page Addon';
    
    $F_SERIES['back_to']['back_link']    = '?d=page_addon';
    
    
    if($temp_addon_type){
        
        $F_SERIES["default_fields"]=["parent_id"=>$temp_addon_type];
    }
    
    # customization
    
    if(@$_GET['key']){    
        $F_SERIES['temp']['option_data']      = "WHERE  entity_code='EA' $temp_addon_view AND id NOT IN (SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE ecb_parent_id=$_GET[key])";            
        $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base','id,sn',$F_SERIES['temp']['option_data'].' ORDER BY sn ASC');                
    }else{
        $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',"id,sn","  WHERE entity_code='EA' $temp_addon_view   ");
    }
    
    
    
    
?>