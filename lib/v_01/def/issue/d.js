d_series.crossBorderMessage['status_update']=function(message){

	const param = message.data;

	if(param.status_update==1){
		
		var lv  = {};
		lv.temp = {};	

		// da->default addon
		lv.temp[param.da+'.status']=param.status_name		
		
		// update wating list
		wl.desk.updateStatus(lv.temp);	

	} // status update case

} // end