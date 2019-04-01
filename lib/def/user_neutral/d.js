    function send_user_mail(counter){
    
        var request_key_values = new ajax();
    
        var lv = new Object();
    
        lv.pass_id = document.getElementById('PASS_ID').value;
    
        lv.id = document.getElementById('HX_' + counter + '_1').value;
    
        lv.email = document.getElementById('HX_' + counter + '_2').value;
    
        var check = ask_once("Are you sure want to send login credentials to user email?");
    
        if (check === true) {
    
            request_key_values.set_request("inc/ajax_action.php", "&action=sendemail&email=" + lv.email);
    
            request_key_values.send_get(server_response);
    
        }
    
    }
    
    function server_response(response) {
    
        alert("Mail sent successfully " + response);
    }
    
    
    // Deactive users
    
    function deactive_users() {
        
        var row_id = GET_E_VALUE('D_COUNTER');
    
        var userids = new Array();
    
        for(var id = 1; id <= row_id; id++){
    
            if (document.getElementById("c" +id).checked === true) {
                userids.push(document.getElementById("c" + id).value);
            }
        }
    
        if(userids.length==0){
            
            bootbox.alert({
                                            
                   message: "Kindly select atleast one user to deactivate"
            });
            
            
        }else if(userids.length>0){
            
            bootbox.confirm({
                                            
                                            message: "Are you sure to deactivate the selected users?",
                                            
                                            buttons: {
                                                confirm: {
                                                    label: 'Yes',
                                                    className: 'btn-success'
                                                },
                                                cancel: {
                                                    label: 'No',
                                                    className: 'btn-danger'
                                                }
                                            },
                                            callback: function (result) {
                                                
                                                       if(result==true){
                                                                  
                                                                  G.showLoader('Updating');
                      
                                                                  d_series.ajax.set_request('router.php','&series=a&action=user_neutral&token=UNIA&param='+userids);                                                                  
                                                                  d_series.ajax.send_get(deactivate_status);                                            
                                                                  
                                                       } // end
                                            }
            });
    
        }
        
    } // end
    
    function deactivate_status(response) {
    
                page_reload();
    
    }
    
     // Deactive users
    
    function active_users() {
        
        var row_id = GET_E_VALUE('D_COUNTER');
    
        var userids = new Array();
    
        for(var id = 1; id <= row_id; id++){
    
            if (document.getElementById("c" +id).checked === true) {
                userids.push(document.getElementById("c" + id).value);
            }
        }
    
        if(userids.length==0){
            
            bootbox.alert({
                                            
                   message: "Kindly select atleast one user to activate"
            });
            
            
        }else if(userids.length>0){
            
            bootbox.confirm({
                                            
                                            message: "Are you sure to Activate the selected users?",
                                            
                                            buttons: {
                                                confirm: {
                                                    label: 'Yes',
                                                    className: 'btn-success'
                                                },
                                                cancel: {
                                                    label: 'No',
                                                    className: 'btn-danger'
                                                }
                                            },
                                            callback: function (result) {
                                                
                                                       if(result==true){
                                                                  
                                                                  G.showLoader('Updating');
                      
                                                                  d_series.ajax.set_request('router.php','&series=a&action=user_neutral&token=UNIB&param='+userids);                                                                  
                                                                  d_series.ajax.send_get(activate_status);                                            
                                                                  
                                                       } // end
                                            }
            });
    
        }
        
    } // end
    
    function activate_status(response) {
    
                page_reload();
    
    }