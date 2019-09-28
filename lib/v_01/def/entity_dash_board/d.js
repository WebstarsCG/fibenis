	
	
	d_series.has_focus_row=0;
	
	// Grpah bar
	
	function graph_bar_no(param){
	    
		var lv = new Object({});
		
		lv.add_on = {};
		
		lv.add_on['type']='bar';
		
		lv.add_on['axis']={
		    
				    x: {					     
					type: 'category',
					categories: ['']
				    },
			    
				    y: {
						label:{text:'Nos', position: 'inner-middle'},
						tick: {
						    count: 2,
						    format: function (d) { return  d.toFixed(0); }
						}
				    }
				};
				
		lv.add_on['legend'] = { position: 'right' };
				
	    
	        graph_direct(param,lv.add_on)
	    
	    
	} // end
	
	
	function  graph_direct(param,param_add_on){                
                                
                                var lv = new Object({});
                              
                                lv.info=[];
				
				lv.param={};
				
				lv.title = '';                 
				
				
				var add_on  = param_add_on || {};
				
				// cell count
				
				d_series.custom_cell_count();
				
				// ha param
                                
                                if(param.length>0){
				    
				   lv.element_id=d_series.get_defaut_cell_id({'cols':7,'skip':1,'incr':1});
				
				// create head & cel content
				
				lv.title = G.$(lv.element_id).getAttribute('data-title');
				
				ELEMENT(lv.element_id).innerHTML='<span id="'+lv.element_id+'_head" class="title">'+lv.title+'</span>'+
				                                 '<span id="'+lv.element_id+'_cont" class="graph"></span>';
				  
				    
				    lv.width =  add_on.width  || '';
				    lv.height=  add_on.height || '';
				                                    
                                    lv.data = JSON.parse(param);
                                    
					// Data
				    
					for(var idx in lv.data){
					
					    lv.temp = lv.data[idx].split(':'); 
					
					    if (Number(lv.temp[1])>0){						
						                                   
						lv.info.push([lv.temp[0],lv.temp[1]]);
					    }
					}
					
					
				    // lv param
				    
				    lv.param = {
					    
						'draw_area'   : ELEMENT(lv.element_id+'_cont'),
						'title'       : lv.title,
						'data_columns': lv.info,    
						'show_label'  : false,
						'type'        : 'donut',
						'height'      : lv.height,  
						'width'       : lv.width};
				    
				    // addon
				    
				    if(add_on!=undefined){
				    
					    lv.add_on_keys  = Object.keys(add_on);
			   
					    // each 
					   
					    for(var idx in lv.add_on_keys){
					       
					       lv.param[lv.add_on_keys[idx]] = add_on[lv.add_on_keys[idx]];
					       
					    } // each addon param
					   
				    } // end
				    
				    C3.draw(lv.param);
                                    
                                } // end
            } // end
	    
	    
	    
	 
    
