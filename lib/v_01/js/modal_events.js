

      function modal_hide_events(){
	  //Close :
			  
			//Sign up:
			
			  $('#myModalSignIn').on('hidden.bs.modal', function (e) {
			    
			    document.getElementById("form-sign-in").reset();
                            
                    
			    
			    set_input_style({'element_id':'inputEmail',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon form-control-feedback',
					     'is_warn':1,
					     'message':''
					    });
			    
			    set_input_style({'element_id':'inputPassword',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon form-control-feedback',
					     'is_warn':0,
					     'message':''
					    });
			    
			 });
			
			
                    // Sign up:  
                    $('#myModal_signUp').on('hidden.bs.modal', function (e) {
                        
                                        document.getElementById("form-sign-up").reset();
                                      
                                        set_input_style({'element_id':'singUpinputEmail',
                                                         'area':'form-group has-feedback',
                                                         'icon':'glyphicon form-control-feedback',
                                                         'is_warn':1,
                                                         'message':''
                                                        });
                                    
                                        set_input_style({'element_id':'userName',
                                                         'area':'form-group has-feedback',
                                                         'icon':'glyphicon  form-control-feedback',
                                                         'is_warn':0,
                                                         'message':''
                                                        });
                                        
                                        document.getElementById('userName_message').innerHTML='';
                                    
                                        set_input_style({'element_id':'signUpinputPassword',
                                                        'area':'form-group has-feedback',
                                                        'icon':'glyphicon  form-control-feedback',
                                                        'is_warn':0,
                                                        'message':''
                                                       });
                                        
                                        document.getElementById('signUpinputPassword_message').innerHTML='';
                                     
                                        set_input_style({'element_id':'signUpinputMobile',
                                                        'area':'form-group has-feedback',
                                                        'icon':'glyphicon  form-control-feedback',
                                                        'is_warn':0,
                                                        'message':''
                                                       });
                                        
                                        document.getElementById('signUpinputMobile_message').innerHTML='';
                        
                    });
                          
                          
			  $('#myModal_signUp').on('show.bs.modal', function (e) {
                                        
                                        set_series({'elements':temp_gate.action.SI.elements,
                                                            'reset':1
                                        });                                     
                          });
			  
			  //Forgot Password:
			  $('#myModalForgetPassword').on('hidden.bs.modal', function (e) {
			    
			    document.getElementById("form-forgot").reset();
                            
			    //document.getElementById('for_inputEmail_warn').innerHTML='';
			    
			    set_input_style({'element_id':'for_inputEmail',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon  form-control-feedback',
					     'is_warn':1,
					     'message':''
					    });
			    
			 });
                          
                          $('#myModalForgetPassword').on('show.bs.modal', function (e) {
                                        
                                        set_series({'elements':temp_gate.action.SI.elements,
                                                            'reset':1
                                        });                                     
                          });
			  
			  //Change Password:
			  
			  $('#myModalChangePassword').on('hidden.bs.modal', function (e) {
			    
			    document.getElementById("form-change-pswd").reset();
                            
                            set_input_style({'element_id':'chng_newPassword',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon  form-control-feedback',
					     'is_warn':1,
					     'message':''
					    });
                            
                            set_input_style({'element_id':'chng_currentPassword',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon form-control-feedback',
					     'is_warn':1,
					     'message':''
					    });
                            
                            set_input_style({'element_id':'change_confirmPassword',
					     'area':'form-group has-feedback',
					     'icon':'glyphicon  form-control-feedback',
					     'is_warn':1,
					     'message':''
					    });
			    
			 });
			  
                          //My Account:
                          $('#my-account').on('show.bs.modal', function (e) {
                                       
                                        var user_mail = ELEMENT('user_email').value;
                                      
                                        ELEMENT('lbl-user-mail').innerHTML=user_mail;
                                        ELEMENT('lbl-user-name').innerHTML=ELEMENT('user_name').value;                                      
                                        ELEMENT('lbl-tot-mem').innerHTML=$("#relation_length").html();
                                        ELEMENT('lbl-tot-male').innerHTML=$("#male_length").html();
                                        ELEMENT('lbl-tot-female').innerHTML=$("#female_length").html();
                          });
                          
                          
                          //Invite mail hidden:
                           $('#my-invite').on('hidden.bs.modal', function (e) {
                              
                              ELEMENT('invite-email').value ='';
                              ELEMENT('invite-email_warn').innerHTML = '';
                                        
                           });
                          
                          //Message box hide:
                          
                          $('#my-message-box').on('hidden.bs.modal',function (e){
                                        
                                        var last_action = G._last.bs_action;
                                        
                                        if(last_action=='FPS'){ // Forgot Password
                                                   $('#myModalForgetPassword').modal('hide');
                                                   $('#myModalSignIn').modal('hide');
                                                      
                                        }//end forgot password success
                                        else if (last_action=='SUS') { // Signup
                                                   $('#myModal_signUp').modal('hide');
                                                  // $('#myModalSignIn').modal('show');
                                        }
                                        else if (last_action=='CPS') { // Change password:
                                                    $('#myModalChangePassword').modal('hide');     
                                        }
                                        else if (last_action=='IME') { // Invited Mail
                                                    $('#invite-mail-id').focus();                                                    
                                        }
                                        else if (last_action=='IMS') { // Invited Mail
                                                    //node_action(Graph.node);
                                                    
                                                    $('#my-invite').modal('hide');
                                                    
                                                     $('#invite-email').val();
                                        }
                                        else if (last_action=='SNS') { // Shared Node Success
                                                   // $('#share-user-email-fb').val();
                                                   
                                                   ELEMENT('share-user-email-fb').value = '';
                                        }
                                        
                                        //else if (last_action=='CCS') { //Clear cache
                                        //            $('#my-clear-cache').modal('hide');
                                        //}
                          });
                          
                        
			  
      }
      
      
     // function alert_action
     
     
     
     