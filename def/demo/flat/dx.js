
function base64_decode(content){
	document.write(atob(content));
}

function update_parent_action(){
	
	const page_ids = d_series.getDeskCheckboxSelectedIds();
	
	if(page_ids.length==0){
		bootbox.alert({"size":"small",
				 "message":"Kindly select atleast one item to do the update"});
	}else{
			bootbox.confirm({"size":"small",
							 "message":"Are you sure to Update",
							 "callback":function(response){
								 
								if(response==true){ 
	
								d_series.ajax.set_request("router.php","&series=ax&action=demo__flat&token=OPT_UPD&param="+
																		JSON.stringify({'id':page_ids,
																						'detail':'YN'}));            
								d_series.ajax.send_get(update_parent_action_response);                
								G.showLoader('Updating');
								
								} // if yes
			} // confirm
		} // confirm call
	)} // action
} // end 


function update_parent_action_response(response){
	G.hideLoader();
	if (response == 1) {           
		G.bs_alert_success('Successfully updated');
	}else{                
	   G.bs_alert_error("Sorry, something went wrong");
	}	
}