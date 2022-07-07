<?php
/**
 * This example shows settings to use when sending via Google's Gmail servers.
 */


        
        function send_mail($param){
         
	
            date_default_timezone_set('Etc/UTC');
            
            require_once 'PHPMailerAutoload.php';
            
            //Create a new PHPMailer instance
            $mail = new PHPMailer;
	              
            //Tell PHPMailer to use SMTP
            $mail->isSMTP();
            
            //Enable SMTP debugging
            // 0 = off (for production use)
            // 1 = client messages
            // 2 = client and server messages
            $mail->SMTPDebug = 0;
            
            //Ask for HTML-friendly debug output
            $mail->Debugoutput = 'html';
            
            //Set the hostname of the mail server
          
	    $mail->Host = get_config('smpt_host'); //'smtp.gmail.com';
            
	    //Set the encryption system to use - ssl (deprecated) or tls
            $mail->SMTPSecure = get_config('smpt_secure'); //'ssl';
	    
            //Set the SMTP port number - 587 for authenticated TLS, a.k.a. RFC4409 SMTP submission
            $mail->Port = get_config('smpt_port'); //465;
	    
            //Whether to use SMTP authentication
            $mail->SMTPAuth = true;
            
            //Username to use for SMTP authentication - use full email address for gmail
            $mail->Username = get_config('smpt_mail');
            
            //Password to use for SMTP authentication
            $mail->Password = get_config('smpt_pswrd');
            
            //Set who the message is to be sent from
            $mail->setFrom(get_config('to_admin'),(@$param['from'] ?? get_config('title')));
            
            //Set an alternative reply-to address
	    if(get_config('reply_mail')){
		$mail->addReplyTo(get_config('reply_mail'), get_config('title'));
	    }
	    
           # echo '================='.$param['bcc'];
            //Set who the message is to be sent to
            foreach($param['to'] as &$to){
                $mail->addAddress($to);
            }
			
	   if($param['cc']!=''){ foreach($param['cc']   as &$email){$mail->AddCC($email); } }
 	   if($param['bcc']!=''){ foreach($param['bcc'] as &$email){ $mail->AddBCC($email); } }
        
            //Set the subject line
            $mail->Subject = $param['subject'];
            
            //Read an HTML message body from an external file, convert referenced images to embedded,
            //convert HTML into a basic plain-text alternative body
	    
	    $mail->isHTML(true);
	    
            $mail->msgHTML($param['message']);
            
            //Replace the plain text body with one created manually
            //$mail->AltBody = 'This is a plain-text message body';
            
            //Attach an image file
            #$mail->addAttachment('images/phpmailer_mini.png');
             	
            //send the message, check for errors
            if (!$mail->send()) {
                echo "Mailer Error: " . $mail->ErrorInfo;
               // echo '---if----K';
		
		
                return 0;
	       
            } else {
		//echo '=====else=========';
		
                return 1;
            }
            
        } // end
		
		
	function mail_send_smtp($param){
					
					
					$message='';
					$message.="	<html>
									<head>
									<title>
										</title>
								</head>	
								<body>";
								
					$message.=$param['message'];
					
					$message.="</body></html>";
					
					$headers  = 'MIME-Version: 1.0' . "\r\n";
					$headers.= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
					$headers.='From: '.$param['subject']. "\r\n";
					//echo $param['to'].'----cc---'.$param['cc'].'=bc===>'.$param['bcc'].'==s===>'.$param['subject'].'==ms====>'.$message;
					return $mailsent= send_mail(	
					
									array(
									
									'to'=>preg_split("/\;/",@$param['to']),
									
									'cc'=>preg_split("/\;/",@$param['cc']),
									
									'bcc'=>preg_split("/\;/",@$param['bcc']),

									'subject'	=>$param['subject'],
								    
									'message'	=>$message,
									
									'from'		=> @$param['from']
									
									)
									
								   
								  );	
					
			}	
