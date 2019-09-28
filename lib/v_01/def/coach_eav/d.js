
	function coach_content($coach_code){
		
		d_series.ajax.set_request('router.php','&series=a&action=coach_eav&token=GENC&param={"coach_code":"'+$coach_code+'"}')
		
		//d_series.get_resonse_action((function(){alert('--')})());
		G.showLoader('Updating');
		d_series.ajax.send_get(coach_content_response_action);
		
		
		
	}
	
	
	function coach_content_response_action(){
		
		G.hideLoader();
		
		bootbox.alert({ 'message':'Successfully Published',
				'size'   :'small',
							callback: function () {
								  G.hideLoader();
							      }
				});
	} // end