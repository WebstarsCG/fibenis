                
                
                var P_V = new Array();
                
                /////////////////////////// f_series //////////////////////////////////////////////////////////////////////
	   
                function  F_Series(){		      
		      
		                this.__element_out_array = new Object({});
                                
                                this.temp                = new Object({});
                                
                                this.element             = new Object({});
                                
                                this.is_must             = new Object({'data':{},'is_json':0});
                                
                                this._default             = new Object({'xid':'X',
                                                                        
                                                                        'message_area_name_px':'message_',
                                                                        
                                                                        'color':{'error':'#af0a0a',
                                                                                 'focus':'#1fad13',
                                                                                 'clear':''
                                                                        
                                                                        },
                                                                        'form_type':'FS'// f_series
                                                                        
                                                                       
                                                                       });
                                
                                this.setInputMessage      = new Object({});      
                                
                                this.ajax                 = new ajax();
                                
                                this.g                    = new General();
                                
                                this.ft                   = new Object({'current_row':'',
                                                                        'current_col':'',
                                                                        'current_id':'',
                                                                        'token'     :'ft', 
                                                                        'glue'       :'_'
                                                                       });
                                
                                this.temp.hour_options   = new Array(
                                                                     {'id':'01','name':'01'},
                                                                     {'id':'02','name':'02'},
                                                                     {'id':'03','name':'03'},
                                                                     {'id':'04','name':'04'},
                                                                     {'id':'05','name':'05'},
                                                                     {'id':'06','name':'06'},
                                                                     {'id':'07','name':'07'},
                                                                     {'id':'08','name':'08'},
                                                                     {'id':'09','name':'09'},
                                                                     {'id':'10','name':'10'},
                                                                     {'id':'11','name':'11'},
                                                                     {'id':'12','name':'12'}
                                                                );
                                
                                this.temp.am_pm   = new Array(
                                                                     {'id':'AM','name':'AM'},
                                                                     {'id':'PM','name':'PM'}
                                                                     
                                                                );
                                
                                this.getElementByColId     = function(col_id){
                                                return document.getElementById(this._default.xid+col_id);
                                }
                                
                                this.getElementByToken    = function(token){
                                                
                                                return this.getElementByColId(this.element[token]);
                                }
                                
                                
                                this.getElementMessageArea = function(element){
                                                                                                
                                                return document.getElementById(this._default.message_area_name_px+element.id);
                                } // end
                                
                                
                                this.setMessage=function(element,message){                                               
                                                
                                                this.getElementMessageArea(element).innerHTML=message;
                                }
                                
                                this.setInputMessage.FS = function(param){                                               
                                                                                                
                                                param.element.style.borderColor=f_series._default.color[param.color];
                                                
                                                f_series.getElementMessageArea(param.element).innerHTML=param.message;
                                }
                                
                                this.setInputMessage.BS = function(param){
                                                
                                                var ele_area    = ELEMENT(param.element.id+'_area');
		
                                                var ele_warn    = ELEMENT(param.element.id+'_message');
                                                
                                                var ele_icon    = ELEMENT(param.element.id+'_icon');
                                                
                                                if(param.color!='clear'){
                                             
                                                                // warn style
                                                                ele_area.className='form-group has-error has-feedback';
                                                                
                                                                // warn message			
                                                                ele_warn.innerHTML = (param.element.dataset.alert!=undefined)?get_style({'style':'txt_size_11 clr_red','content':param.element.dataset.alert}):'';
                                                                
                                                                // icon			
                                                                ele_icon.className = 'glyphicon glyphicon glyphicon-alert clr_red form-control-feedback';
                                                
                                                }else{	   
                                                                // clear warn style
                                                                ele_area.className='form-group has-feedback ';
                                                                
                                                                ele_warn.innerHTML='';
                                                      
                                                                // style			   
                                                                ele_icon.className = 'glyphicon form-control-feedback';
                                                } // end                
                                               
                                } // end
                                                      
                } // end
                
                // fiben table set ref
                
                F_Series.prototype.setFtRef = function(element){
                                             
                                var lv = new Object({});
                             
                                lv.patterns = element.id.match(/(\d+)(\_)(ft)(\_)(\d+)(\_)(\d+)/i);
                             
                                if(lv.patterns.length>0){
                                   
                                    lv.segments = element.id.match(/(\d+)/ig);
                                    
                                    this.ft.current_row=lv.segments[0];
                                    this.ft.current_col=lv.segments[1];
                                    this.ft.current_id =lv.segments[2];
                                    
                                }
                } // end
                
                
                F_Series.prototype.getFtDNA = function(param){
                                             
                                                var lv = new Object({});
                                                
                                                lv.row = this.g.isUNE(param.row,this.ft.current_row);
                                                lv.col = this.g.isUNE(param.col,this.ft.current_col);
                                                
                                                return lv.element_ingredient =  lv.row+this.ft.glue+        // row_
                                                                                this.ft.token+this.ft.glue+ // ft_
                                                                                lv.col+this.ft.glue+        // col_
                                                                                this.ft.current_id;                                             
                }
                
                
                F_Series.prototype.getFtCellRight = function(param){
                                             
                                                var lv = new Object({});
                                                
                                                lv.pointer = this.g.isUndefined(param,1);
                                                
                                                lv.element_ingredient = this.getFtDNA({'row':'',
                                                                                        'col':(Number(this.ft.current_col)+Number(lv.pointer))});
                                                                                                               
                                                lv.element=document.getElementById(lv.element_ingredient); // id
                                                
                                                return this.g.isUndefined(lv.element,false);                                                
                }
                
                F_Series.prototype.getFtCellLeft = function(param){
                                             
                                                var lv = new Object({});
                                                
                                                lv.pointer = this.g.isUndefined(param,1);
                                                
                                                lv.element_ingredient = this.getFtDNA({'row':'',
                                                                                        'col':(Number(this.ft.current_col)-Number(lv.pointer))});
                                                                                                               
                                                lv.element=document.getElementById(lv.element_ingredient); // id
                                                
                                                return this.g.isUndefined(lv.element,false);                                                
                }
                
                F_Series.prototype.getFtCellUp = function(param){
                                             
                                                var lv = new Object({});
                                                
                                                lv.pointer = this.g.isUndefined(param,1);
                                                
                                                lv.element_ingredient = this.getFtDNA({'row':(Number(this.ft.current_row)-Number(lv.pointer)),
                                                                                        'col':''});
                                                                                                               
                                                lv.element=document.getElementById(lv.element_ingredient); // id
                                                
                                                return this.g.isUndefined(lv.element,false);                                                
                }
                
                F_Series.prototype.getFtCellDown = function(param){
                                             
                                                var lv = new Object({});
                                                
                                                lv.pointer = this.g.isUndefined(param,1);
                                                
                                                lv.element_ingredient = this.getFtDNA({'row':(Number(this.ft.current_row)+Number(lv.pointer)),
                                                                                        'col':''});
                                                                                                               
                                                lv.element=document.getElementById(lv.element_ingredient); // id
                                                
                                                return this.g.isUndefined(lv.element,false);                                                
                }
                
                F_Series.prototype.getFtCell = function(row,col){
                                             
                                                var lv = new Object({});
                                                
                                                lv.element_ingredient = this.getFtDNA({'row':row,
                                                                                        'col':col});
                                                                                                               
                                                lv.element=document.getElementById(lv.element_ingredient); // id
                                                
                                                return this.g.isUndefined(lv.element,false);                                                
                }
                
                F_Series.prototype.getFtCurRowCell = function(col){                                
                                                return this.getFtCell(this.ft.current_row,col);                                
                }
                
                F_Series.prototype.getFtCurColCell = function(row){                                
                                                return this.getFtCell(row,this.ft_current_col);                                
                }
                
                F_Series.prototype.checkIsMust=function(element){
                                
                                var lv = new Object({});
                                
                                lv.allow_type={'d':{'label':'digits'},
                                               'w':{'label':'chars'},
                                               'x':{'label':'chars'},
                                               'v':{'label':''},
                                               'c':{'label':''},
                                               'o':{'label':''},
                                               };
                                               
                                lv.ft           = G.isUndefined(element.dataset.formType,'FS');
                                                                            
                                lv.current_type = (element.dataset.type!=undefined)?element.dataset.type:'o';
                                             
                                                               
                                lv.allow_type_text = lv.allow_type[lv.current_type].label;
                                
                               
                                if(element.dataset.pattern!=undefined) {
                                                
                                                lv.pattern = new RegExp(element.dataset.pattern);                                                               
                                                lv.result=element.value.match(lv.pattern);
                                               
                                                if(lv.result==null){
                                                                
                                                                
                                                                if((element.dataset.leftLength!=undefined) &&
                                                                   (element.dataset.rightLength!=undefined)){
                                                                                
                                                                                lv.left_number  = (element.dataset.leftLength!=undefined)?get_repeat('9',Number(element.dataset.leftLength)):'';
                                                                                lv.right_number = (element.dataset.rightLength!=undefined)?'.'+get_repeat('9',Number(element.dataset.rightLength))+ ' with 2 decimal':'';
                                                                                lv.warn_message=G.isUndefined(element.dataset.warnMessage,"Kindly give the value with in "+lv.left_number+lv.right_number);                                                
                                                                }
                                                                
                                                           
                                                                this.setInputMessage[lv.ft]({"element":element,
                                                                                                "message":get_style({"style":"block txt_size_13 clr_red","content":lv.warn_message}),
                                                                                                "color"  :"error"
                                                                });
                                                                
                                                                return 0;
                                                           
                                                }
                                } // pattern
                                
                                
                                if( (element.dataset.minValue!=undefined) &&
                                    (element.dataset.maxValue!=undefined)){
                                                
                                               
                                                
                                                lv.temp_value = Number(element.value);
                                                
                                                if ( (lv.temp_value<Number(element.dataset.minValue)) ||
                                                     (lv.temp_value>Number(element.dataset.maxValue)) 
                                                    ) {
                                                       
                                                                lv.temp_message=  " between "+element.dataset.minValue+" - "+element.dataset.maxValue;
                                                
                                                                this.setInputMessage[lv.ft]({"element":element,
                                                                                      "message":get_style({"style":"txt_size_13 clr_red block ","content":"Kindly give the value"+lv.temp_message }),
                                                                                      "color"  :"error"
                                                                });
                                                                
                                                                return 0;
                                                }
                                                
                                }else if (element.dataset.lengthMatch!=undefined) {
                                                
                                                if(element.value.length!=element.maxLength){
                                                                
                                                                
                                                                lv.warn_message=G.isUndefined(element.dataset.warnMessage,"Kindly fill the information exactly "+element.maxLength+" "+lv.allow_type_text);
                                                     
                                                                this.setInputMessage[lv.ft]({"element":element,
                                                                                                "message":get_style({"style":"block txt_size_13 clr_red","content":lv.warn_message}),
                                                                                                "color"  :"error"
                                                                          });
                                                                       
                                                                return 0;
                                                }
                                        
                                }else if(element.dataset.minLength!=undefined){
                                         
                                                var min_len=Number(element.dataset.minLength)+0;
                                                     
                                                if( (element.value.length<min_len) ||
                                                     (element.value.length>element.maxLength)
                                                ){                                                                
                                                                this.setInputMessage[lv.ft]({"element":element,
                                                                                     "message":get_style({"style":"block  txt_size_13 clr_red","content":"Kindly fill the information with "+min_len+" to "+element.maxLength+" "+lv.allow_type_text}),
                                                                                     "color"  :"error"
                                                                });
                                                               
                                                                return 0;
                                                }
                                }else if( (element.dataset.minLength==undefined) &&
                                          (element.dataset.lengthMatch==undefined) &&
                                          (Number(element.maxLength)>0)
                                          ){
                                              
                                                if(element.value.length==0){
                                                
                                                
                                                                lv.temp_message= (lv.current_type=='0')?'': " within "+element.maxLength+" "+lv.allow_type_text;
                                                
                                                                this.setInputMessage[lv.ft]({"element":element,
                                                                                      "message":get_style({"style":"txt_size_13 clr_red block ","content":"Kindly fill the information"+lv.temp_message }),
                                                                                      "color"  :"error"
                                                                });
                                                                
                                                                return 0;
                                                }
                                }
                                
                                this.setInputMessage[lv.ft]({          "element":element,
                                                                "message":'',
                                                                "color"  :"clear"
                                                });
                                
                                return 1;
                } // end
                
                
                function checkIsMust(element){ return f_series.checkIsMust(element);}
                
                
                F_Series.prototype.checkIsSelect=function(element){
                                
                                var lv = new Object({});                                
                                
                                lv.ft           = G.isUndefined(element.form_type,'FS');
                                                                
                                if( (((element.tagName=="SELECT")) &&
                                                (element.value.length < 1 ||
                                                 Number(element.value)==0 ||
                                                 element.value=='NANA'))
                                      ){
                                
                                                 this.setInputMessage[lv.ft]({"element":element,
                                                                      "message":get_style({"style":"txt_size_13 clr_red block ","content":"Kindly select any option."}),
                                                                      "color"  :"error"
                                                });
                                                
                                                return 0;
                                }else{
                                        
                                                 this.setInputMessage[lv.ft]({          "element":element,
                                                                                                "message":'',
                                                                                                "color"  :"clear"
                                                                                });
                                
                                                return 1;        
                                }
                                
                               
                } // end
                
                function checkIsSelect(element){ return f_series.checkIsSelect(element);}
                
                function elementFocus(element){
                              
                                element.style.borderColor=f_series._default.color.focus;                   
                                document.getElementById('message_'+element.id).innerHTML='';
                              
                } // end
                
                function elementFocusOut(element){
                              
                                element.style.borderColor='';                   
                                document.getElementById('message_'+element.id).innerHTML='';
                              
                } // end
                
                
                
                // new master 
                
                function add_new_master(parent_element,child_element){
                                
                                // get parent id
                                f_series.temp.parent_element_xid = parent_element.id;
                                
                                 f_series.temp.status_action = [];
                               
                                f_series.temp.status_action[0]=function(data_in){
                                                
                                                data_in = data_in.replace('  ',' ');
                                                
                                                return data_in.replace('hide','')+" hide";
                                }
                               
                                f_series.temp.status_action[1]=function(data_in){
                                                
                                                return data_in.replace("hide",'');
                                }
                                
                                                                
                                if(parent_element.value==-1){                            
                                     
                                       f_series.temp.set_is_active  =  true;
                                       f_series.temp.set_action_flag = 1;
                                
                                       //document.getElementById(f_series.temp.child_element_xid+'_panel').className="row";
                                       //f_series.is_must['data'][f_series.temp.child_element_xid].is_active=true;                                       
                                
                                }else{                                       
                                       
                                       f_series.temp.set_is_active  =  false;
                                       f_series.temp.set_action_flag = 0;
                                       //document.getElementById(f_series.temp.child_element_xid+'_panel').className="row hide";
                                       //f_series.is_must['data'][f_series.temp.child_element_xid].is_active=false;
                                       
                                } //if
                                
                                // check type of
                                
                                if(typeof(child_element)=="number"){
                                                
                                                // build new child element_id
                                                f_series.temp.child_element_xid     = f_series._default.xid+child_element;                                                
                                                f_series.temp.child_panel           = document.getElementById(f_series.temp.child_element_xid+'_panel');
                                                
                                                f_series.temp.child_panel.className = f_series.temp.status_action[f_series.temp.set_action_flag](f_series.temp.child_panel.className);
                                                f_series.is_must['data'][f_series.temp.child_element_xid].is_active         = f_series.temp.set_is_active;
                                       
                                }else if(typeof(child_element)=="object"){
                                
                                                for(var idx in child_element){                                                                
                                                                
                                                                // build new child element_id
                                                                f_series.temp.child_element_xid  = f_series._default.xid+child_element[idx];
                                                                f_series.temp.child_panel           = document.getElementById(f_series.temp.child_element_xid+'_panel');
                                                                
                                                                f_series.temp.child_panel.className = f_series.temp.status_action[f_series.temp.set_action_flag](f_series.temp.child_panel.className);
                                                                f_series.is_must['data'][f_series.temp.child_element_xid].is_active         = f_series.temp.set_is_active;
                                                                
                                                } //end                                
                                } //end
                } // end
                
                
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                //	Name		: element_show_hide
                //	Short Brief	: control to show or hide the give element index ids
                //	i/p structure   : (child_element,show_flag)
                //	i/p sample      : ([21,20],0|1),([21,20],{'status':1,'is_ro':1}) // is_ro -> read only 
                //	i/p		: child_element can be array or single, show_param can be 0 or 1
                //      o/p             :
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                                
                function element_show_hide(child_element,show){
                                                                        
                                // ro                                
                                f_series.temp.is_element = ELEMENT(f_series.temp.child_element_xid+'_RO');
                                
                                f_series.temp.status_action = [];
                               
                                f_series.temp.status_action[0]=function(data_in){
                                                
                                                data_in = data_in.replace('  ',' ');
                                                
                                                return data_in.replace('hide','')+" hide";
                                }
                               
                                f_series.temp.status_action[1]=function(data_in){
                                                
                                                return data_in.replace("hide",'');
                                }
                                                                                                  
                                if((show==1) ||
                                   ((String(show).toLocaleLowerCase()=='true')) ||
                                   ((typeof(show)=="object") && (String(show.status).toLocaleLowerCase()=='true'))
                                   ){                            
                                     
                                       f_series.temp.set_action_flag= 1;
                                       f_series.temp.set_is_active  =  true;
                                       f_series.temp.set_is_ro      =  (show.is_ro>=0)?show.is_ro:1;
                                      
                                }else{                                       
                                       
                                       f_series.temp.set_action_flag= 0;
                                       f_series.temp.set_is_active  =  false;
                                       f_series.temp.set_is_ro      =  1;
                                      
                                } //if
                                
                                
                                if(typeof(child_element)=="number"){
                                                
                                                // build new child element_id
                                                f_series.temp.child_element_xid  = f_series._default.xid+child_element;
                                       
                                                f_series.temp.panel_element      = document.getElementById(f_series.temp.child_element_xid+'_panel');
                                       
                                                f_series.temp.panel_element.className = f_series.temp.status_action[f_series.temp.set_action_flag](f_series.temp.panel_element.className);
                                                
                                                f_series.is_must['data'][f_series.temp.child_element_xid].is_active         = f_series.temp.set_is_active;
                                                
                                                //ro
                                                if (f_series.temp.is_element!=false) {
                                                    f_series.temp.is_element.value=f_series.temp.set_is_ro;            
                                                }
                                                
                                       
                                }else if(typeof(child_element)=="object"){
                                
                                                for(var idx in child_element){                                                                
                                                                
                                                                // build new child element_id
                                                                f_series.temp.child_element_xid  = f_series._default.xid+child_element[idx];                                                                
                                                               
                                                                f_series.temp.panel_element      = document.getElementById(f_series.temp.child_element_xid+'_panel');
                                       
                                                                f_series.temp.panel_element.className = f_series.temp.status_action[f_series.temp.set_action_flag](f_series.temp.panel_element.className);
                                                
                                                                f_series.is_must['data'][f_series.temp.child_element_xid].is_active         = f_series.temp.set_is_active;
                                                                                                                               
                                                                //ro
                                                                f_series.temp.is_element = ELEMENT(f_series.temp.child_element_xid+'_RO');
                                                                
                                                                if (f_series.temp.is_element!=false) {
                                                                    f_series.temp.is_element.value=f_series.temp.set_is_ro;            
                                                                } 
                                                } //end                                
                                } //end
                                
                } // end
                
                
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                //	Name		: element_show_hide_by_token
                //	Short Brief	: it's a wrapper function for element_show_hide. Instead element key if, token used.
                //	i/p structure   : (child_elements_token/child_element_token,show_flag)
                //	i/p sample      : ('<token>',0|1)(['<token>','<token>'],0|1),(['<token>','<token>'],{'status':1,'is_ro':1}) // is_ro -> read only 
                //	i/p		: child_element_token can be array or single, show_param can be 0 or 1
                //      o/p             : no return, will show or hide the element by token
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                function element_show_hide_by_token(child_element,show){
                               
                                var temp = [];
                               
                                if((typeof(child_element)=='string') && (f_series.element[child_element]!=undefined)){                                                        
                                
                                                element_show_hide(f_series.element[child_element],show);                        
                                
                                }else if(typeof(child_element)=='object'){
                                             
                                                for(var idx in child_element){
                                                    
                                                    if(f_series.element[child_element[idx]]!=undefined){
                                                                temp.push(f_series.element[child_element[idx]]);
                                                    }
                                                
                                                } // element end
                                                
                                                if (temp.length>0) {
                                                    element_show_hide(temp,show);
                                                }
                                                
                                } // end of typecheck
                } // end
                
                
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                //	Name		: element_show_by_token
                //	Short Brief	: element show for child element for given check element & value. Wrapper of
                //                        element_show_hide_by_token
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                function element_show_by_token(child_element,check_element,check_value) {
                
                                //show
                                if(check_element.value==check_value){
                                           element_show_hide_by_token(child_element,1);     
                                }else{ // hide
                                           element_show_hide_by_token(child_element,0);
                                }
                                
                } // end
                
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                //	Name		: element_show_by_token
                //	Short Brief	: element hide for child element for given check element & value. Wrapper of
                //                        element_show_hide_by_token
                ////////////////////////////////////////////////////////////////////////////////////////////////////////// 
                function element_hide_by_token(child_element,check_element,check_value) {
                
                                if(check_element.value==check_value){ // hide
                                           element_show_hide_by_token(child_element,0);     
                                }else{ // show
                                           element_show_hide_by_token(child_element,1);
                                }
                                
                } // end
                
                
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                //	Name		: set_nd_content
                //	Short Brief	: set HTML content to narrow down ground
                //	i/p		: {ele_idx:'<element_idx>',content:'<content>'}
                //	o/p		: set/clear content based on display	   
                //////////////////////////////////////////////////////////////////////////////////////////////////////////                              
                function data_validate(table,ele_obj){
                                
                                var AJXR = new ajaxrequest();
                                
                                AJXR.get_front_request('inc/lib/check_uniqe_data.php');
                                
                                var check_value = ele_obj.value;
                                
                                P_V['check_id']	=	ele_obj.id;
                                
                                var req =  '&table_name='+table+'&check_value='+check_value;
                                
                                //alert(req);
                                AJXR.set_url(req);
                                
                                AJXR.send(check_uniqe_response);
                }
                
                
                function check_uniqe_response(response){
                                
                                        if(Number(response)>0){
                                                
                                                var temp = document.getElementById(P_V['check_id']).value;
                                        
                                                document.getElementById(P_V['check_id']).value ='';
                                                
                                                document.getElementById(P_V['check_id']).focus();
                                                
                                                //_v_msg
                                                var msg_block = P_V['check_id']+'_v_msg';
                                                
                                                ELEMENT(''+msg_block+'').className	=	'block_pass:';
                                                
                                                fade_in_out('#'+msg_block+'',5000,temp+' already exists. Kindly give a new one.');
                                                
                                                
                                                
                                        }
                                        else{
                                        
                                        }
                }
				
			function check_auto_data(ele,url_data){
					
					var lv = new Object();
					lv['ele_id']     = ele.id;
					
					lv['ele_value']  =  ele.value;
					
					//alert(lv['ele_value']);
					
					var ax_new_data         = new ajax();
					
				 	var url =  '&search_key=sn&query='+lv['ele_value']+'&ele_id='+lv['ele_id']+'&check_entry=1';
						
					ax_new_data.set_request(url_data,url);
					
					G.set_global(lv['url'],url_data);
					   
					//var new_data = ax_new_data.send_get(get_data_response);*/
					
					ax_new_data.send_get(get_auto_response);
				}
				
				
				function get_auto_response(res){
					
					var lv = new Object();
					
					//alert(res);
					lv['res_data'] = JSON.parse(res);
					
					if(Number(lv['res_data'][0]['id'])!=0){
						 return false;	
					}
					else{
						
							lv['confirm'] =  confirm("Are you want to add new entry!");
							
							if(lv['confirm'] == true){
								
							//alert(G.get_global(lv['url']));
								var ax_new_data         = new ajax();
								
								var req  =  '&search_key=sn&new_entry=1&query='+lv['res_data'][0]['query_data']+'&ele_id='+lv['res_data'][0]['ele_id'];	
								
								ax_new_data.set_request(G.get_global(lv['url']),req);
								
								var new_data = ax_new_data.send_get(get_new_auto_data_response);
								
								//ax_new_data.set_request(G.get_global(lv['res_data'][0]['col_field']),req);
							
							/*	var url  =  '&field=sn&new_entry=1&query='+G.$(lv['res_data'][0]['col_field']).value+'&col_field='+lv['res_data'][0]['col_field'];				      
								ax_new_data.set_request(G.get_global(lv['res_data'][0]['col_field']),url);
								
								
								var new_data = ax_new_data.send_get(get_new_data_response);*/
							}
							
							else{
									E_V_PASS(lv['res_data'][0]['ele_id'],'');
									E_V_PASS(lv['res_data'][0]['ele_id']+'_hidden','');
									ELEMENT(lv['res_data'][0]['ele_id']).focus();
								}
							
							
                                                                return true;
                                                }
			
				}
				
				
				function get_new_auto_data_response(res){
					var lv = new Object();
					
					lv['res_data'] = JSON.parse(res);
					
					$('#'+lv['res_data'][0]['ele_id']+'_hidden').val(lv['res_data'][0]['id']);
					
					return false;
				}
				
				 function remote_auto_list(ele_obj,remote_link){
					 		 var lv = new Object();
							lv['ele_id']    =ele_obj.id;
			
							lv['ele_value'] =  ele_obj.value;
							
							$('#'+lv['ele_id']).autocomplete({
				
					source: function( request, response) {
							$.ajax({																	       
									url	: remote_link,																		
									data : {query:lv['ele_value'], search_key:'sn',exit_data:'1'},
									dataType: 'json',																       
									 success: function( data ) {
											
											 response( $.map( data, function( item ) {
												//console.log('---------'+item.id);
													return {
														id :item.id, 
														label :item.name,
													}
													
											 }));
										 },
								});
					
					},
					
					select: function( event, ui ) {
						 $('#'+lv['ele_id']+'_hidden').val( ui.item.id);
					}		
				
				  })	
							
							
				  }
        
		
				function check_exit_data(ele,url_data){
					
						var lv = new Object();
							lv['ele_id']     = ele.id;
							
							lv['ele_value']  =  ele.value;
							
							//alert(lv['ele_value']);
							
							var ax_new_data         = new ajax();
							
							var url =  '&search_key=sn&query='+lv['ele_value']+'&ele_id='+lv['ele_id']+'&check_entry=1';
								
							ax_new_data.set_request(url_data,url);
							
							G.set_global(lv['url'],url_data);
							   
							//var new_data = ax_new_data.send_get(get_data_response);*/
							
							ax_new_data.send_get(exist_data_response);
				}
				
				
				function exist_data_response(res){
						
							var lv = new Object();
				
							lv['res_data'] = JSON.parse(res);
							
							if(Number(lv['res_data'][0]['id'])!=0){
							
							}
							else{
							//alert('----------------');
							E_V_PASS(lv['res_data'][0]['ele_id'],'');
							E_V_PASS(lv['res_data'][0]['ele_id']+'_hidden','');
							ELEMENT(lv['res_data'][0]['ele_id']).focus();
							}
				
				}
				
        
              /*  function remote_quick_list(ele_obj,remote_link){
                                
                                //alert(ele_obj+'------'+remote_link);                
                                var ele_id = ele_obj.id;
                                
                                var split_data = ele_id.split("V");
                                
                                var pass_id = split_data[1];
                                
                                var ele_value = ele_obj.value;
                                                        
                                var get_remote_link = remote_link;
                                                        
                                $("#"+ele_id).autocomplete({
                                
                                source: function( request, response ) {
                                $.ajax({
                                    url: get_remote_link,
                                    dataType: "json",
                                    data: {q: request.term},
                                    success: function(data) {
                                                                                //alert(data);
                                                response($.map(data, function(item) {
                                                return {
                                                    label: item.label,
                                                    id: item.id,
                                                   // abbrev: item.abbrev
                                                    };//return
                                                                                        
                                            }));//response
                                                                        
                                        }//success
                                                                
                                    });//ajax
                                                        
                                },//source
                                                
                                minLength: 3,
                                select: function(event, ui) {
                                   $('#'+pass_id).val(ui.item.id);
                                   $('#'+ele_id).val(ui.item.label);
                                }//select
                                                
                            });//ajax*/
                //}*/
        
        
                // range composite
                
                function set_range(id,is_mand){
                        
                        var lv = new Object({});
                        
                        lv.range       = ELEMENT(id);
                        lv.start_range = ELEMENT(id+'_START');
                        lv.end_range   = ELEMENT(id+'_END');
                        
                        lv.start_range_val  = lv.start_range.value;
                        lv.end_range_val    = lv.end_range.value;
                        
                        lv.temp_message = ELEMENT('message_'+id).innerHTML;
                        lv.temp = [lv.start_range_val,lv.end_range_val];
                        
                        lv.range.value ='';
                        
                        // if
                        
                        if( (lv.start_range_val==0) || (lv.start_range_val.length==0) || (isNaN(lv.start_range_val)==true)){
                                       
                                        ELEMENT('message_'+id).innerHTML='';
                                        ELEMENT(id).value=JSON.stringify(lv.temp);
                                        return false;
                                        
                        } else{
                                        ELEMENT('message_'+id).innerHTML='';
                                        
                                        ELEMENT(id).value=JSON.stringify(lv.temp);
                        }
                        
                        return true;
                
                } // end of get_range_combined
                
                
                function init_range(id,val){
                        
                                var lv = new Object({});
                                  
                        
                                if(( val!=null) && (val.length>0)){
                                                
                                                lv.matched =  JSON.parse(val);
                                
                                                //console.log(lv.matched+'--'+lv.matched[1]);
                                                
                                                lv.start_range = ELEMENT(id+'_START');
                                                lv.end_range   = ELEMENT(id+'_END');
                                                
                                                lv.start_range.value = lv.matched[0];
                                                lv.end_range.value   = lv.matched[1];
                                                
                                                ELEMENT(id).value=val;
                                
                                } // end
                
                } // end of get_range_combined
                
                
                // range composite
                
                function set_hms(id,is_mand){                       
                        
                        var lv = new Object({});
                        
                        lv.hms         = ELEMENT(id);
                        lv.start_range = ELEMENT(id+'_1');
                        lv.end_range   = ELEMENT(id+'_2');
                        lv.am_pm       = ELEMENT(id+'_3');
                        
                        lv.start_range_val  = Number(lv.start_range.value)+0;
                        lv.end_range_val    = lv.end_range.value;
                        
                        lv.start_range_val = (lv.start_range_val==12)?0:lv.start_range_val;
                       
                         lv.start_range_val = (lv.am_pm.value=='AM')? lv.start_range_val:( lv.start_range_val+12);
                        
                        lv.hms.value = lv.start_range_val+':'+lv.end_range_val+':0';
                        
                      
                        
                        return true;
                       
                
                } // end of get_range_combined
                
               
                
		// Quick search
		
		function  list_box_search(element,list_box_element_id,list_data){
                                
			var l_v = new Array();
                        
                        list_data               = f_series.__element_out_array[list_box_element_id];
                        
                        
			
			l_v['list_box'] 	= document.getElementById(list_box_element_id);
			
			l_v['list_data_length'] = list_data.length;
						
			l_v['search_text']	= element.value.toLowerCase();
			
			remove_full(l_v['list_box']);
			
			if(element.value.length>=3){				
				
				for(var list_data_index=0; list_data_index<l_v['list_data_length'];list_data_index++) {
					
					l_v['temp']	= list_data[list_data_index].name.toLowerCase();
					
					if(l_v['temp'].indexOf(l_v['search_text'])>-1){
						
						var select_option = document.createElement("OPTION");
							
						select_option.text  = list_data[list_data_index].name;
							
						select_option.value = list_data[list_data_index].id;
					  
						l_v['list_box'].options.add(select_option); 
								
					} // if				
					
				} // end
				
			} 	// end
			else{	// load default variable
				
				Option_Builder({select_box : l_v['list_box'],
						   options    : list_data});		
			}
			
		} // end
                
                
                // Left right action
                // element id
                
                function left_right_action(id,right_selection_limit) {
                                
                                var lv = new Object({});
                                
                                // elements
                                
                                lv.element       = G.$('X'+id);
                                lv.left          = G.$('X'+id+'_LEFT');                                
                                lv.right         = G.$('X'+id+'_RIGHT');
                                lv.right_length  = G.$('X'+id+'_RIGHT').options.length;
                                lv.right_text    = G.$('X'+id+'_RIGHT_TEXT');
                                
                                // lv.right limit
                                
                                lv.right_limit       = Number(right_selection_limit);
                                lv.left_sel_length   = Number(selectbox_capture_selected_length(lv.left));
                                lv.avail_limit       = Number(lv.right_limit)-Number(lv.right_length); 
                                
                                // error
                                
                                lv.over_limit    = 0;                                
                                
                                if( (lv.right_limit>0) &&
                                    (lv.right_limit==lv.right_length)){
                                                                                                
                                                lv.over_limit   = -1;
                                                
                                }else if( (lv.right_limit>0) &&
                                          (lv.left_sel_length>lv.avail_limit)){
                                                                                                
                                                lv.over_limit   = -2;
                                                
                                } // if
                                
                                // overlimit
                                
                                if(lv.over_limit==-1){                                                
                                                
                                                alert('You can select maximum '+lv.right_limit+' options only');
                                                
                                }else if (lv.over_limit==-2){
                                                
                                                G.bs_alert_warning('You can select maximum of <b>'+lv.right_limit+'</b> options only. '+
                                                                  'Please select only <b>'+lv.avail_limit+'</b> options from left.','','Warning!');
                                
                                }else{                                
                                                parent_to_child(lv.left,lv.right);                                                
                                                selectbox_capture_value(lv.right,lv.element,',');                                                
                                                selectbox_capture_text(lv.right,lv.right_text,'#');
                                } // end
                                
                                
                } // left right action
                
                
                // Check File Element Type                
                function check_file_in(element){
                                
                                var lv = {};
                                
                                lv.file_part    = element.value.split(".");
                                
                                lv.element_del  = document.getElementById('del_data_out_'+element.id);
                                
                                lv.file_size_kb = Math.ceil(element.files[0].size/1024);
                                
                                lv.second_message_prefix = { '1':"<br>Also ",
                                                             '0':"Sorry, "
                                                           };
                                                                
                                
                                if(lv.file_part.length>0){
                                  
                                                // file format
                                                lv.file_format        = String(lv.file_part[lv.file_part.length-1]).toLowerCase();
                                                
                                                lv.file_in_formats    =  element.dataset.fileInFormats.split(',');
                                                
                                                lv.file_in_format_txt = String('|'+lv.file_in_formats.join('|')+'|').toLowerCase();
                                                
                                                lv.message_element    = f_series.getElementMessageArea(element);
                                                
                                                lv.element_del.innerHTML = '';
                                                
                                                // has file format
                                                if(lv.file_in_format_txt.indexOf('|'+lv.file_format+'|') < 0){
                                                                
                                                                element.value='';
                                                                
                                                                lv.message_element.innerHTML = '<span class="txt_size_13 clr_red ">'+
                                                                                               'Sorry, the input will allow only '+
                                                                                               '(<b>'+element.dataset.fileInFormats+'</b>)'+
                                                                                               ' formats Only.'+
                                                                                               '</span>';
                                                                                               
                                                                lv.file_format_error =1;
                                                }else{
                                                
                                                                lv.message_element.innerHTML = '';
                                                                lv.file_format_error         = 0;
                                                
                                                } // end of valid check
                                                
                                                if(isNaN(element.dataset.fileMaxSize)==false){
                                                                
                                                                if(lv.file_size_kb>element.dataset.fileMaxSize){
                                                                    
                                                                                element.value   = '';
                                                                                
                                                                                lv.message_element.innerHTML+=  '<span class="txt_size_13 clr_red ">'+
                                                                                                                   lv.second_message_prefix[lv.file_format_error]+
                                                                                                                   'the file size should below '+
                                                                                                                   '<b>'+element.dataset.fileMaxSize+' KB</b> Only.'+                                                                                               
                                                                                                                '</span>';
                                                                } // size loop
                                                } // end
                                  
                                } // end of file check
                                
                } // end check_file_in
				
		
                function toggle_action(element){
                           
                                document.getElementById(element.name+'_status').innerHTML=(element.checked==true)?element.dataset.onText:element.dataset.offText;                                                                
                                return 1;
                }
			
                        
                
                
                // default call
	   
                var f_series = new F_Series();
                