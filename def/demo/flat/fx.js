	
	function check_validation(element){
		
		if(element.value=="N"){
			f_series.unsetValidationExclude(['X4']);
		}else if(element.value=="Y"){
			f_series.setValidation();
		}
		
	} // end
	
	function after_prefill_action(key_id){		
			
			
			G.$('X4').disabled=true;
			G.$('X4_RO').value=1;
			
			G.$('X7').disabled=true;
			G.$('X7_RO').value=1;
			
	} // end
	
	// check new entry
	function check_new_entity(element){
		
			if(element.value==-1){
				element_show_hide(['22','23'],{'status':true,'is_ro':0});
				f_series.setValidation(['X22','X23']);
			}else{
				element_show_hide(['22','23'],{'status':false,'is_ro':1});
				f_series.unsetValidation(['X22','X23']);
			}
		
	} // end
	
	// check code
	function check_entity_code(ele) {
    
			element = ele;
			
			var req = new ajax();
			
			req.set_request('router.php','&series=a&action=entity&token=ENCO&param='+ele.value);
			
			req.send_get(check_entity_request_response);
			
				
	}

	function check_entity_request_response(response){
			
			var msg = 'message_'+element.id;
					
			if (response == 1) {
					
					element.value = '';
					document.getElementById('X1').focus();
					document.getElementById(msg).innerHTML = "<span style='color: red;'>Already Exist</span>";
						  
			}
			
			else{
					
			document.getElementById(msg).innerHTML = " ";
					
			}
			
	}

	