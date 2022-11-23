function receiveChildMessage(event){

	const param = JSON.parse(event.data);
	var lv ={};
	
	lv.fa_element = document.getElementById('ec_'+param.Xlo); 	
	lv.fa_element.innerHTML	=Number(lv.fa_element.innerHTML)+1;
	
	
		
} // end


window.addEventListener("message", receiveChildMessage, false)