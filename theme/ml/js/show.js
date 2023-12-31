
    // show user info
    
    var show_temp = new Object({});
    
    function boolean_display(content){
        
        var style = (content==1)?'active':'inactive';
        
        put_style({ 'style':style+' icon',
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
    
    
    // show user info
    
    function show_user_info(param){
        
        show_temp = undefined;
        
        show_temp = param.split(',');
        
        document.write( show_temp[0]+'&nbsp;<font class="label_grand_child no_wrap">|&nbsp;'+show_temp[1]+'</font>');
                
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
    
    
    
    