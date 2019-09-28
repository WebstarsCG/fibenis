
            /* c3 */
            
            function c3_gen(param){            
            
                    this.c3 = c3;
                    
                    this.action = {'gauge':this.gauge};
              
            } // class
            
            var C3 = new c3_gen();
            
                        
            // dount/gauge/pie
            
            c3_gen.prototype.draw = function(param){
                
                    var lv = new Object();
                    
                    //size
                    
                    lv.height = param.height || undefined;
                    lv.width  = param.width  || undefined;
                    
                    // data columns
                   
                    lv.data_columns = param.data_columns || [[]];
                    
                    // setup
                   
                    
                    lv.type        = param.type || 'bar';
                    
                    // param
                    
                    lv.param       = {
                
                                            bindto:param.draw_area,    
                                              
                                            data: {
                                                  
                                                  
                                                columns:  param.data_columns,
                                                
                                                type: lv.type,
                                                
                                                onclick: function (d, i) { console.log("onclick", d, i); },
                                                onmouseover: function (d, i) { console.log("onmouseover", d, i); },
                                                onmouseout: function (d, i) { console.log("onmouseout", d, i); },                                                
                                       },

                                            size: {
                                                height: lv.height,
                                                width : lv.width
                                            },
                                            
                                            tooltip: {
                                                 show: false
                                            }
                                    };
                    
                                        
                    lv.add_on       = this[lv.type](param);
                    
                    lv.add_on_keys  = Object.keys(lv.add_on);
                    
                    // each 
                    
                    for(var idx in lv.add_on_keys){
                        
                        lv.param[lv.add_on_keys[idx]] = lv.add_on[lv.add_on_keys[idx]];
                        
                    } // each addon param
                    
                                        
                    ///////// Chart 
            
                    var chart = this.c3.generate(lv.param);
              
            } // end
            
            
            // c3_gen gauge
            
            c3_gen.prototype.gauge = function(param){
                
                
                    var lv              = new Object();
                    
                    lv.add_on           = {};
                 
                    lv.pattern          = param.pattern || ['#FF0000', '#F97600', '#F6C600', '#60B044'];
                    
                    lv.threshold_values = param.threshold_values || [30, 60, 90, 100];
                    
                    // gauge
                    
                    lv.min         = param.min || 0;
                    lv.max         = param.max || 100;
                    lv.arc_width   = param.arc_width || 36;
                    
                    lv.show_label  = param.show_label || false;                
                
                    // gauge
                    
                    lv.add_on['gauge']= {
                                                
                                                    min:  lv.min, // 0 is default, //can handle negative min e.g. vacuum / voltage / current flow / rate of change
                                                    max:  lv.max,
                                                  
                                                    label: {
                                                        format: function(value, ratio) {
                                                            return (ratio*100).toFixed(0)+'%';
                                                        },
                                                        show: lv.show_label // to turn off the min/max labels.
                                                    },
                                                    
                                                    //units: '%',
                                                    width: lv.arc_width // for adjusting arc thickness
                                    };
                                    
                                    
                    lv.add_on['color']  =  {
                                                pattern: lv.pattern, // the three color levels for the percentage values.
                                                threshold: {
                                                    unit    : 'percentage', // percentage is default
                                                    max     : lv.max, // 100 is default
                                                    values  : lv.threshold_values
                                                }
                                        };
                                    
                    return lv.add_on;
                
            } // end
            
            
                // c3_gen gauge
                
                c3_gen.prototype.donut = function(param){
                            
                            var lv         = new Object();
                            
                            lv.show_label  = param.show_label || false;
                            lv.arc_width   = param.arc_width || 18;
                            
                            lv.title       = param.title || '';
                            
                            lv.add_on      = [];
                            
                            // donut
                        
                            lv.add_on['donut']= {
                                                       title:lv.title,
                                                      
                                                    
                                                        min:  lv.min, // 0 is default, //can handle negative min e.g. vacuum / voltage / current flow / rate of change
                                                        max:  lv.max,
                                                      
                                                        label: {                                                      
                                                            show: lv.show_label // to turn off the min/max labels.
                                                        },
                                                        
                                                        //units: '%',
                                                        width: lv.arc_width // for adjusting arc thickness
                            };
                    
                            return lv.add_on;
                    
                } //end
            
            
                // c3_gen pie
                
                c3_gen.prototype.pie = function(param){
                    
                            return {};
                    
                } //end
            
            
                // c3_gen bar
                
                c3_gen.prototype.bar = function(param){
                        
                            var lv              = new Object();
                        
                            lv.add_on           = {};
                            
                            if (param.axis) {
                                
                                lv.add_on['axis']=param.axis;
                                
                            } // end
                    
                            return lv.add_on;
                    
                } //end
                
                // c3_gen bar
                
                c3_gen.prototype.line = function(param){
                    
                            return {};
                    
                } //end
                
                // c3_gen bar
                
                c3_gen.prototype.area = function(param){
                    
                            return {};
                    
                } //end
                
                
            
            
            