



    function input_type_action(element){
        
        
            var lv = new Object({});                  
        
            lv['ITGX']=function(){
                    element_show_hide([8],{'status':true,is_ro:0});
                    element_show_hide([9],0);
            }
            
            lv['ITG1']=function(){
                    element_show_hide([8,9],0);        
            }
            
            lv['ITSL']=function(){
                    element_show_hide([8],0);
                    element_show_hide([9],{'status':true,is_ro:0});
            }
            
            lv['ITHD']=function(){
                    element_show_hide([8,9],0);        
            }
            
            lv['ITNM']=function(){
                    element_show_hide([8,9],0);        
            }
            
            lv['ITRG']=function(){
                    element_show_hide([8,9],0);        
            }
            
            lv['ITTX']=function(){
                    element_show_hide([8,9],0);        
            }
        
            lv['ITTB']=function(){
                    element_show_hide([8,9],0);        
            }
        
            // action
        
            if(lv[element.value]!=undefined){
                
                lv[element.value]();
            };
        
        
    }  // end
    
    
   
        
        function check_token(ele) {
           
                
                var req = new ajax();
                
                req.set_request('router.php','&series=a&action=entity_child_base&token=TKCO&param='+ele.value);
                
                req.send_get(request_response);
                    
        }
        
        function request_response(response){
                
                var msg = 'message_'+element.id;
                        
                if (response == 1) {
                        
                        element.value = '';
                        
                        document.getElementById(msg).innerHTML = "<span style='color: red;'>Already Exist</span>";
                              
                }
                
                else{
                        document.getElementById(msg).innerHTML = " ";
                        
                }
                
        }
        
        // external attribute load
        
        function external_attribute_load(param) {
                
                var addon       = document.getElementById('default_addon').value;
                
                var addon_param = (addon.length>0)?'&default_addon='+addon+'&menu_off=1':'';
                
                console.log('ap'+addon_param);
                
                document.location.href="?f="+document.getElementById('app_key').value+param+addon_param;
                
        } // end