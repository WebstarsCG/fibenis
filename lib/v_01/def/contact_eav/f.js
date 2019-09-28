
var element;


function check_mobile(ele) {
    
        element = ele;
        
        var req = new ajax();
        
        req.set_request('router.php','&series=a&action=contact_eav&token=MOBL&param='+ele.value);
        
        req.send_get(request_response_mobile);
            
}

function request_response_mobile(response){
       
       
        
        var msg = 'message_'+element.id;
                
        if (response != 0) {
                
                element.value = '';
                
                document.getElementById(msg).innerHTML = "<span style='color: red;'>Mobile Number Already Registered</span>";
                      
        }
        
        else{
                document.getElementById(msg).innerHTML = "<span style='color: green;'></span>";
                
        }
        
}

function check_email(ele) {
    
        element = ele;
        
        var req = new ajax();
        
        req.set_request('router.php','&series=a&action=contact_eav&token=EMID&param='+ele.value);
        
        req.send_get(request_response_email);
            
}

function request_response_email(response){
        
        var msg = 'message_'+element.id;
                
        if (response != 0) {
                
                element.value = '';
                
                document.getElementById(msg).innerHTML = "<span style='color: red;'>Email ID Already Registered</span>";
                      
        }
        
        else{
                document.getElementById(msg).innerHTML = "<span style='color: green;'></span>";
                
        }
        
}