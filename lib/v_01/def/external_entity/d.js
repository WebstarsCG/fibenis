
function receiveChildMessage(event){
 
	const param = JSON.parse(event.data);
	var lv ={};
	
	lv.fa_element = document.getElementById('ec_'+param.X0); 	
	lv.fa_element.innerHTML	=Number(lv.fa_element.innerHTML)+1;
	
	console.log('Ele'+lv.fa_element.innerHTML);
	
		
} // end


window.addEventListener("message", receiveChildMessage, false)