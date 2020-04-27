        
        f_series.temp.attr_code;
        f_series.temp.entity_code;
        
        function check_code(ele) {
            
                f_series.temp.attr_code = ele;
                                
                f_series.ajax.set_request('router.php','&series=a&action=entity_attribute&token=CODE&param='+f_series.temp.attr_code.value);
                
                f_series.ajax.send_get(request_response);
                    
        }
        
        function request_response(response){
                
                var msg = 'message_'+f_series.temp.attr_code.id;
                        
                if(response == 1){
                        
                        document.getElementById(msg).innerHTML = "<span class='clr_red'>Attribute code <b>"+f_series.temp.attr_code.value+"</b> already exists. Give some another.</span>";                        
                        f_series.temp.attr_code.value = '';
                              
                }else{
                        document.getElementById(msg).innerHTML = " ";
                }
                
        }
        
        // get line order
        function get_line_order(ele) {
            
                f_series.temp.entity_code = ele;
                                
                f_series.ajax.set_request('router.php','&series=a&action=entity_attribute&token=ENT&param='+ele.value);
                
                f_series.ajax.send_get(line_order_response);                    
        
        } // end
        
        // line_order
        function line_order_response(response){
                
                            
                if(Number.isInteger(Number(response))){
                           console.log(response);
                        document.getElementById('X4').value=response;
                              
                }else{
                        document.getElementById('X4').value ='';
                }
        } // end
        
