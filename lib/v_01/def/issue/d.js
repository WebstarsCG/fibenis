d_series.crossBorderMessage['status']=function(event){

	const param = JSON.parse(event.data);
	
	var lv  = {};
	lv.temp = {};	
	
	// prepare obj
	lv.temp[param.X3+'.status']=G.$(param.X2).innerHTML;		
	
	// update wating list
	wl.desk.updateStatus(lv.temp);	
			
} // end