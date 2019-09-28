
// JavaScript Document
var tempValue;

var objId=0;
var objName=new Object({});

// ),(,-.
var RX =/[a-z]/gi;

           
           
           


           //Mueric Fiedls
           function PR_All_Numeric(e,vips){
                   
                            // Both IE and Firefox 
           
                           //alert('----------------');
                           
                           
           
                      if(document.all) {
                           
                           
                            if( (e.keyCode<48) ||  (e.keyCode>57) ){
                                      
                                      if(vips) { if(vips.indexOf(String.fromCharCode(e.keyCode))>-1){ 
                                      
                                   
                                      
                                      return true;}else {return false; } }
                            else{ return false; } 
                              }
                      }
                      
                      else{
                             
                              if(e.charCode==0) {
                                      
                                      
                                      
                                      return true;
                              }
                              
                           //   alert('firefox');
                                   if( (e.charCode<48) ||  (e.charCode>57) ) {
                                           
                                           if(vips) { if(vips.indexOf(String.fromCharCode(e.charCode))>-1){ return true;}else {return false; } }
                                   
                                   else{  return false; } 
                              }
                              
                      }
           }

//Alphabetic only
function PR_All_Alphabetic(e,vips){
		
			 // Both IE and Firefox 
		
		if(document.all) {
		
		  
		   if( (e.keyCode<65) ||  ((e.keyCode>90)&&(event.keyCode<97)) ||(e.keyCode>122) ) {
			  
				if(vips) { if(vips.indexOf(String.fromCharCode(e.keyCode))>-1){ return true;}else {return false; } }
			else{ return false; } 
		   }
		   		   
		}
		
		else{
			
			if(e.charCode==0){
			   return true;
		    }
			
			
			if( (e.charCode<65) ||  ((e.charCode>90)&&(e.charCode<97)) ||(e.charCode>122) ){
				
				
				if(vips) { if(vips.indexOf(String.fromCharCode(e.charCode))>-1){ return true;}else {return false; } }
				
				
				else{ return false; } 
		   }
			
		}
}



//Alpha Numeric Only
function PR_All_Alpha_Numeric(e,vips){
	
	 // Both IE and Firefox 
	 	
		
	if(document.all) {
		
  	
		if((e.keyCode<48) || ((e.keyCode>57)&&(e.keyCode<65)) ||  ((e.keyCode>90)&&(e.keyCode<97)) ||(e.keyCode>122) ) {	
		
	    	if(vips) { if(vips.indexOf(String.fromCharCode(e.keyCode))>-1){ return true;}else {return false; } }
		else{ 
		
		return false; } 
		  
		  }
	}
	
	else{	
		
		if(e.charCode==0){
			return true;
		}
		
		if((e.charCode<48) || ((e.charCode>57)&&(e.charCode<65)) ||  ((e.charCode>90)&&(e.charCode<97)) ||(e.charCode>122) ) {
			
			
			if(vips) { if(vips.indexOf(String.fromCharCode(e.charCode))>-1){ return true;}else {return false; } }
		else{ return false; } 
		  
		}	
	}

}

//Allow this Only

function PR_Allow(field,vips)
{
    if(vips) {if(vips.indexOf(String.fromCharCode(event.keyCode))>-1){ return true;}else { window.alert(vips+' these characters only allowed');return false; } }
	else{ return false; } 
}



//Stop this Only

function PR_Stop(field,vips)
{
    if(vips) {if(vips.indexOf(String.fromCharCode(event.keyCode))<0){ return true;}else { window.alert(vips+' these characters not allowed');return false; } }
	else{ return false; } 
}



function PR_Telephone(field)
{
   
    
   var tempValue=new String(field.value);
   var TL_TL=tempValue.length;
   //window.alert(event.keyCode);
   //Setting '('Character

   
   //Event Code
   if( ((event.keyCode<48)||(event.keyCode>57))&&(event.keyCode!=13) )
   {
		  
		  return false;
		  eventCount--;
   }
   else
   {  
            if(tempValue.length==0)
  				 {
  			    	field.value='(';
				   var eventCount=0;
 				 }  
   			else
   				 {
			       eventCount++;
				  //setting ')' Character
				  //Adding First Break
				   if( (tempValue.indexOf('(')==-1) && (tempValue.length>=1) )
				   {
				       field.value='('+field.value;
					   return false; 
				   } 
				   
				   //Adding Second (
				  if(tempValue.length==4)
				    {
						field.value+=')';  
					}
				  //Setting -
				  if(tempValue.length==8)
				    {
						field.value+='-';  
					}	
				  //End Count
				  if(tempValue.length>=13)
				    {
						eventCount=0;
					    return false;
					}
			   
			     //Adding )
				 if( (tempValue.indexOf(')')==-1) && (tempValue.length>4) )
				   {
				       field.value=field.value.slice(0,4)+')'+field.value.slice(4,TL_TL);
					   return false; 
				   } 
				 
				 //Adding -
				if( (tempValue.indexOf('-')==-1) && (tempValue.length>8) )
				   {
				       field.value=field.value.slice(0,8)+'-'+field.value.slice(8,TL_TL);
					   return false; 
				   } 
				     
			     //Adding inbetween character ()
				if(  ((tempValue.indexOf(')')-tempValue.indexOf('('))==4) && (tempValue.length>4)  )
				   {
				     		 if( ((tempValue.indexOf('-')-tempValue.indexOf(')'))!=4)  )
							 {
							      //var tindex=tempValue.indexOf('-')-tempValue.indexOf(')');
							 // fv=field.createTextRange();
							   //field.value=field.value.slice(0,fv.moveTo(x,y))+String.fromCharCode(event.keyCode)+field.value.slice((tindex+4),TL_TL);     
					 			return true;
						     }
			
				   }
			   
			    
			   //Adding After ()
			       if( (tempValue.indexOf(')')!=-1) && (tempValue.indexOf('(')!=-1) )
				   	{
					
					  
					   if(   ((tempValue.indexOf(')')-tempValue.indexOf('('))!=4)  && ((tempValue.indexOf('-')-tempValue.indexOf(')'))==4) && (tempValue.charAt(tempValue.indexOf('-')+4)) )
						  { 
						  var tindex=tempValue.indexOf(')')-tempValue.indexOf('(');
							   field.value=field.value.slice(0,tindex)+String.fromCharCode(event.keyCode)+field.value.slice(tindex,TL_TL);
							   return false; 
						  }
				 
					}

					
			   
			   }
   
   }
  
}



function PR_TP_Check(field)
{
   
  if( (field.value.length<13) || (field.value.charAt(0)!='(') || (field.value.charAt(4)!=')') || (field.value.charAt(8)!='-')  )
  {
  field.focus();
  return false;
  }
  else
  {
  return true;
  }
   
}


//Checking for fixed length
function PR_Len_Check(field,minilength){
 

  var MIN_LENGTH=new Number(minilength);
  if(field.value.length<MIN_LENGTH)
  	{  
		//window.alert('The information must have above or '+minilength+' characters');
		//field.focus(); 
		return false; 
	}
  else
   {
   	    return true; 
   }   
}



function PR_Len_Exact(field,exactlength){				 // Both IE and Firefox 
   
	
  var inputName = field.name ;
  //alert(inputName);
  var EXACT_LENGTH=new Number(exactlength);
  //alert(field.value.length);
  field.maxLength=exactlength;
  
  if(field.value.length!=EXACT_LENGTH){ 
  
  		
  	window.alert('The information must have '+EXACT_LENGTH+' characters');
	//alert(field.value);
	 setTimeout("document.forms[0]."+inputName+".select();",0);
	//document.getElementById('mobile').focus();
	//setTimeout("globalvar.focus()",250);
	//field.select(); 
	return false;
  }
	
  else { return true; }  
   
}


//exact or Exit
function PR_Len_Exact_Or_Exit(field,exactlength){
 
  var EXACT_LENGTH=new Number(exactlength);
  field.maxLength=5;
  if(field.value.length==0)
  { return true; }
  else if( (field.value.length!=EXACT_LENGTH) && (field.value.length>0) ){  window.alert('The information must have '+EXACT_LENGTH+' characters or leave it empty');field.focus(); return false; }
}





//Functiion for fixed entry
function PR_Fixed_Way(field,way){
 
  var fixed_var=new String(way);

  var fixed_length=fixed_var.length;
  
 var tempValue=field.value;
  //Length Validation
  if(fixed_var.length!=field.value.length)
  {
    tell(way);	 return false;
  }
  else
  {
       for(PR_i=0;PR_i<fixed_length;PR_i++)
	   {
	   
	       
			//window.alert(PR_i+'..');
			
			var c_v=new Number(tempValue.charCodeAt(PR_i));
			
	        if(fixed_var.charAt(PR_i)=='9')
			{
			      
				    
				  if( (58>c_v) && (c_v>47) )
				  {
				     
				
				  }
				  else { tell(way);   return false; }
		    }     
			else if(fixed_var.charAt(PR_i)=='A')
			{
			    
				  if(   ((c_v>64)&&(c_v<91)) || ((c_v>96)&&(c_v<123)) )
 				  {
				   
					
				  }
				  else { tell(way);   return false; }
		    } 
			else if(fixed_var.charCodeAt(PR_i)!=c_v)
			{
			    tell(way); 	 return false;
			}
		  
			  
			
	   }
	 
	  
  }
   
   

   
}


   function tell(info)
   {
     window.alert('The Information must be in '+info+' format');

   }
   

   
   
   function convey(info)
   {
     window.alert('Please check your '+info+' entry');

   }
   
   function te(){
	   
		alert('...');   
	   
   }
   
//Checking Email]
function PR_Email(field)
{
   var tempValue=field.value;
   var inputName = field.name ;
   
   
   if(tempValue.length>0)
   {
        if(tempValue.indexOf('@')<0)
		{
		 //convey('email');
                      if(document.all){
                                 
                                 field.select();
                                 //alert('Please give a valid e-mail');
                      
                 //document.getElementById('email').select();
                                 return false;
                                 
                      }else {
						  
						
                                 setTimeout("document.forms[0]."+inputName+".select();",0);
                                // alert('Please give a valid e-mail');
                      
                                     //document.getElementById('email').select();
                                  return false;                                            
                                 
                      }                      
           
		}else{
                      
                      
                                 var e_info=new Array();
                                 e_info=tempValue.split('@');
                                 
                                 if( (e_info[0].length==0) || (e_info[1].length==0) ){
                                    
                                   if(document.all){
                                               
                                               field.select();
                                               //alert('Please give a valid e-mail');
                                               return false;
                                               
                                    }else {
										
                                               setTimeout("document.forms[0]."+inputName+".select();",0);
                                               //alert('Please give a valid e-mail');                      
                                               return false;
                                    }
                                 }else if(e_info[1].indexOf('.')<0)
                                 {
                                    //convey('email');
                                    if(document.all){
                                               
                                               field.select();
                                               //alert('Please give a valid e-mail');
                                               return false;
                                               
                                    }else{
										
                                               setTimeout("document.forms[0]."+inputName+".select();",0);
                                               //alert('Please give a valid e-mail');
                                               return false;
                                    }
                                         
                                 }
                                 else if(e_info[1].indexOf('.')>-1){
                                    
                                               var e_data=new Array();
                                               
                                               e_data=e_info[1].split('.');
                                               
                                               e_data_length=e_data.length;
                                               
                                               for(PR_i=0;PR_i<e_data_length;PR_i++){
                                                          
                                                              if(e_data[PR_i].length<1){
                                                                     
                                                                     if(document.all){
                                               
                                                                                field.select();
                                                                                //alert('Please give a valid e-mail');
                                                                                return false;
                                                                     }else {
									     
                                                                                setTimeout("document.forms[0]."+inputName+".select();",0);
                                                                                //alert('Please give a valid e-mail');
                                                                                return false;
                                                                     }
                                                                     
                                                              }
                                               }
                                 }else{
                                    
                                               return true;
                                 }
                   
                   
	    }
            
            
           return true; 
   }
   
   

}
   //Email Ended
   
function PR_Web(field)
{
   var tempValue=field.value;
   if(tempValue.length>0)
   {
       if( (tempValue.length==11) && (tempValue=="http://www.") )
	   {
	     field.value='';
	   }
	   else if( (tempValue.length>11) &&  (tempValue.length<16) )
	   {
	  	  convey('web');
		  return false;
	   }
	   else if( (tempValue.length>15) &&  (tempValue.indexOf('http://www.')!=0) )
	   {
	     convey('web'); return false;
	   }
	   
	   else if(tempValue.length>15)
	   {	   
	       var w_data=new Array();
		   w_data=tempValue.split('.');
	       w_data_length=w_data.length; 
		   
		     if(w_data_length<3)
			 {
			  convey('web'); return false; 
			 }
		   
			 for(PR_i=0;PR_i<w_data_length;PR_i++)
				 	{
						
						if(w_data[PR_i].length<1)
						 { convey('web'); return false; }
						
						if((PR_i+1)==w_data_length)
						{
						     if(w_data[PR_i].length<2)
							 { convey('web'); return false; }

						}
						
						 
					}
		   
	   }
	  
	   
	   
   }
   

}   
   
   //Focus
function PR_Web_Focus(field)
{
    
	    var tempValue=field.value;
		if(tempValue.length<12)
			  {
               field.value="http://www.";
			   return true;
			  }
   
}


//PR Money
function PR_Money(field,num_digit)
{
	
		var tempValue=field.value;
		
		 var inputName = field.name ;
			
			
			var money_value=new Array();
			
			if(tempValue.indexOf('.')>-1)
			{
				money_value=tempValue.split('.');
			   		if(money_value.length>2){ 
			   			convey(''); 
					//	field.focus();
						 if(document.all){
                                               
                         	field.select();
                          
                            return false;
						 }else{
							
				  			setTimeout("document.forms[0]."+inputName+".select();",0);
							return false; 
						}
					}
			   else
			   {
				 if(money_value[0].length==0){   money_value[0]='0'+tempValue;  }
				 if(money_value[1].length!=2) {  if(money_value[1].length==1){ field.value=tempValue;} 
												 else if(money_value[1].length>2) 
												 {
													 if(num_digit){
														 money_trim=money_value[1].slice(0,num_digit);	
														 
													 }else{
														money_trim=money_value[1].slice(0,2);	 
													 }
													
													field.value=money_value[0]+'.'+money_trim;
												  } 
											  }
			   } 
			}
			
		   
		   if(tempValue.length==0)
		   { field.value=0;	}
		   
		   
	
   
}


//Value Checkings functions
function PR_Value_Check(field,check_type,check_value)
{
  
 
    var  tempValue=field.value;
    var check_word;
	check_type=check_type.toLowerCase()
	
	
    if((check_type=='min') ||(check_type==0))
	{
//		alert(tempValue+'.......'+check_value);
	      if(tempValue>=check_value){ 
		  
		  
		  window.alert("The information  not to exceed more than "+(check_value-1)); return false; }
		  	
	}
	else if((check_type=='max') ||(check_type==1))
	{
	      if(tempValue<=check_value){ window.alert("The information must be above "+check_value); return false; }
	}
	else if( (check_type=='equ') || (check_type==2) )
	{
	      if(tempValue!=check_value){ window.alert("The information must be  "+check_value); return false; }
	}	
    else
	{  
	   window.alert('Please check your entry');
	} 
	
	
}


                      //Mueric Fiedls
           function PR_Pattern(element){
                      
                      var lv = new Object({});
                   
                       lv.pattern = new RegExp(element.dataset.pattern);
                       
                      console.log(lv.pattern);
                  
                      lv.result=element.value.match(lv.pattern);
                      
                      console.log(lv.result);
                      
                      //if (lv.result==null) {
                      //           
                      //           return false;
                      //}else{
                      //           
                      //           return true;
                      //                          
                      //}
           }