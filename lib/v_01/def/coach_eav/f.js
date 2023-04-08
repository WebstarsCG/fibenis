
function check_code(ele) {
    
		G.set_global('coach_code',ele);
        f_series.ajax.set_request('router.php','&series=a&action=coach_eav&token=CODE&param='+ele.value);        
        f_series.ajax.send_get_addon(request_response,ele.value);
            
}

function request_response(response,addon){
        
        var msg = 'message_'+G.get_global('coach_code').id;
                
        if (response == 1) {
                G.get_global('coach_code').value = '';
                document.getElementById(msg).innerHTML = `<span style='color: red;'>Sorry, the coach (<b>${addon}</b>) already exists.</span>`;
        }else{
                document.getElementById(msg).innerHTML = " ";
        }
		
} // end