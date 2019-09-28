

	// Javascript variable to ajax request		

	function ajax(get_variable){
		
		this.get_variable = get_variable;
		
		this.temp 	  = new Array();
		
	} // event 
	
	
	// Modified by Raja, before 29-Feb-2012, absence of function response	
	
	ajax.prototype.initial_stage = function() {
		
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
	
	ajax.prototype.send_get = function(response_action) {
		
		var l_v=new Array();		

		this.get_variable=GetXmlHttpObject();		
		
		if (this.get_variable==null){

			alert ("Browser does not support HTTP Request");
			
			return;
		}
		
		l_v['con'] = (String(this.get_page_name).indexOf('?')>=0)?'&':'?';
		
		this.url=this.get_page_name+l_v['con']+"sid="+Math.random();
		
		// adding query
	
		this.url+=this.get_url_value;		
		
		// Client Communicate  
		// alert('---------------'+this.url);
		 
		var client = new XMLHttpRequest();
	
		client.open("GET", this.url, true);
		
		client.setRequestHeader("Cache-Control", "no-cache");
		
		client.send();		
			
		client.onreadystatechange = function() {
			
			if(this.readyState == 4) {
				
				l_v['response']=this.responseText;								
				
				response_action(l_v['response']);
			}
			
		} // state change
		
		
	
	} // end of request
	
	
	// ajax reponse with function call
	// Added by raja, 29-Feb-2012,for dnamic function mapping 
	
	ajax.prototype.send_post = function(response_action) {
		
		var l_v=new Array();		

		this.get_variable=GetXmlHttpObject();		
		
		if (this.get_variable==null){

			alert ("Browser does not support HTTP Request");
			
			return;
		}
		
		this.url=this.get_page_name+"?sid="+Math.random();
		
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
	
	ajax.prototype.set_request = function(get_page_name,url_value) {

		this.get_page_name = get_page_name;
		this.get_url_value = url_value;		
	}
	
	// set url value // by R 8-Nov-2012	
	
	ajax.prototype.set_page = function(page) {
		
		this.get_page_name = page;
	}
	
	
	// set url value // by R 8-Nov-2012	
	
	ajax.prototype.set_url = function(url_value) {
		
		this.get_url_value = url_value;		
	}
	
	// set value by R, 24-Jan-2013
	
	ajax.prototype.set_value = function(key,value) {
		
		if(ajax.prototype.set_value.arguments.length==0){
	
			alert(' Atleast give storage key id');
			
		}else if(ajax.prototype.set_value.arguments.length==2){
		
			this.temp[key]=value;		
		} // end
				
	} // end of set_value
	
	
	// get value	
	ajax.prototype.get_value = function(key){
		
		if(ajax.prototype.get_value.arguments.length==0){
	
			alert(' Atleast give storage key id');
		}
		
		// if key and value exist
		
		if(ajax.prototype.get_value.arguments.length==1){
	
			if(this.temp[key]==undefined){
				
				alert(' The given key '+key+' did n\'t predefined earlier ');
				return undefined;
				
			}else{
				return this.temp[key];				
			}
						
		} // end
		
		return undefined;		
				
	} // end of get_value
	
	
	
	
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

	
	////////////////////////// Document Response

