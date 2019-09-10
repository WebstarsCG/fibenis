

function check_pwd() {
        
        if (G.$('X1').value!=G.$('X2').value){
        
                G.$('X1').value='';
                G.$('X2').value='';
                
                var msg = 'message_'+G.$('X2').id;
                
                document.getElementById(msg).innerHTML = "<span style='color: red;' class='txt_size_14 b'>Password Doesn't Match</span>";
        
        }
        
}


