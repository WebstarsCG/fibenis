
var element;

function check_token(ele) {
    
        element = ele;
        
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
