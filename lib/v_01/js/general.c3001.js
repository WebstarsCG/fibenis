
        /* c3001 */
    
        function c3001Create(param){            
        
                this.c3        = c3;                
                this.d_series = d_series;
                this.g        = G;                
                this.action   = {'gauge':this.gauge};
          
        } // class
        
        // Donut
    
        c3001Create.prototype.graphDonut = function(param){
                
                var lv         = new Object();
           
                lv.show_label  = param.show_label || false;
                lv.arc_width   = param.arc_width || 50;
                
                lv.title       = param.title || '';
                
                // cell count
				
		this.d_series.custom_cell_count();
                
                lv.element_id=this.d_series.get_defaut_cell_id({'cols':7,'skip':1,'incr':1});
                
                // data
                
                lv.data_a = param.replace(/\{/gi,"");
                lv.data_b = lv.data_a.replace(/\}/gi,"");
                lv.data_c = lv.data_b.replace(/\"\[/gi,"[");
                lv.data_d = lv.data_c.replace(/\]\"/gi,"]");
		
		//alert(lv.data_d);
                                                                                   
                lv.data   =  JSON.parse('['+lv.data_d+']');
		
		lv.data.shift();
                            
                // donut
            
                lv.addon     = {
                                        title:this.g.$(lv.element_id).getAttribute('data-title'),
                                        
                                        data:{
                                              
                                              
                                            columns: lv.data ,                                            
                                            type: 'donut',
                                                                                        
                                        },
                                       
                                        min:  lv.min, // 0 is default, //can handle negative min e.g. vacuum / voltage / current flow / rate of change
                                        max:  lv.max,
                                       
                                        label: {                                                      
                                                show: lv.show_label // to turn off the min/max labels.
                                        },
                                        
                                        size: {
                                         //   height: lv.height,
                                           // width : lv.width
                                        },
                                         
                                        //units: '%',                                        
                                        width: lv.arc_width // for adjusting arc thickness
                                };
                                
                     
                                
                lv.canvas      ={
                                        'element_id'    : lv.element_id,                                        
                                        'element'       : this.g.$(lv.element_id),                        
                                        'is_row_data'   : 0                        
                                };
                    
                           
                
                this.graph({'data': lv.data,
                            'addon':lv.addon,
                            'canvas':lv.canvas
                        });
                
        } // end
	
	
	// Time Series
        
        c3001Create.prototype.graphBase = function(param){
                
                var lv         = new Object();
           
                lv.show_label  = param.show_label || false;
               
                
                lv.title       = param.title || '';
                
                // cell count
				
		this.d_series.custom_cell_count();
                
                lv.element_id=this.d_series.get_defaut_cell_id({'cols':7,'skip':1,'incr':1});
		lv.element   = this.g.$(lv.element_id);
                
                // data
                
                lv.data_a = param.replace(/\{/gi,"");
                lv.data_b = lv.data_a.replace(/\}/gi,"");
                lv.data_c = lv.data_b.replace(/\"\[/gi,"[");
                lv.data_d = lv.data_c.replace(/\]\"/gi,"]");
                                                                                   
                lv.data   =  JSON.parse('['+lv.data_d+']');

				lv.cat = [];
				
				for(var x in lv.data){
					
					lv.cat.push(lv.data[x].shift());
					
				}
				
				lv.cat.shift();
				//console.log(lv.data);
				//console.log(lv.cat);
                                            
                // base
            
                lv.addon     = {
                                        title:lv.element.getAttribute('data-title'),
                                        
                                        data: {
                                               // x    : lv.data[0][0],
                                               'type': this.g.isUndefined(lv.element.getAttribute('data-type'),'line'),                                                
                                                rows : lv.data
										},
                                        
                                        bar: {
						
											width: this.g.isUndefined(lv.element.getAttribute('data-bar-width'),20) // this makes bar width 100px
                                        },
                                            
                                        axis: {
                                          x:{type: 'category',
										  categories:lv.cat}
                                        },
                                        grid: {
                                                x: {
                                                    show: this.g.isUndefined(lv.element.getAttribute('data-grid-x'),true)
                                                },
                                                y: {
                                                    show: this.g.isUndefined(lv.element.getAttribute('data-grid-y'),true)
                                                }
                                            },
					    
					 
                                };
                                
                     
                                
                lv.canvas      ={
                                        'element_id'    : lv.element_id,                                        
                                        'element'       : this.g.$(lv.element_id),                        
                                        'is_row_data'   : 0                        
                                };
                                     
                
                this.graph({'data': lv.data,
                            'addon':lv.addon,
                            'canvas':lv.canvas
                        });
                
        } // end
	
    
        // Time Series
        
        c3001Create.prototype.timeSeries = function(param){
                
                var lv         = new Object();
           
                // cell count				
				this.d_series.custom_cell_count();
                
                lv.element_id=this.d_series.get_defaut_cell_id({'cols':7,'skip':1,'incr':1});
				lv.element   = this.g.$(lv.element_id);
                
                // data
                
                lv.data_a = param.replace(/\{/gi,"");
                lv.data_b = lv.data_a.replace(/\}/gi,"");
                lv.data_c = lv.data_b.replace(/\"\[/gi,"[");
                lv.data_d = lv.data_c.replace(/\]\"/gi,"]");
                                                                                   
                lv.data   =  JSON.parse('['+lv.data_d+']');
                
               // alert(JSON.stringify(lv.data));
                            
                // donut
            console.log('b'+this.g.isUndefined(lv.element.getAttribute('data-bar-width'),10));
                lv.addon     = {
                                        title:lv.element.getAttribute('data-title'),
                                        
                                        data: {
                                                x: 'x',
                                                'type':this.g.isUndefined(lv.element.getAttribute('data-type'),'line'),
                                                //xFormat: '%Y-%m-%d', // 'xFormat' can be used as custom format of 'x'
                                                rows: lv.data
                                            },
                                        
										bar	: {  width: this.g.isUndefined(Number(lv.element.getAttribute('data-bar-width')),25) }, // width px
                                            
                                        axis: {
                                            x: {
                                                type: 'timeseries',
                                                tick: {
                                                    format	: this.g.isUndefined(lv.element.getAttribute('data-format'),'%d-%b-%y'),
													fit	  	: true,
													culling	: { max:  this.g.isUndefined(lv.element.getAttribute('data-culling-max'),1) },                                                     
                                                }
                                            }
                                        },
										
                                        grid: {
                                                x: {
                                                    show: this.g.isUndefined(lv.element.getAttribute('data-grid-x'),false)
                                                },
                                                y: {
                                                    show: this.g.isUndefined(lv.element.getAttribute('data-grid-y'),false)
                                                }
                                            },
					    
										zoom	: { enabled: this.g.isUndefined(lv.element.getAttribute('data-zoom'),false)},
					    
										subchart: { show   : this.g.isUndefined(lv.element.getAttribute('data-subchart'),false)}
                                };
                                
                     
                                
                lv.canvas      ={
                                        'element_id'    : lv.element_id,                                        
                                        'element'       : this.g.$(lv.element_id),                        
                                        'is_row_data'   : 0                        
                                };
                    
                           
                
                this.graph({'data': lv.data,
                            'addon':lv.addon,
                            'canvas':lv.canvas
                        });
                
        } // end
    
    
        c3001Create.prototype.graph = function(param){                
                        
                var lv = new Object({});
              
                lv.info=[];
                
                lv.param={};
                                
                var addon  = param.addon || {};
                
                var canvas  = param.canvas;
                
                var data    = param.data;
                
                
                // ha param
                
                if(data.length>0){
                        
                        // create head & cel content
                        
                        lv.title                = canvas.element.getAttribute('data-title');
                        
                        canvas.element.innerHTML='<span id="'+canvas.element_id+'_head" class="title">'+lv.title+'</span>'+
                                                 '<span id="'+canvas.element_id+'_cont" class="graph"></span>';
                     
               
                        // lv param
                        
                        lv.param = {
                                
                                'bindto'      : ELEMENT(canvas.element_id+'_cont'),
                                'title'       : lv.title,                          
                                'addon'       : addon
                        };
                        
                  
                        
                       this.draw(lv.param);
                    
                } // end
                
        } // end
                
        // dount/gauge/pie
        
        c3001Create.prototype.draw = function(param){
            
                var lv = new Object();
             
                // param
                
                lv.param       ={            
                                        bindto:param.bindto,    
                                          
                                        //tooltip: {
                                        //     show: false
                                        //}
                                };
                
                // addon
                
                if(param.addon!=undefined){
                
                        lv.addon_keys  = Object.keys(param.addon);
       
                        // each
                        
                        for(var idx in lv.addon_keys){
                           
                           lv.param[lv.addon_keys[idx]] = param.addon[lv.addon_keys[idx]];
                           
                        } // each addon param
                       
                } // end
				
				//console.log(lv.param);
                                                                  
                ///////// Chart 
        
                var chart = this.c3.generate(lv.param);
          
        } // end
            
            
        
        var c3001 = new c3001Create();              