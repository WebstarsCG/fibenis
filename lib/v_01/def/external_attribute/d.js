

    
    var temp_external_attr = new ajax();
    
    function get_checked_items(element_length,prefix){
        
        var lv = new Object({});
        
        lv.checked_items=[];
        
        for(ele_index=1;ele_index<=element_length;ele_index++){
            
            lv.element = document.getElementById(prefix+''+ele_index);   
            
            if(lv.element.checked==true) {
             
                lv.checked_items.push(lv.element.value);
            }
        }
        
        return lv.checked_items.join(',');
    }

    function set_active(){
        
        var lv = new Object({});
        
        lv.check_item_text = get_checked_items(GET_E_VALUE('COUNTER'),'c');
        
        if(lv.check_item_text.length>0){
            
            lv.param_data={'ids':lv.check_item_text,'ia':1};
            
            temp_external_attr.set_request('router.php','&series=a&action=external_attribute&token=ECBIA&param='+JSON.stringify(lv.param_data));
            
            temp_external_attr.send_get(active_response_action);
            
        }else{
                
            bootbox.alert('Kindly select an item');            
        }
        
    } // end
    
    
    function set_inactive(){
        
        var lv = new Object({});
        
        lv.check_item_text = get_checked_items(GET_E_VALUE('COUNTER'),'c');
        
        if(lv.check_item_text.length>0){
            
            lv.param_data={'ids':lv.check_item_text,'ia':0};
            
            temp_external_attr.set_request('router.php','&series=a&action=external_attribute&token=ECBIA&param='+JSON.stringify(lv.param_data));
            
            temp_external_attr.send_get(active_response_action);
            
        }else{
                
            bootbox.alert('Kindly select an item');            
        }
        
    } // end
    
    function active_response_action(response){        
        
            if (Number(response)==0){
                    
                bootbox.alert('Unable to process');    
                    
            }else{
                bootbox.alert(response,function(){ page_reload(); });  
            }
    }
    
    // i/p:  <id>:<input_type>
    function ex_edit(input) {
        
        var data = input.split(':');
        
        var addon = document.getElementById('default_addon').value;
        
        var addon_param = (addon.length>0)?'&default_addon='+addon:'';
        
        window.location = '?f='+data[2]+'&i_t='+data[1]+'&key='+data[0]+addon_param,"_blank",'width=800,height=600,left=10,top=50,toolbar=0,scrollbars=1,menubar=0,status=0';
    }