	
	function upgrade_my_plan(comm_key){
		var ajxrqst = new ajax();
		
		var req = '&comm_key='+comm_key+'&action=UPG';
		 
		//alert(req);
		ajxrqst.set_request('inc/ajax_action.php',req);			
		ajxrqst.send_get(upgrade_response);
	}
	
	function upgrade_response(res){
		
		if(res){
			
		 // alert('Sortly upgrade your plan,Thank you');
		
		  G.bs_alert_success("Your Plan will be upgraded shortly");
		  
		 //  page_reload();
		}
	}