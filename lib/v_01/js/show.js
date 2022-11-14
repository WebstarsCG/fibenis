
    // show user info
    
    var show_temp = new Object({});
    
    function boolean_display(content){
        
        var style = (content==1)?'clr_box_green':'clr_box_red';
        
        put_style({ 'style':style+'  pad_7 round',
                    'content': ''
            });
        
    } // end
    
    
    // label grand father
    
    function label_grand_father(content){
        
        put_style({ 'style':'label_grand_father',
                    'content': content
            });
        
    } // end
    
    // label father
       
    function label_father(content){
        
        put_style({ 'style':'label_father',
                    'content': content
            });
        
    } // end
    
    
    // NA
    
    function na(content){
        
        if(Number(content)==0){
            put_style({ 'style':'label_grand_child',
                        'content': 'NA'
            });
        }else{
            trim_and_tip(content,22);
        }
        
    } // end
    
    // show as icon 
    
    function put_icon(param){
        
        
        document.write('<div class="icon '+param+'"></div>' );
        
    } // put simple
    
    // show as icon & hint
    
    function put_icon_title(param){
        
        show_temp['put_icon_hint'] = param.split(','); 
        
        document.write('<div class="icon '+show_temp['put_icon_hint'][0]+'"  title="'+show_temp['put_icon_hint'][1]+'"></div>' );
        
    } // put simple
    
    // put style
    
    function put_style(param){
        
        var tag = (param.tag!=undefined)?param.tag:'font';
        
        document.write('<'+tag+' class="'+param.style+'"'+param.attr+'>'+param.content+'</'+tag+'>' );
        
    } // put simple
    
    
     // put style
    
    function get_style(param){
        
        var tag = (param.tag!=undefined)?param.tag:'span';
        
        return '<'+tag+' class="'+param.style+'" '+param.attr+'>'+param.content+'</'+tag+'>' ;
        
    } // put simpl
    
    
        
    
    // show phone mobile email info
    
    function show_phone_mobile_email(param){
        
        show_temp = undefined;
        
        show_temp = param.split('[C]');
        
        document.write('<font class="telephone icon opacity_75">&nbsp;</font>'+show_temp[0]+'<br>'+
                       '<font class="phone icon opacity_75">&nbsp;</font>'+show_temp[1]+'<br>'+
                       '<font class="email icon opacity_75">&nbsp;</font>'+show_temp[2]
                       );
                
    } // end
    
    
    // show phone mobile email info
    
    function show_list(param){
        
        var lv=new Object({});
        
        var show_temp; 
        
        lv.temp ='';
        
        
        show_temp = param.split(',');
        
        lv.list_idx_length = show_temp.length-1;
        
        for(var idx in show_temp){
            
            lv.temp+=(lv.list_idx_length==idx)?show_temp[idx]:show_temp[idx]+'<font class="spliter"> | </font>';            
            
        } // end
                
        document.write('<font class="no_wrap">'+lv.temp+'</font>');
                
    } // end
    
    // Show base image
    
    function show_entity_child_image(img_id){
              
                  if(img_id!=0){
                    
                      put_style({'tag':'img',
                                 'attr':' width="50px" src="images/entity/child/'+img_id+'1.jpg"',
                                 'content':''
                      });
                      
                  } //if
              
          } // end
    
       // show phone mobile email info
    
    function show_by_lines(param){
        
        var lv=new Object({});
        
        var show_temp; 
        
        lv.temp ='';
        
        
        show_temp = param.split(',');
        
        lv.list_idx_length = show_temp.length-1;
        
        for(var idx in show_temp){
            
            lv.temp+=(lv.list_idx_length==idx)?show_temp[idx]:show_temp[idx]+'<br>';            
            
        } // end
                
        document.write('<font class="no_wrap">'+lv.temp+'</font>');
                
    } // end
    
    
    // show user info
    
    function show_user_info(param){
        
        show_temp = undefined;
        
        show_temp = param.split(',');
        
        document.write( show_temp[0]+'&nbsp;<font class="label_grand_child no_wrap">|&nbsp;'+show_temp[1]+'</font>');
                
    } // end
    
    // show user info
    
    function show_user_info_2l(param){
        
        show_temp = undefined;
        
        show_temp = param.split(',');
        
        document.write('<div>'+show_temp[0]+'</div><div><span class="label_grand_child no_wrap">'+show_temp[1]+'</span></div>');
                
    } // end
    
    
    // tip from list
    
    function tip_from_list(param){
        
        show_temp = undefined;
        
        show_temp = param.split(',');
        
        var show_formated = param.replace(/\,/g,'<br>');
        
        if(show_temp[1]!=undefined){        
            document.write('<a class="tip">'+show_temp[0]+'..</a>'+'<font class="tooltiptext">'+show_formated+'</font>');        
        }else{            
            document.write(show_temp[0]);            
        }
    } // end
    
    // tip from content
    
    function tip(hint,content,tip_style){
    
        if((tip!=undefined) && (content!=undefined) ){
            
            document.write('<a class="tip '+tip_style+'">'+hint+'</a>'+'<font class="tooltiptext">'+content+'</font>');            
        }
        
    } // end
    
    
        
    // tip from content
    
    function tip_right(hint,content,tip_style){
    
        if((tip!=undefined) && (content!=undefined) ){
            
            document.write('<a class="tip_right '+tip_style+'">'+hint+'</a>'+'<font class="tooltiptext">'+content+'</font>');            
        }
        
    } // end
    
    
    // get tip
    
    function get_tip(hint,content,tip_style) {
	
	var temp ='';
	
	if((tip!=undefined) && (content!=undefined) ){
	    
	    temp = '<a class="tip '+tip_style+'">'+hint+'</a>'+'<font class="tooltiptext">'+content+'</font>'; 
	               
	}
	
	return temp;
    
    } //end
	
	
	function grid_to_list_ol(content){
		grid_to_list_tip({'content'   :content,
					  'list_type' :'ol',
					  'list_style':'decimal pad_10'
					 });
	} // end
	
	function grid_to_list_ul(content){
		grid_to_list_tip({'content'   :content,
						  'list_type' :'ul',
						  'list_style':'bullet pad_10'
						 });
	} // end
	
	function grid_to_list_tip(param){
		
		var lv ={};
		
		lv.temp_content=JSON.parse(param.content);
		param.content  = lv.temp_content;
		lv.content = grid_to_list(param);		
		lv.hint	   = (lv.temp_content.length>1)?' (<b>'+(lv.temp_content.length)+'</b>)':'';
		
		// call tip func
		tip(lv.temp_content[0].join(' ')+lv.hint,
			lv.content,
			'tip_bottom');		
		
	} // end
	
	// function 1 column grid
	function grid_to_list(param){
			
		var lv ={};
		lv.list	   = `<${param.list_type} class='${param.list_style}'>`;
		
		for(lv.rows of param.content){				
			if(lv.rows[0].length>0){
				lv.list+= '<li>'+lv.rows.join(' ')+'</li>';
			}
		}
		
		lv.list+=`</${param.list_type}>`;
		
		return lv.list;
		
	} // end
    
    
    
    // warranty
    
    function warranty(terms){
        
            var lv = new Object({});

            lv.temp='';
            
            for(var idx=0;idx<terms;idx++){
                
                lv.temp+='<i class="fa fa-star" aria-hidden="true">&nbsp;</i>';
            }

        
            document.write(lv.temp +'&nbsp;&nbsp;<big>'+terms+'</big> Years Warranty');
    }
    
	
    
    
    
    
    