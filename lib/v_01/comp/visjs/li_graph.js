 function htmlListToGraphData(id) {

                                               this.nodes = [];
                                               
                                               this.edges = [];
                                               
                                               this.nodeRef = {};
                                               
                                               this.nodeCounter = 0;
                                               
                                               this.debug = 0;
                                               
                                               this.apex_id = id;
                                               
                                               this.parseElement=function(id){
                                               
                                                                                              var lv ={};
                                                                                              
                                                                                              // id is there
                                                                                              if(id){
                                                                                                this.apex_id=id;
                                                                                              } 
                                                                                              
                                                                                              // element
                                                                                              lv.element        = document.getElementById(this.apex_id);
                                                                                              lv.parentElement  = document.getElementById(this.apex_id).parentElement;
                                                                                              
                                                                                              this.log('Parent'+lv.parentElement+'--'+this.nodes.length+'--'+lv.element.id);
                                                                                              
                                                                                              if(this.nodes.length==0){
                                                                                            
                                                                                              lv.parentElement=lv.element;
                                                                                              
                                                                                              this.nodes.push({'id':lv.element.id,'label':lv.element.dataset.label,'group':lv.element.className})
                                                                                              
                                                                                              }
                                                                                              
                                                                                              lv.childs         = lv.element.children;
                                                                                              lv.childCount     = lv.childs.length;
                                                                                              
                                                                                              for(var cidx in lv.childs) {
                                                                                            
                                                                                              lv.currentList   = lv.childs[cidx];
                                                                                              lv.currentChild = document.getElementById(lv.currentList.id);
                                                                                              
                                                                                              if(lv.currentChild!=undefined){
                                                                                                  
                                                                                                  if (lv.currentChild.tagName!='UL') {
                                                                                                                                             
                                                                                                                                             this.log(lv.parentElement.id+'--'+id+'-->'+
                                                                                                                                                   lv.currentList.dataset.label+'--'+document.getElementById(lv.currentList.id).tagName)
                                                                                                                                               
                                                                                                                                             this.nodes.push({'id':lv.currentList.id,'label':String(lv.currentList.dataset.label).replace( "&gt;",'>').replace("&lt;",'<'),'group':lv.currentList.className})
                                                                                                                                             this.edges.push({'from':lv.parentElement.id,'to':lv.currentList.id});
                                                                                                                                               
                                                                                                  } // ul
                                                                                                 
                                                                                                  this.parseElement(lv.currentList.id);
                                                                                                  
                                                                                              } // current element
                                                                                            
                                                                                         } // each child
					       
                                                } // parse element
					       

					       //graph text11
                 
					       this.getGraphText=function(id){
					       
											      var lv ={};
											      
											      // id is there
											      if(id){
												      this.apex_id=id;
											      } 
											      
											      console.log('0000');
											      
											      // element
											      lv.element        = document.getElementById(this.apex_id);
											      lv.parentElement  = document.getElementById(this.apex_id).parentElement;
											      
											      this.log('Parent'+lv.parentElement+'--'+this.nodes.length+'--'+lv.element.id);
											      
											      if(this.nodes.length==0){
												  
                                               lv.parentElement=lv.element;                                               
                                               this.nodes.push({'id':lv.element.id,'label':lv.element.dataset.label,'group':lv.element.className});
                                               
                                               // node count                                                                                              
                                               this.nodeCounter++;
                                               this.nodeRef[lv.parentElement.id]=this.nodeCounter+this.getLabelWithClass(lv.element.dataset.label,lv.element.className);
                                                                                              
											      }
											      
											      lv.childs         = lv.element.children;
											      lv.childCount     = lv.childs.length;
											      
											      for(var cidx in lv.childs) {
												  
												  lv.currentList   = lv.childs[cidx];
												  lv.currentChild = document.getElementById(lv.currentList.id);
												  
												  if(lv.currentChild!=undefined){
												      
												      if (lv.currentChild.tagName!='UL') {
													  
                                               this.log(lv.parentElement.id+'--'+id+'-->'+
                                               lv.currentList.dataset.label+'--'+document.getElementById(lv.currentList.id).tagName);
												                                      
                                               lv.nodeLabel =  String(lv.currentList.dataset.label).replace( "&gt;",'>').replace("&lt;",'<');
                                               lv.nodeLabelCheck ='';
                  
                                               this.nodes.push({'id'  :lv.currentList.id,
                                                               'label':lv.nodeLabel,
                                                               'group':lv.currentList.className});
                                                                                         
                                               if (this.nodeRef[lv.currentList.id]==undefined) {
                                                       lv.nodeLabelCheck=this.getLabelWithClass(lv.nodeLabel,lv.currentList.className);
                                               }
                                               
                                               // node count                                                                                              
                                               this.nodeCounter++;
                                               this.nodeRef[lv.currentList.id]=this.nodeCounter;
                                               
                                               this.edges.push(this.nodeRef[lv.parentElement.id]+'-->'+this.nodeRef[lv.currentList.id]+lv.nodeLabelCheck);
												      
												      } // ul
												     
												      this.getGraphText(lv.currentList.id);
												      
												  } // current element
												  
											       } // each child
											      
											      } // parse element
													      
											      // get graph data
											      this.getGraphData = function(){
											      
                                               return {'nodes':this.nodes,
                                                 'edges':this.edges
                                                }
											      }
											      
											      this.log=function(message){
											      
                                               if(this.debug==1){
                                                  console.log(message);
                                               }
											      
											      } // end
                 
                 
                 this.getLabelWithClass = function(label,nodeClass){
                                               
                            var lv = new Object({});
                            
                            lv['kal-icon-var']   = function(label){ return '('+label+'):::kal-icon-var';}
                            lv['kal-icon-obj']   = function(label){ return '['+label+']:::kal-icon-obj';}
                            lv['kal-icon-method']= function(label){ return '(-'+label+'-):::kal-icon-method';}
                            lv['kal-icon-type']  = function(label){ return '['+label+']:::kal-icon-type';}
                            
                            nodeClass=(lv[nodeClass]!=undefined)?nodeClass:'kal-icon-obj';
                            
                            return lv[nodeClass](label);                                                                                   
                                               
                 } // end
											      
											      
											      this.setDebug=function(status){
											      
                                               		      this.debug=status || 1;                
                                               }
} // end 