

	   /////////////////////////// d_series //////////////////////////////////////////////////////////////////////
	   
	   
	   function  D_Series(){		      
		      
		      // prefix
		      
			  this.key_id	= 'key_id_';
			  
			  this.nd_wall	= 'nd_wall_';
			  
			  this.nd_ground 	= 'nd_ground_';
			  
			   this.desk_chkbox_px = 'c';
			  
			  this.row_id 	= 'row_id_';
			  
			  this.css	 	= {'dynamic_label':'fbn_dyn_lbl'},
			  
			  this.node ={'config':'d_series_config'},
					  
			  this.last_key     = '';
			  
			  this.has_focus_row = 1;
			  
			  this.last_selected_row = '';
			  
			  this.custom_cell_counter = -1;
			  
			  this.refresh_on_close = 0;
			  
			  this.ajax          = new ajax();	 
			  
			  this.g			 = new General();

			this.is_start_action=false;	
			this.is_scroll_action=false;
			this.is_sort_action=false;	
			this.is_scroll_sort_action=false;
			
			this.delete_queue = [];
		      
	   } // d_series
	   
	    
		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		///	Name		: setDeskAction
		///	Short Brief	: set desk action
		///	i/p		: {<actiontwo letter code token>}	
		//////////////////////////////////////////////////////////////////////////////////////////////////////////	
		D_Series.prototype.setDeskStartAction=function(param){
			
			this.is_start_action =true;	
			this.is_scroll_action=false;	
			this.is_scroll_sort_action=false;	
			E_V_PASS('start_page',0);	
			
			if(this.getDeskConfig('hide-pager')!=1 && this.getDeskConfig('show-all-rows')!=1){
				G.$('pager_action').dataset.pager=0;
			}
			
		} // end
		
		D_Series.prototype.setDeskPageAction=function(param){
			this.is_start_action =false;
			this.is_scroll_action=false;	
			this.is_scroll_sort_action=false;				
		} // end
		
		D_Series.prototype.getDeskStartAction=function(param){
			return this.is_start_action;			
		} // end
		
		D_Series.prototype.setDeskScrollAction=function(param){
			this.is_scroll_action=true;	
			this.is_scroll_sort_action=false;			
		} // end
		
		D_Series.prototype.getDeskScrollAction=function(param){
			return this.is_scroll_action;			
		} // end
		
		D_Series.prototype.setDeskSortAction=function(param){
				
			
			if((this.is_scroll_action==false) && (this.is_scroll_sort_action==false)) {
				this.setDeskPageAction();
			}else{
					this.is_start_action =true;
					this.is_scroll_action=false;	
					this.is_scroll_sort_action=true;					
					//	E_V_PASS('start_page',0);	
					//E_V_PASS('page',G.$('pager_loaded_rows').dataset.pager);
			}
			
		} // end
		
		D_Series.prototype.getDeskSortAction=function(param){
			return this.is_sort_action;			
		} // end
		
		D_Series.prototype.getDeskScrollSortAction=function(param){
			return this.is_scroll_sort_action;			
		} // end
        
		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		///	Name		: getDeskConfig
		///	Short Brief	: get d_series configured variables
		///	i/p		: {<data attribute name>}	
		//////////////////////////////////////////////////////////////////////////////////////////////////////////	
		D_Series.prototype.getDeskConfig=function(attribute_name){			
			
			return document.getElementById(this.node.config).getAttribute(`data-${attribute_name}`);
			
		} // name
		,
		D_Series.prototype.setDeskConfig=function(attribute_name,attribute_value){			
			
			document.getElementById(this.node.config).setAttribute(`data-${attribute_name}`,attribute_value);
			
		} // name
		
		
        D_Series.prototype.set_nd=function(param){
                      
					var lv = new Object({});
					  
					// condition to avoid emty strings 
					if(param.length>0){	
                      
						lv.param = JSON.parse(param);
					  
						// avoid empty object
						if(Object.keys(lv.param).length!=0){
					 
							  if( (lv.param.is_fa) && (!lv.param.is_fa_btn)){
										 
										 lv.title=(lv.param.fa_title)?lv.param.fa_title:'';
							  
										 return '<a href="JavaScript:d_series.call_nd('+encodeURI(param)+')" class="ficon hint--left" data-hint="'+lv.param.link_title+'"><i class=" fa '+lv.param.is_fa+'" aria-hidden="true"></i>'+lv.title+'</a>';           
							  }
							  else if( (lv.param.is_fa) && (lv.param.is_fa_btn)){
										 
										  return '<a  class="btn '+lv.param.is_fa_btn+' hint--bottom"  href="JavaScript:d_series.call_nd('+encodeURI(param)+')"  data-hint="'+lv.param.title+'" >'+
															  '<i class=" fa '+lv.param.is_fa+'"></i>'+
															  '<span id='+lv.param.token+'>'+lv.param.link_title+'</span></a>';           
							  }
							  else{
								  
										lv.title = (lv.param.wl_token)?`[[wl.${lv.param.wl_token} default=${lv.param.link_title}]]`:lv.title;
							 
										return "<a href=JavaScript:d_series.call_nd("+encodeURI(param)+")>"+lv.title+"</a>";           
							  }
						} // end
					}
           } // end
           
           
	   //////////////////////////////////////////////////////////////////////////////////////////////////////////
	   ///	Name		: set_nd
	   ///	Short Brief	: send input to set_nd_content
	   ///	i/p		: {id:'<element_idx>','title':<title>',src:'<content>',style:'<content>'}
	   ///	o/p		: call set_nd_content
	   //////////////////////////////////////////////////////////////////////////////////////////////////////////
           D_Series.prototype.call_nd=function(param){
                      
                      var lv 			= new Object({});
					  
					  console.log('---'+JSON.stringify(param));
                      
                      lv.counter=document.getElementById('row_idx_'+param.id).value;
                      
                      param.style = (param.style==undefined)?"border:none;width:100%;height:600px;":param.style;
                      
                      d_series.set_nd_content({
                                 
                                            'ele_idx'   : lv.counter,
                                   
                                            'title'     : param.title,
                                  
                                            'key'       : 'nd_'+param.id,
                                            
                                            'refresh_on_close' : param.refresh_on_close,
                                  
                                            'content'   : '<iframe border="no" style="'+param.style+'"'+
                                                            'src="'+param.src+'"></iframe>'                               
                      });                      
                      
           } // end
           
	   	   
	   //////////////////////////////////////////////////////////////////////////////////////////////////////////
	   ///	Name		: set_nd_content
	   ///	Short Brief	: set HTML content to narrow down ground
	   ///	i/p		: {ele_idx:'<element_idx>',content:'<content>'}
	   ///	o/p		: set/clear content based on display	   
	   //////////////////////////////////////////////////////////////////////////////////////////////////////////
	   
	   D_Series.prototype.set_nd_content=function(param){
                      
		      var lv 			= new Object({});
                    
		      lv.key_id              	= document.getElementById(this.key_id+param.ele_idx).value;
                      
		      lv.narrow_down_area   	= document.getElementById(this.nd_wall+lv.key_id);
                      
                      lv.narrow_down_area.state = lv.narrow_down_area.style.display;
                      
                      lv.narrow_down_element	= document.getElementById(this.nd_ground+lv.key_id);
                      
                      this.refresh_on_close     = (param.refresh_on_close!=undefined)?param.refresh_on_close:0;
                      
		      // check for new row
                      
                      if( (param.key!=this.last_key) || ( (param.key==this.last_key) && (param.content!=this.last_content))
                          || ( (param.key==this.last_key) && (param.content==this.last_content) && (lv.narrow_down_area.style.display=='none') ) 
                         ){              
                                                                    
                                 lv.narrow_down_gate                    = '';
                                 
                                 lv.narrow_down_element.innerHTML      = '';
                                                                  
                                 // title
                                 
                                 if(param.title!=undefined){
                                 
                                            lv.narrow_down_gate       = '<div class="box_gate ">'+
                                                                             '<div class="clr_box_gray_5 pad_7 pad_tb txt_int_50">'+param.title+'</div>'+
                                                                             '<div class="clr_box_red pad_7 pad_tb pointer" onclick="JavaScript:d_series.nd_close(\''+lv.narrow_down_area.id+'\');">X</div>'+
                                                                        '</div>';
                                 }
                                        
                                 lv.narrow_down_area.style.display	= 'table-row';
                               
                                 lv.narrow_down_area.style.width	= '100%';
                                 
                                 lv.narrow_down_element.innerHTML 	= lv.narrow_down_gate+param.content;
                                 
                                 document.location.href			= "#"+this.row_id+""+param.ele_idx+"_1";
                                
                                 
                      }else{ // existing and opened
                      
                      
                                 if(lv.narrow_down_area.state=='table-row'){
                                            
                                     lv.narrow_down_element.innerHTML  	= '';
                                     
                                     lv.narrow_down_area.style.display 	= 'none';                                                                          
                                 }
                      
                      } // end key check
                      
                      // store current key
                      
                      this.last_key                         = param.key;
                      
                      this.last_content                     = param.content;
                      
	   } // end
	   
	   // get key_id
	   
	   D_Series.prototype.get_key_id=function(ele_idx){
                      
                      
                      
		      if(is_element_exists(this.key_id+ele_idx)){
                                 
				 return  document.getElementById(this.key_id+ele_idx).value;
                                 
                                 
		      }else{
				 
				 alert('Undefined element call');
				 return false;
		      }
	   } // end
           
           
           // close
	   
	   D_Series.prototype.nd_close=function(wall_id){
                      
                      var lv = new Object({});
                      
		      if(is_element_exists(wall_id)){
                                 
                                 document.getElementById(wall_id).style.display = 'none';
                                 
                                 if(this.refresh_on_close==1){
                                            
                                            page_refresh();
                                 }
                                 
		      }else{				 
				 alert('Undefined element call');				 
		      }
                      
	   } // close
           
           
           // get row col
           
           D_Series.prototype.get_row_col=function(param){
                      
                      var lv = new Object({});
                      
                      lv.tot = param.cols || 1;
                      
                      lv.skip = param.skip || 1;
                      
                      lv.incr = param.incr || 1;
                      
                      lv.custom_cell_counter = this.custom_cell_counter;
                      
		      lv.row=(lv.custom_cell_counter<=lv.tot)?1:(Math.ceil(lv.custom_cell_counter/lv.tot));
            
                      lv.col=(lv.custom_cell_counter<=lv.tot)?lv.custom_cell_counter:(Math.ceil(lv.custom_cell_counter%lv.tot));
            
                      //alert(lv.col);
            
                    //  lv.col=(lv.col==0)?lv.tot:lv.col;
            
                      lv.col=(lv.col*lv.skip)+lv.incr;
                      
                      return {'row':lv.row,'col':lv.col};
                      
	   } // close
           
           
           // get row col
           
           D_Series.prototype.get_defaut_cell_id=function(param){
                      
                      var temp = this.get_row_col(param);
                      
                      return 'row_id_'+temp.row+'_'+temp.col;
                      
                      
           } // end
           
           
           
           
           // count cell
           
           D_Series.prototype.custom_cell_count=function(){
                      this.custom_cell_counter++;           
           } // end
           
           // Reset
           
           D_Series.prototype.custom_cell_reset=function(){
                      this.custom_cell_counter=0;           
           } // end
	   
           // row in
           
           D_Series.prototype.row_in=function(element){
                      
                      if (this.has_focus_row==1){
                                 this.last_selected_class_name = element.className;
                                 element.className="row_focus";
                      } // end
           } // end
           
           // row out
           
           D_Series.prototype.row_out=function(element){
                      if (this.has_focus_row==1){
                                 element.className=this.last_selected_class_name;
                      } // end
           } // end
           
           
           // inline
           D_Series.prototype.set_inline=function(param){
                   
                      var lv = new Object({});
                      
                      lv.param = JSON.parse(param);
                      
                      lv.param_str = encodeURIComponent(JSON.stringify(lv.param.data));
                      
                      lv.txtbox    = '<input type=text'+
                                            ' value="'+lv.param.data.info+'" onblur="JavaScript:d_series.inline_action(this,\''+lv.param_str+'\')">';
                      
           
                      lv.hidden   = '<input type=hidden id="'+lv.param.data.key+'"  '+
                                            ' value="'+lv.param.data.info+'">';
           
           
                      return lv.txtbox+lv.hidden;
           } // end
           
           
           // inline
           D_Series.prototype.inline_action=function(element,param){
                   
                      //alert(element.value);
                      
                      var lv = new Object({});
                      
                      lv.param = JSON.parse(decodeURIComponent(param));
                      
                      lv.temp_value = ELEMENT(lv.param.key).value;
                      
                      if (lv.temp_value!=element.value){
                                 
                                     bootbox.confirm({
                                            
                                            message: "Are you sure to update "+lv.param.label+"?",
                                            
                                            buttons: {
                                                confirm: {
                                                    label: 'Yes',
                                                    className: 'btn-success'
                                                },
                                                cancel: {
                                                    label: 'No',
                                                    className: 'btn-danger'
                                                }
                                            },
                                            callback: function (result) {
                                                
                                                       if(result==true){
                                                                  
                                                                  G.showLoader('Updating');
                      
                                                                  d_series.ajax.set_request('router.php','&series=a_series&action='+lv.param.action+'&token='+lv.param.token+'&param='+param+
                                                                                                    '&sv='+encodeURIComponent(element.value));                                                                  
                                                                  d_series.ajax.send_get(d_series.inline_action_response);                                            
                                                                  
                                                       }
                                            }
                                        });
                      } // change case
                   
                      
           } // end
           
           // inline
           D_Series.prototype.inline_action_response=function(response){
                      
                     G.hideLoader();
                      
           } // end
           
            
           // inline
           D_Series.prototype.set_inline_update=function(param){
                   
                      var lv = new Object({});
                      
                      lv.param = JSON.parse(param);
                      
                      lv.type_action = new Object({});
                      
                      var temp  = lv.param.data;
                      
                      lv.param_str = encodeURIComponent(JSON.stringify(temp));
                      
                      lv.field_id  = 'txt_'+lv.param.data.key+'';
                      
                      lv.update    = '<a class=" clr_box_blue txt_size_1_2em pad_3 hint--right inline_block" '+
                                         'data-hint="Update" '+
                                         ' href="JavaScript:d_series.inline_update_action(\''+lv.field_id+'\',\''+lv.param_str+'\')">'+
                                         '<i class="fa fa-pencil-square-o" aria-hidden="true"></i>'+
                                     '</a>';
                      
                      lv.type      = (lv.param.data.type!=undefined)?lv.param.data.type:'text';
                      
                      lv.type_action['text'] = function(param){
                                 
                                                       return '<input type=text  id="'+lv.field_id+'"'+
                                                               ' value="'+lv.param.data.info+'" class="w_80_pr"></input>'+lv.update;
                                            };
                                            
                                            
                      lv.type_action['textarea'] = function(param){
                                 
                                                       return '<textarea class="txt_size_11 w_250" type=text  id="'+lv.field_id+'" >'+
                                                               lv.param.data.info+'</textarea>'+lv.update;
                                            };
               
                      lv.input    = lv.type_action[lv.type](lv);
                     
                      lv.hidden   = '<input type=hidden id="'+lv.param.data.key+'"  '+
                                            ' value="'+lv.param.data.info+'">';
           
                      return lv.input+lv.hidden;
                      
           } // end
           
           
           // inline
           D_Series.prototype.inline_update_action=function(element,param){
                   
                      var lv = new Object({});
                      
                      lv.param = JSON.parse(decodeURIComponent(param));
                      
                      lv.param.info="";
                      
                      lv.param_str = encodeURIComponent(JSON.stringify(lv.param));
                      
                      lv.temp_value = ELEMENT(lv.param.key).value;
                      
                      lv.temp_element = ELEMENT(element);
                      
                      if (lv.temp_value!=lv.temp_element.value){                                 
                                                                  
                                 G.showLoader('Updating');

                                 d_series.ajax.set_request('router.php','&series='+lv.param.series+'&action='+lv.param.action+'&token='+lv.param.token+'&param='+lv.param_str+
                                                                   '&sv='+encodeURIComponent(lv.temp_element.value));                                                                  
                                 d_series.ajax.send_get(d_series.inline_action_response);
                                 
                                 ELEMENT(lv.param.key).value = lv.temp_element.value;
                                          
                      }else{
                                  bootbox.alert({
                                            
                                            message: "Kindly change the <b>"+lv.param.label+"</b> content and update.",
                                  });
                      }
                      
           } // end
                    
           // active deactive
           
           // inline
           D_Series.prototype.inline_on_off=function(param){
                   
                      var lv = new Object({});
                      
                      lv.param = JSON.parse(param);
                      
                      lv.param_str = encodeURIComponent(JSON.stringify(lv.param.data));
                      
                      lv.field_id  = lv.param.data.key+'';
                      
                      lv.flag=new Array('clr_box_orange','clr_box_green');
                    
                      lv.content='<a  id="'+lv.field_id+'" class="'+ lv.flag[Number(lv.param.data.cv)]+' pad_7 round" href="JavaScript:d_series.inline_on_off_action(\''+lv.param_str+'\');"></a>';
           
                      return lv.content;
           } // end
           
           
           // inline
           D_Series.prototype.inline_on_off_action=function(param){
                   
                      //alert(element.value);
                      
                      var lv = new Object({});
                      
                      lv.param = JSON.parse(decodeURIComponent(param));
                      
                      lv.flag= ['Activate','Deactivate'];
                      
                      //lv.temp_value = ELEMENT(lv.param.key).value;
                      
                
                                 
                                     bootbox.confirm({
                                            
                                            message: "Are you sure to "+lv.flag[lv.param.cv]+" "+lv.param.label+"?",
                                            
                                            buttons: {
                                                confirm: {
                                                    label: 'Yes',
                                                    className: 'btn-success'
                                                },
                                                cancel: {
                                                    label: 'No',
                                                    className: 'btn-danger'
                                                }
                                            },
                                            callback: function (result) {
                                                
                                                       if(result==true){
                                                                  
                                                                  G.showLoader('Updating');
                      
                                                                  d_series.ajax.set_request('router.php','&series='+lv.param.series+'&action='+lv.param.action+'&token='+lv.param.token+
                                                                                            '&param='+param);                                                                  
                                                                  d_series.ajax.send_get(d_series.inline_on_off_action_response);                                            
                                                                  
                                                       }
                                            }
                                        });
                     
                   
                      
           } // end
           
           D_Series.prototype.inline_on_off_action_response=function(response){
                      
                      G.hideLoader();
                       
                      var lv = new Object({});
                       
                      lv.param=JSON.parse(response);
                       
                      lv.flag= ['clr_box_orange','clr_box_green'];
                        
                      document.getElementById(lv.param.key).className=lv.flag[lv.param.fv]+" pad_7 round";
                       
                      lv.temp = lv.param.cv;
                      
                      lv.param.cv = lv.param.fv;
                      
                      lv.param.fv =  lv.temp;
                      
                      lv.param_str=JSON.stringify(lv.param);
                      
                      document.getElementById(lv.param.key).href="JavaScript:d_series.inline_on_off_action('"+lv.param_str+"');"
                       
                      
           } // end
           
           D_Series.prototype.default_action_response=function(response){
                      
                      G.hideLoader();
                      
                      if(Number(response)==1){
                                 
                                 page_reload();                      
                      }else{
                                 
                                 G.bs_alert_error('Something Went Wrong. Kindly check it');
                      }
                      
                      
                      
           } // end
           
           // check delete
           D_Series.prototype.check_delete=function(element,param){
                   
                      var no_row = GET_E_VALUE('COUNTER');
					  
					  var cntr_exlude_delete = Number(GET_E_VALUE('D_COUNTER'));
					
                      var is_check =0;	
                      
                      var del_name='';
					  
					  this.delete_queue = [];
					  
					  var delete_queue  = this.delete_queue;
                      
                      for(var no_row_i = 1; no_row_i<=no_row; no_row_i++ ){
						  
								if(this.g.isElementThere("c"+no_row_i)){
                                      
									 if((document.getElementById("c"+no_row_i).checked) == true){
											
											is_check+=1;
											
											 this.delete_queue.push({'ele':document.getElementById("RX_"+no_row_i),
																	 'cntr':no_row_i,
																	 'nxt':(no_row_i+1)
																	 });
											
											del_name+="<br>"+GET_E_VALUE('d'+no_row_i);
									 }
								}
                      }
                      
                      if(is_check){
                                  
                                  bootbox.confirm({
                                                       
                                            message: "<b>Are you sure want to delete the following item"+((Number(is_check)>1)?'s':'')+"?</b>"+del_name,
                                            
                                            buttons: {
                                                confirm: {
                                                    label: 'Yes',
                                                    className: 'btn-success'
                                                },
                                                cancel: {
                                                    label: 'No',
                                                    className: 'btn-danger'
                                                }
                                            },
                                            callback: function (result) {
                                                
														if(result==true){ 
                                                        
															G.$('DEL').value = 1;
																
															G.showLoader('Sending your request..');
					
														
															fetch('', {
																method : "POST",
																body: new FormData(document.getElementById("PUB_A")),
																
															}).then(
																response => response.json() // 
															).then(
																(html)=>{
																	
																	var clv = {};
																	
																	clv.dq_length = delete_queue.length;
																	
																	if(Number(G.$('pager_records').dataset.pager==clv.dq_length)){
																		
																		console.log('Total=del');
																		
																		//remove elements
																		for(const d_ele of delete_queue){
																			d_ele.ele.remove();	
																			G.$('D_COUNTER').value=(Number(G.$('D_COUNTER').value)-1);
																			G.$('pager_records').dataset.pager=(Number(G.$('pager_records').dataset.pager)-1);
																		} 
																		
																		if(d_series.getDeskConfig('show-all-rows')!=1){
																			set_page_status(0,
																			G.$('page').value,
																			G.$('pager_action').dataset.pager);
																		}
																		
																		if(Number(d_series.getDeskConfig('has-summary'))==1){
															wl.summary.getResponse({'url':'?'+G.$('PAGE_ID').value+'='+G.$('app_key').value+'&sum_axn=1'}); 
																		} // end
																	
																	}else if(cntr_exlude_delete==clv.dq_length){
																		
																		console.log('Total=page');
																		d_series.setDeskStartAction();
																		filter_data();
																		
																	}else{
																		console.log('Other');
																	
																		for(var dq_idx=0;dq_idx<clv.dq_length;dq_idx++){
																			
																			clv.row = delete_queue[dq_idx];
																			clv.dq_idx_incr=(dq_idx+1);
																			
																			// last element case
																			if(d_series.getDeskConfig('hide-sno')!=1){						
																				if(clv.dq_idx_incr==clv.dq_length){
																					
																					for(var e_idx=clv.row.nxt;e_idx<=no_row;e_idx++){
																						clv.sno = G.$('SNO_'+e_idx);
																						clv.sno.innerHTML = Number(clv.sno.innerHTML)-clv.dq_idx_incr;
																					}
																					
																				}else{
																					
																					clv.nxt_row = delete_queue[clv.dq_idx_incr];
																					for(var e_idx=clv.row.nxt;e_idx<=clv.nxt_row.cntr;e_idx++){
																						clv.sno = G.$('SNO_'+e_idx);
																						clv.sno.innerHTML = Number(clv.sno.innerHTML)-(clv.dq_idx_incr);
																					}
																				} 	
																			} // hide sno
																			
																			console.log('e:'+clv.row.ele.id+'--'+clv.row.cntr);
																			
																			clv.row.ele.remove();
																			G.$('D_COUNTER').value=(Number(G.$('D_COUNTER').value)-1);
																			G.$('pager_records').dataset.pager=(Number(G.$('pager_records').dataset.pager)-1);
																			
																			if(d_series.getDeskConfig('has-summary')==1){
															wl.summary.getResponse({'url':'?'+G.$('PAGE_ID').value+'='+G.$('app_key').value+'&sum_axn=1'}); 
																			} // end
																	
																		} // end of delete queue
																		
																	} // end of row based logics
																	
																	G.hideLoader();
																	
																} // end of html response
															); // end of 																
														} // for delete conformation
                                            } // callback 
                                        }); // bootbox confirm
                      }else{                                       
                              //bootbox.alert({'message':'<b>Please check atleast one row.</b>'});
                              
                              G.bs_alert_error('<b>Please check atleast one row.</b>','','Warning');
                      }
                      
                      return true;
           } // end
           
		   // desk checkbox selected 
			D_Series.prototype.getDeskCheckboxSelectedIds = function(){
				
				var lv = new Object({});				
				lv.num_of_rows = document.getElementById('COUNTER').value;    
				lv.element_ids = [];
				
				for(var chk_i=1;chk_i<=lv.num_of_rows;chk_i++ ){	

					lv.current_element = document.getElementById(this.desk_chkbox_px+chk_i);					
					if(lv.current_element.checked==true){														
						lv.element_ids.push(lv.current_element.value);								
					} //end if			
					
				} //end for	
						
				return lv.element_ids;
				
			} // end	
			
			// clear desk filters
		D_Series.prototype.clearFilter=function(){
			
			var lv={'fields':{'text_ele':''}};	
			
			lv.fields.search = ['s_text','s_text_hidden','s_text_id'];
			
			lv.fields.custom_filters =  document.querySelectorAll("[data-filter-type='CF']");
		
			
			// search 
			for(const ele of lv.fields.search){
				//E_V_PASS(ele,'');
				
				if(typeof(ele)=='object'){				

					for(const obj_key of Object.keys(ele)){
						E_V_PASS(obj_key,ele[obj_key]);
					}
					
				}else{
					E_V_PASS(ele,'');
				}
				console.log('Clear Filter:'+ele[0]+'---'+typeof(ele));
			}
			
			// custom filter
			for(const ele of lv.fields.custom_filters){				
					ele.value='';
			}
			
			
			// date filter
			G.$('is_check_date').checked=false;
			
			
		} // end
			
			
	   
	   // default call
	   
	   var d_series = new D_Series();
	   
	 