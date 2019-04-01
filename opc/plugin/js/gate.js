

	var ajxrqst        = new ajax();
	ajxrqst.set_page('plugin/inc/wp_login.php'); 
	
	var temp_gate      = new Object({
				   
				   action:{'SI':{'id'       :'lbl-sign-in',
				                  'lbl':'Sign In',
				                 'className':'glyphicon glyphicon-log-in',
						 'elements' :['inputEmail','inputPassword']
			                        },
			                   'SU':{'id':'lbl-sign-up',
			                          'lbl':'Sign Up',
					          'className':'glyphicon glyphicon-edit',
						  'elements':['userName','singUpinputEmail','signUpinputPassword','signUpinputMobile']
					        },
                                           'FP':{'id':'lbl-reset-pass',
					          'className':'glyphicon glyphicon-refresh',
						  'elements':['for_inputEmail']
						  },
                                           'CP':{'id':'lbl-change-pass',
					         'className':'glyphicon glyphicon-sort',
						 'elements':['chng_currentPassword','change_confirmPassword','chng_newPassword']}}
                                });
	
	// add key
	
	function add_key(){
			   
			   
		
		if(validate_add_key()==true){
				
			var req = '&user_name='+GET_E_VALUE('userName')+
				  '&user_email='+GET_E_VALUE('singUpinputEmail')+
				  '&user_key='+GET_E_VALUE('signUpinputPassword')+
				  '&mobile='+GET_E_VALUE('signUpinputMobile')+
				  '&action=AKY&request=1&entryType=INT';
				  
			//alert('===='+req);
			action_blink_on('SU');
			
			//ajxrqst.set_request('plugin/inc/wp_login.php',req);
			ajxrqst.set_url(req);
			ajxrqst.send_post(add_key_response);
			
		}else{
		       action_blink_off('SU');
		       //G.bs_alert_error('Please give all details','SUE');
		       
		       document.getElementById('singUpinputEmail_warn').innerHTML='Kindly fill the needed information';
		//       set_series({'elements':temp_gate.action.SU.elements,
		//	  	    'set_alert':1
		//		   });
							
		}
		return false;
		
	} // check key
	
	
	function add_key_response(response){
		//alert(response);
		if(response==1){
			
			action_blink_off('SU');
			G.bs_alert_success("Thank you for your registration, Please check your mail","SUS","REGISTRATION SUCCESSFUL");
			
			document.getElementById('userName').value ='';
			document.getElementById('singUpinputEmail').value ='';
			document.getElementById('signUpinputPassword').value ='';
			document.getElementById('signUpinputMobile').value ='';
			
			//location.reload(); 
		}else{
			action_blink_off('SU');
			G.bs_alert_error('Given email address already exist, Please check with another email address','SUE','EMAIL ALREADY EXISTS');
		}
		
	} //end
	

	// check key
	
	function check_key(){
		
		if(validate_check_key()==true){
		
			var req = 	'&user_email='+GET_E_VALUE('inputEmail')+
				   	'&password='+GET_E_VALUE('inputPassword')+
					'&action=CKY&request=1';
					
			action_blink_on('SI');
			
			temp_gate.element = ELEMENT('inputEmail');
			
			//alert('sssss..====>'+req);
			//ajxrqst.set_request('plugin/inc/wp_login.php',req);
			//ajxrqst.send_get(check_key_response);
			ajxrqst.set_url(req);
			ajxrqst.send_post(check_key_response);
			
		}else{
			action_blink_off('SI');
			
			//G.bs_alert_error("Please give valid information","SIE");
			
			 document.getElementById('inputEmail_warn').innerHTML='Please enter a valid value';
		         set_series({'elements':temp_gate.action.SI.elements,
			  	    'set_alert':1
				   });
		}
		
		return false;
			
	  } // check key
	  
	  
	function check_key_response(temp_response){
		
		console.log(temp_response);
		//
		//alert(temp_response);
		//
		/*var response_temp = new Object({'status':1});
		
		var response = JSON.stringify(response_temp);*/
		
		var chk_res = check_gate_response(temp_response);
		
		
		
		if (chk_res==1) {
			   
			   G.bs_alert_error('DB not connected. Please sign in  once again','SIE','Information');
			  
		}else{
		         
			  var tempResponse=JSON.parse(temp_response);
			   
			 // alert('======'+tempResponse.redirect_page);
			   
			  if(Number(tempResponse.status)==1){
		       
			       document.location.href = tempResponse.redirect_page;			
			       action_blink_off('SI');
			       
			 }
			 else if(Number(tempResponse.status)==-2){
			   
			       action_blink_off('SI');
			      document.getElementById('inputEmail_warn').innerHTML = 'Please check verfication link in your email';
			      set_series({'elements':temp_gate.action.SI.elements,
					   'set_alert':1
					  });
			   
			 }else if(Number(tempResponse.status)==-1){
			   
			       action_blink_off('SI');
			      document.getElementById('inputEmail_warn').innerHTML = 'Sorry! Email and password doesn\'t match';
			      set_series({'elements':temp_gate.action.SI.elements,
					   'set_alert':1
					  });
			   
			 }
			 else{
			       action_blink_off('SI');
			       
			       //G.bs_alert_error('Please check your email and password');
			       
			       document.getElementById('inputEmail_warn').innerHTML = 'Please check your password';
							  
			       //setTimeout(function(){document.getElementById('inputEmail').focus();},500);
			       
			       set_series({'elements':temp_gate.action.SI.elements,
					   'set_alert':1
					  });
				  
		       }
		}
		
		return false;
		
		
	} //end
	
	
	// check e-mail
	
	function check_mail(element){
			   
		var temp = new Object({'neutral':{'response':0,
			                          'icon':'alert clr_red',
				                  'area':'has-error',
						  'label':'Please give email'
						  },
			               'success':{'reponse':100,
						  'icon':'',
                                                  'area':'',
						  'label':''}
			   });	   
		
		var email_syntax = PR_Email(element);
		
		var ele_area    = ELEMENT(element.id+'_area');
			
                var ele_warn    = ELEMENT(element.id+'_warn');
		
		var ele_icon    = ELEMENT(element.id+'_icon');
		
		temp_gate.element = element;
		
		
		if(email_syntax==false){
			   
			//show_message_box('Please give a valid email');
			//G.bs_alert_error('Please give a valid email');			
			
			// warn style
			ele_area.className='form-group has-error has-feedback';
			
			// warn message			
			ele_warn.innerHTML = 'Please give a valid email';
			
			// icon			
			ele_icon.className = 'glyphicon glyphicon glyphicon-alert clr_red form-control-feedback';
			
			setTimeout(set_element_focus,100);
			
			return false;

		}else{			   
			   temp_status = (temp_gate.element.value.length>0)?temp.success:temp.success;
			   
			   // clear warn style
			   ele_area.className='form-group has-feedback '+temp_status.area;
			   
			   // clear warning
			   if (temp_status.response==0){
			       //element.placeholder=temp_status.label;
			       ele_warn.innerHTML='';
			   }else{
			      ele_warn.innerHTML=temp_status.label;			      
			   }
			   
			   // style			   
			   ele_icon.className = 'glyphicon glyphicon glyphicon-'+temp_status.icon+' form-control-feedback';
			   
			   return true;
			   
		} // end
		
		temp_gate.element='';
		
		
	
	} // end
	
	
	// check e-mail
	
	function is_empty(element){
			   
		var temp = new Object({'neutral':{'response':0,
			                          'icon':'alert clr_red',
				                  'area':'has-error',
						  'label':'Please give email'
						  },
			               'success':{'reponse':100,
						  'icon':' ',
                                                  'area':'',
						  'label':''}
			   });	   
		
		
		
		var ele_area    = ELEMENT(element.id+'_area');
		
		var ele_icon    = ELEMENT(element.id+'_icon');
		
		temp_gate.element = element;
		
		
		temp_status = (temp_gate.element.value.length>0)?temp.success:temp.success;
			   
               // clear warn style
			   ele_area.className='form-group has-feedback '+temp_status.area;
			   
			   // style			   
			   ele_icon.className = 'glyphicon glyphicon-'+temp_status.icon+' form-control-feedback';
		
		return false;
	
	} // end
	
	function has_length(param){
			   
			   
			   
		var temp = new Object({'neutral':{'response':0,
			                          'icon':'alert clr_red',
				                  'area':'has-error',
						  'label':(param.warning!=undefined)?param.warning:'Give the input correctly'
						  },
			               'success':{'reponse':100,
						  'icon':' ',
                                                  'area':'',
						  'label':''}
			   });	   
		
		
		var element     = param.element;
		
		var ele_area    = ELEMENT(element.id+'_area');
		
		var ele_warn    = ELEMENT(element.id+'_warn');
		
		var ele_icon    = ELEMENT(element.id+'_icon');
		
		temp_gate.element = element;
		
		
		if( (element.value.length>0) && (element.value.length!=param.length)){
			   
			//show_message_box('Please give a valid email');
			//G.bs_alert_error('Please give a valid email');			
			
			// warn style
			ele_area.className='form-group has-error has-feedback';
			
			// warn message			
			ele_warn.innerHTML = param.warning;
			
			// icon			
			ele_icon.className = 'glyphicon glyphicon glyphicon-alert clr_red form-control-feedback';
			
			setTimeout(set_element_focus,100);
			
			return false;

		}else{			   
			   temp_status = (temp_gate.element.value.length>0)?temp.success:temp.success;
			   
			   // clear warn style
			   ele_area.className='form-group has-feedback '+temp_status.area;
			   
			   // clear warning
			   if (temp_status.response==0){
			       //element.placeholder=temp_status.label;
			       ele_warn.innerHTML='';
			   }else{
			      ele_warn.innerHTML=temp_status.label;			      
			   }
			   
			   // style			   
			   ele_icon.className = 'glyphicon glyphicon glyphicon-'+temp_status.icon+' form-control-feedback';
			   
			   return true;
			   
		} // end
		
	
	} // end
	
	
	// forget password
	
	function a_check_key(){
		if(validate_forget_key()==true){
				
			var req  = '&user_email='+GET_E_VALUE('for_inputEmail')+'&action=FK&request=1';
			//alert('====>'+req);
			action_blink_on('FP');
			
			//ajxrqst.set_request('plugin/inc/wp_login.php',req);
			   ajxrqst.set_url(req);
			ajxrqst.send_post(f_key_response);
			
		}
		else{
			action_blink_off('FP');
			//G.bs_alert_error('Please give your email address','FPE');
			document.getElementById('for_inputEmail_warn').innerHTML='Please give a valid email';
		         set_series({'elements':temp_gate.action.FP.elements,
			  	    'set_alert':1
				   });
		}
	}

	function f_key_response(response){
			//alert(response)
		if(Number(response)==1){
			
			G.bs_alert_success('Password reset successful and send to the entered email address','FPS','PASSWORD RESET SUCCESSFUL');
			document.getElementById('for_inputEmail').value='';
			action_blink_off('FP');

		}else if(Number(response)==-1){
			   
			   action_blink_off('FP');
			//G.bs_alert_error('Sorry Email Address not exists','FPE');
			document.getElementById('for_inputEmail_warn').innerHTML='Please check verification link in your mail';
			   
		}else{
			//show_message_box('Sorry. user email not exists.');
			action_blink_off('FP');
			//G.bs_alert_error('Sorry Email Address not exists','FPE');
			document.getElementById('for_inputEmail_warn').innerHTML='Sorry!Email address doesnot exists';
		}
		
	} // end
	
	//Change Key:
	
	function change_key(){
		
		if(validate_change_key()==true){
				
			var req  = '&old_pswrd='+GET_E_VALUE('chng_currentPassword')+'&new_pswrd='+GET_E_VALUE('chng_newPassword')+'&cnfrm_pswrd='+GET_E_VALUE('change_confirmPassword')+
						'&action=CP&request=1&id='+GET_E_VALUE('user_id')+'&user_email='+GET_E_VALUE('user_email');
			//alert('===-==>>>>'+req);
			action_blink_on('CP');
			 //ajxrqst.set_request('plugin/inc/wp_login.php',req);
			 ajxrqst.set_url(req);
			
			  ajxrqst.send_post(change_key_response);
		}
		else{
			        action_blink_off('CP');
				//G.bs_alert_error('Please give all information','CPE');
				document.getElementById('chng_currentPassword_warn').innerHTML='Please enter a valid value';
				set_series({'elements':temp_gate.action.CP.elements,
			  	    'set_alert':1
				   });
		}
         
	}
	
	function change_key_response(response){
			   
			//   alert('==================='+response);
			var tempResponse=JSON.parse(response);
		
		if (tempResponse.status==1) {
			   
			action_blink_off('CP');
			G.bs_alert_success(tempResponse.message,'CPS','PASSWORD CHANGED');
			document.getElementById('chng_currentPassword').value='';
			document.getElementById('chng_newPassword').value='';
			document.getElementById('change_confirmPassword').value='';
			
		}
		else{
			action_blink_off('CP');
			//G.bs_alert_error(tempResponse.message,'CPE');
			document.getElementById('chng_currentPassword_warn').innerHTML=tempResponse.message;
                        set_series({'elements':temp_gate.action.CP.elements,
			  	    'set_alert':1
				   });
		}
	}
	
	// set welcome content
	
	function set_welcome_content(response){
		
		ELEMENT('welcome_area_header').innerHTML = '';
		
		ELEMENT('welcome_area_body').innerHTML   = response;
		
		pre_run_welcome();
		 
	} // end
	
		
	function get_in(){ get_out_response();};
	
	function show_message_box(message){ fade_in('.message_box',message);  } 
	
	function hide_message_box(){ fade_out('.message_box'); } 
	
	function fade_in(element_id,message){
		$(element_id).html(message);					
		$(element_id).fadeIn(100);
	}
		
	function fade_out(element_id){
		$(element_id).fadeOut(100);
	}
	
	function fade_in_out(element_id,show_time,message){
		
		$(element_id).html(message);
		$(element_id).fadeIn(100).delay(show_time).fadeOut(500);
	}
	
	// validation
	
	function validate_check_key(){
		
		textTest(document.getElementById('inputEmail'),document.getElementById('inputPassword')); 
				
		return get_validate_response();		
	}
	
	// validation
	
	function validate_add_key(){
		
			   var temp             = new Object({'data':{},'is_json':1});
			   var lv               = new Object({});			  
						      
			   temp['data']['userName']=new Object({'is_active':true});
		   
			   temp['data']['singUpinputEmail']=new Object({'is_active':true});
		   
			   temp['data']['signUpinputPassword']=new Object({'is_active':true});
		   
			   temp['data']['signUpinputMobile']=new Object({'is_active':true});
   
			   lv.refill_elements= textTestV2(temp);
			  
			   return (lv.refill_elements.length==0)?true:false;			
	}
	
	
	function validate_forget_key(){
		
		textTest(document.getElementById('for_inputEmail')); 
			
		return get_validate_response();		
	}
	
	function validate_change_key() {
		
		textTest(document.getElementById('chng_currentPassword'),document.getElementById('chng_newPassword'),document.getElementById('change_confirmPassword')); 
		return get_validate_response();
	}
	
	
	// validate response
	
	function get_validate_response(){
	       
		if(CHECK_ERROR_FLAG[1]<1){
				
	 
			 CHECK_ERROR_MESSAGE = '';				 
			 
			 CHECK_ERROR_FLAG[1] = 1;   
				 
			 return false;
		}else{
			
			return true;
		}
		
	} // end
	
        // set focus
	
	function set_element_focus(element){
			   
		if(temp_gate.element.id!=undefined){			 
			document.getElementById(temp_gate.element.id).focus();
		}
		
        } // end

	// Show Mdodal
	
	function show_modal(param){
		
		$('#message-box-content').html(param.message);
		$('#my-message-box').modal('show');
		
	} // end
	
	
	
	//
	// Data Exists
	
	function check_is_mail_exists(element){
		
		if(element.value.length>0){
			   
			  
			       
			   if(check_mail(element)==true){
				
				var req = '&user_email='+GET_E_VALUE('singUpinputEmail')+
					  '&action=CUE'+
					  '&request=1'+
					  '&param=CUE'; 
				
				temp_gate.element = ELEMENT('singUpinputEmail');
				
				
				//ajxrqst.set_request('plugin/inc/wp_login.php',req);
				
				ajxrqst.set_url(req);
				ajxrqst.send_post(check_is_user_exists_response);
				
			   } // check
			
		} // end
		else{
			   set_input_style({'element_id':'singUpinputEmail',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon form-control-feedback',
					     'is_warn':1,
					     'message':''
					    }); 
			   
		} // end
		
	} // check is data exists
	
	
	// check_is_data_exists response
	// o/p -> <flag>:given_element
	
	function check_is_user_exists_response(response){
		
		if(Number(response)>0){
			    			  
			   set_input_style({'element_id':'singUpinputEmail',
					     'area':'form-group has-error has-feedback',
					     'icon':'glyphicon-alert clr_red form-control-feedback',
					     'is_warn':1,
					     'message':'Sorry! The given email id('+GET_E_VALUE('singUpinputEmail')+') already exists.'
					    });
			    
			   setTimeout(set_element_focus,100);
			   
			   
			   return false;
			   
		}else{
			   set_input_style({'element_id':'singUpinputEmail',
					     'area':'form-group has-success has-feedback',
					     'icon':'glyphicon-ok clr_green form-control-feedback',
					     'is_warn':1,
					     'message':''
					    });
			   return true;
		} // end
		
	} // end
	
	
	
	
	function showLoader(progress_message){
		temp_gate.loader.showLoader();
                $('#progress_message').html(progress_message);
		
        } // end
                                 
        // hide loader
                                 
        function hideLoader(){                                            
                temp_gate.loader.hideLoader();
		$('#my-page-loader').modal('hide');                                            
        } // end
                                
	
	//on
	
	function action_blink_on(action_id){			   
		//var temp = ELEMENT(temp_gate.action[action_id].id).innerHTML;	   
		ELEMENT(temp_gate.action[action_id].id).className=temp_gate.action[action_id].className+" blink";
		//ELEMENT(temp_gate.action[action_id].id).innerHTML=temp+'...';		
	} // end
	   
	function action_blink_off(action_id){                                    
		ELEMENT(temp_gate.action[action_id].id).className=temp_gate.action[action_id].className;                                                                                                           
	}
	
	
	//Close sign in:
	//function close_sign_in(){
	//		
	//		 document.getElementById("form-sign-in").reset();
	//		 document.getElementById('inputEmail_warn').style.visibility="hidden";
	//		  
	//}//end
	
	
	//Close sign up:
	//function close_sign_up(){
	//		
	//		 document.getElementById("form-sign-up").reset();
	//		  
	//}//end
	//
	//
	////Close Forgot Password:
	//function close_forgot_pswd(){
	//		
	//		 document.getElementById("form-forgot").reset();
	//		  
	//}//end
	//
	////Close Change Password
	//function close_change_pswd(){
	//		
	//		 document.getElementById("form-change-pswd").reset();
	//		  
	//}//end
	
        
	// set input style
	function set_input_style(param){
			   
			   
		 var lv = new Object({});
		 
		 var ele_area    = ELEMENT(param.element_id+'_area');		
		 var ele_icon    = ELEMENT(param.element_id+'_icon');

                 
		 ele_area.className=param.area;
		 ele_icon.className='glyphicon '+param.icon;
		 
		 if (param.is_warn==1){
		
			    var ele_warn    = ELEMENT(param.element_id+'_warn');
			    ele_warn.innerHTML =  param.message;
		 } 
	} // end
	
	
	// set style neutral	
	function set_stlye_neutral(element,param){

	           var ele_area    = ELEMENT(element.id+'_area');
		   
		   if(ele_area.className!='form-group has-feedback'){
			
			   set_input_style({'element_id':element.id,
						     'area':'form-group has-feedback',
						     'icon':'glyphicon form-control-feedback',
						     'is_warn':((param!=undefined)?param.is_warn:0),
						     'message':''
						    });
		   } // end
			   
	} // end
	
	
	// check form empty
	// element series action
	function set_series(param){
		
		 var lv = new Object({});
		 
		 for(var ele_idx in param.elements){
			   
			   lv.element_id = param.elements[ele_idx];
			   			   
			   if (param.set_alert==1){
						      
						      set_input_style({'element_id':lv.element_id,
								  'area':'form-group has-error has-feedback',
								  'icon':'glyphicon-alert clr_red form-control-feedback',
								  'is_warn':0,
								  'message':''
								 });	   
			   } // end
			   
			   
			   if (param.reset==1){
						      
						      set_input_style({'element_id':lv.element_id,
								  'area':'form-group has-feedback',
								  'icon':'form-control-feedback',
								  'is_warn':1,
								  'message':''
								 });
						      
						      ELEMENT(lv.element_id).value='';
			   } // end
			   
			   
		 } // end
		 
	} // end
	
	
	//check Response:
	
	function check_gate_response(value) {
			   
			   //alert('-----vvv--'+value);
			   
			   var txt = value.toString();
			   
			  
					// alert(txt.indexOf('Uncaught exception')+'--err---'+txt.indexOf('Error')+'-----un--'+txt.indexOf('Undefined variable:'));  
						
			   var res ='';
			   
			   if( txt.indexOf('Uncaught exception')>0 || txt.indexOf('Error')>0 || txt.indexOf('Undefined variable:')>0  ){
					res = 1;   
				}
				else{
					res = 0;
					}
				   
				return res;   
			   
				
	}
	
	// loader
	
	function show_loader(message){		
		 
		 message=(message==undefined)?'Loading..':message;		 
		 loader.show();
		 ELEMENT('progress_message').innerHTML=message;
			   
	} // end
	
        // get out
	function get_out(){
	
        	    ajxrqst.set_request('plugin/inc/wp_login.php','&action=GTO&isFB=0&uid='+GET_E_VALUE('user_id')+'&request=1');
		    ajxrqst.send_post(get_out_response_log);		
        
        } // end
	
        // get out response
        function get_out_response_log(php_response){
        
                    document.location.href = 'index.php';
        
        } // end
	
	
	
	