
	// javascript variable to ajax request		

	function ajaxrequest(get_variable){
		
		this.get_variable = get_variable;
	}
	
	
	// Modified by Raja, before 29-Feb-2012, absence of function response	
	
	ajaxrequest.prototype.initial_stage = function() {
		
		var l_v=new Array();
		

		this.get_variable=GetXmlHttpObject();
		
		
		if (this.get_variable==null){

			alert ("Browser does not support HTTP Request");
			
			return;
		}
		
		this.url=this.get_page_name+"?sid="+Math.random();
		
		// adding query
	
			this.url+=this.get_url_value;
			
			
	
			// Client Communicate  
			 
			var client = new XMLHttpRequest();
		
				client.open("GET", this.url, true);
				
				client.send();
					
				client.onreadystatechange = function() {
					
					if(this.readyState == 4) {
						
						l_v['response']=this.responseText;								
						
						get_ajax_value(l_v['response']);
					}
					
				} // state change
	
	} // end of request
	
	
	// ajax reponse with function call
	// Added by raja, 29-Feb-2012,for dnamic function mapping 
	
	ajaxrequest.prototype.send = function(response_action) {
		
		var l_v=new Array();		

		this.get_variable=GetXmlHttpObject();		
		
		if (this.get_variable==null){

			alert ("Browser does not support HTTP Request");
			
			return;
		}
		
		this.url=this.get_page_name+"?sid="+Math.random();
		
		// adding query
	
		this.url+=this.get_url_value;		
		
		//alert(this.url);
		
		// Client Communicate  
		 
		var client = new XMLHttpRequest();
	
		client.open("GET", this.url, true);
		
		client.send();		
			
		client.onreadystatechange = function() {
			
			if(this.readyState == 4) {
				
				l_v['response']=this.responseText;								
				
				response_action(l_v['response']);
			}
			
		} // state change
		
		
	
	} // end of request 
	
	
	//post reqst
	ajaxrequest.prototype.send_post = function(response_action) {
		
		var l_v=new Array();		

		this.get_variable=GetXmlHttpObject();		
		
		if (this.get_variable==null){

			alert ("Browser does not support HTTP Request");
			
			return;
		}
		
		this.url=this.get_page_name+"?sid="+Math.random();
		
		//alert(this.url);
		
		// adding query
	
		l_v['resquest']=this.get_url_value;		
		
		// Client Communicate  
		 
		var client = new XMLHttpRequest();
	
		client.open("POST",this.get_page_name,true);
					
		client.setRequestHeader("Content-type","application/x-www-form-urlencoded");                        
			
		client.setRequestHeader("Content-length",this.url.length);			
			
                //sclient.onreadystatechange=get_machine_value_temp;
			
		client.onreadystatechange = function() {
			
			if(this.readyState == 4) {
				
				l_v['response']=this.responseText;								
				
				response_action(l_v['response']);
			}
			
		} // state change
		
		client.send(l_v['resquest']);
	
	} // end of request 
	
	
	// Front Request
	
	ajaxrequest.prototype.get_front_request = function(get_page_name,url_value) {
		
		this.get_page_name = get_page_name;
		
		this.get_url_value = url_value;		
	}
	
	
	ajaxrequest.prototype.set_url = function(url_value) {
		
		this.get_url_value = url_value;
		
		//alert(this.get_url_value);
		
	} // end
	
	

	// Getxmlhttp object 
	
	function GetXmlHttpObject() {
		
		if (window.XMLHttpRequest)
		{
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  return new XMLHttpRequest();
		}
		
		if (window.ActiveXObject)
		{
		  // code for IE6, IE5
		  return new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		return null;
	
	} // JavaScript Document