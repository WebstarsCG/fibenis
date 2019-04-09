<?PHP
		
		error_reporting(E_ALL);
		
		ini_set("display_errors", 1);
		
		$P_V['page_name'] 	= @$_GET['d_series'];		
		$P_V['user_id'] 	= $USER_ID;
		
		$P_V['f_series']['d_series'] = 'f_series';
		$P_V['f_series']['d']	     = 'f';
		$P_V['f_series']['dx']	     = 'fx';
		
		
		
		$PAGE_ID = $PAGE;
		
		
		
		// Generation oriented balancer functions
		
		$GX		= array( 	0=>array(				
								'get_sort_field'=>function($sort_field,
											   $d_series_data,
											   $sort_key_id){										
														
												return $sort_field[$sort_key_id];
										}
				
				
						), // version 0
						
						
						1=>array(
				
								'get_sort_field'=>function($sort_field,$d_series_data,$sort_key_id){
										
										//print_r($d_series_data);
											
										return (is_int($d_series_data[$sort_key_id]['is_sort']))?$d_series_data[$sort_key_id]['field']:$d_series_data[$sort_key_id]['is_sort'];
											
										//return $d_series_data[$sort_key_id]['field'];
										
								}
				
				
						) // version 1
				);
		
			
		/************ App Load *******************************************************************************************************************************/	
	
		if(($PAGE_ID=='d_series') || ($PAGE_ID=='d') || ($PAGE_ID=='dx') ){
				
				$app_key 	= $PAGE_NAME;
					
				$P_V['app_key']	= $app_key;
				
				$router = action_router(array('page_id'      =>$PAGE_ID,
							      'page_name' => $PAGE_NAME,
							      'lib_path'  => $LIB_PATH
							      ));
				
				
				 
				# print_r($router);
				# check file availability
				#echo $router['action'] ;
				if($router['action']){
					
						include($router['action']);
						
						# set code
						
						$D_SERIES['page_code'] = md5($PAGE_CODE);
		
						$session_off = @$D_SERIES['session_off'];
					
						// commented for session implementaion by R		
						if(@$_GET['session']=='off'){
								
								if(!$D_SERIES['session_off']){					
								        $SG->s_destroy('index.php');
								}
							
						}else{
								
								if(!$USER_ID && !$D_SERIES['session_off']){					
										$SG->s_destroy('index.php');		
								}else if($USER_ID){										
										$SG->check_entry($SG->get_permission($D_SERIES['page_code']));	
								}
						}
							
														
						if(@$D_SERIES['cascade_action']){
						
						      include("inc/data/d_series/".$app_key."_action.php");
						}
						
						// cons
						
						$D_SERIES['CONST']['alias_var'] = 'v';
						
						// gx
						
						$D_SERIES['gx']=(@$D_SERIES['gx'])?$D_SERIES['gx']:((@$_SESSION['default_gx'])?@$_SESSION['default_gx']:1);
				
						//sys_log	
				
						$param = array( 'user_id'    => $USER_ID,
							       
								'page_code'  => $D_SERIES['page_code'],
								
								'action_type'=> 'DVEW',
								
								'action'     => 'View the '.$app_key.' page');
						
						$G->set_system_log($param);
						
				}else{
				
						http_response_code(404);
						
						include ("$LIB_PATH/template/error/404.php");
						
						exit;
				}	
				
		} # app key	

		
		// show default
		
		global $rdsql;
		
		$default = "SELECT
		                   entity_value
		              FROM
			           entity_key_value
		             WHERE
			           entity_code='MP'
		               AND
			            entity_key='show_default_rows'";
			
		 $exe_default = $rdsql->exec_query($default,"deafult===> ");
		 
		 $default_row = $rdsql->data_fetch_object($exe_default);
		 
		 $show_default_rows =  ($default_row)?$default_row->entity_value:5;
		 
		 
           
		/*******************************************************************************************************************************************/

		$PAGE_TITLE = @$D_SERIES['title'];
		
		@$D_SERIES['del_permission'] = (@$D_SERIES['del_permission'])?@$D_SERIES['del_permission']:['able_del'=>0];
		@$D_SERIES['prime_index']    = (@$D_SERIES['prime_index'])?@$D_SERIES['prime_index']:1; 
	 
		if(@$D_SERIES['mode']){
				
			$D_SERIES=set_mode($D_SERIES);	
		}
	 
				
		/*******************************************************************************************************************************************/	 
		
		if(isset($_POST['DEL'])){
				
				global $rdsql;
				global $G;
				global $LIB_PATH;
		
				$P_V['message']='';
		
				for($c_i = 1; $c_i<=$_POST['D_COUNTER']; $c_i++){
				
					$check  = @$_POST['c'.$c_i];					
					
					if($check){
						
						// before_delete
						        
						if(@$D_SERIES['before_delete']){
					
							before_delete(['d_series_data' => $D_SERIES['data'],
								       'rdsql'	       => $rdsql,
								       'g'             => $G,
								       'key_id'        => $check]);						
					
						} // end
						
					 	$del = "DELETE FROM $D_SERIES[table_name]  WHERE id=$check";
						
						$exe_query = $rdsql->exec_query($del,"Del!");
						
						if(@$exe_query){
						
							$P_V['message'] = 'Successfully deleted';							
							
							//sys_log
							
							$param = array('user_id'=>$USER_ID,
								       
								      'page_code'=>@$D_SERIES['page_code'],
								      
							              'action_type'=>'DELE',
								      
							              'action'=>'Delete the '.@$D_SERIES['table_name'].'');
							
						       $G->set_system_log($param);
						
						       // after_delete
						        
							if(@$D_SERIES['after_delete']){
						
								after_delete(['d_series_data'=>$D_SERIES['data'],
									      'key_id'=>$check]);						
						
						        } // end
						}	
												
						
					}
						
				}	
		}
		/**************************************************************************************************************/	 
	
	 $OREDR_DIRECTION=array();
	 
	 $P_V['user_base_query'] =@$D_SERIES['is_user_base_query'];
	 
 	 $no_search =(@$D_SERIES['search_id'])?count(@$D_SERIES['search_id']):0;
	 
	 $search_count = 1;
	
	 $SEARCH_FIELD = array();
	
	
	 for($no_search_i = 0; $no_search_i<$no_search; $no_search_i++){
	
		$SEARCH_FIELD[$search_count] = $D_SERIES['search_id'][$no_search_i];
		
		$search_count++;
	 }  
	 
	 
	 	if(@$_GET['filter_off_id']){ 

			 $P_V['f_off_data'] = explode('[C]',@$_GET['filter_off_id']);
		
			 $P_V['f_off_cookies_id'] = $app_key.'_'. @$P_V['f_off_data'][0].@$P_V['f_off_data'][1];
		 
		} 
	 
		
		//$_GET['filter_off'];
	 	
		//$P_V['is_cokies_expire']  = (@$_GET['show'])?@$_GET['show']:(@$_GET['filter_off_id']?1:0);
		
		$P_V['show']		 = (@$D_SERIES['clear_history'])?1:@$_GET['show'];
		
		$P_V['is_cokies_expire'] = (@$_GET['filter_off_id'])?0:$P_V['show'];
		
	 	$P_V['cokies_id'] = (@$P_V['f_off_cookies_id'])?@$P_V['f_off_cookies_id']:$app_key;
		
		$P_V['s_id'] =  $G->get_cookies($P_V['cokies_id'].'s_id',@$_GET['s_id'],@$_GET['s_id'],@$P_V['is_cokies_expire']);
		
	        $SEARCH_FIELD =  (@$D_SERIES['search'][$_GET['s_type']]['search_key'])?@$D_SERIES['search'][$_GET['s_type']]['search_key']:@$SEARCH_FIELD[@$_GET['s_type']];
		
		#$P_V['s_type'] =  $G->get_cookies($P_V['cokies_id'].'s_type',@$SEARCH_FIELD[@$_GET['s_type']],@$SEARCH_FIELD[@$_GET['s_type']],@$P_V['is_cokies_expire']);
		
		$P_V['s_type'] =  $G->get_cookies($P_V['cokies_id'].'s_type',$SEARCH_FIELD,$SEARCH_FIELD,@$P_V['is_cokies_expire']);
		
					
		$P_V['s_text_type'] =  $G->get_cookies($P_V['cokies_id'].'s_text_type',@$_GET['s_text_type'],@$_GET['s_text_type'],@$P_V['is_cokies_expire']);
		
		$P_V['s_text']	=  $G->get_cookies($P_V['cokies_id'].'s_text',@$_GET['s_text'],@$_GET['s_text'],@$P_V['is_cokies_expire']);
	// }

	
	

	
	///print_r($_COOKIE);
	
	 if(@$P_V['s_type'] && @$P_V['s_id']){
		
			
	
			if(@ $P_V['s_text_type']){
			
				 @$P_V['SEARCH']= " AND  $P_V[s_type]  LIKE '%$P_V[s_text]%' ";
				 
				//@$P_V['SEARCH']= ' AND '.$P_V['s_type'].' LIKE \'%'.$P_V['s_text'].'%\' ';
			}
			
			else{
				
				@$P_V['SEARCH'] = ' AND '.$P_V['s_type'].' IN('.$P_V['s_id'].')';
			}
	
 		
		 
		 //sys_log
		 $param = array('user_id'=>$USER_ID,
				
				'page_code'=>$D_SERIES['page_code'],
				
				'action_type'=>'SERC',
				
				'action'=>'Search '.@$P_V['s_id'].' of '.$P_V['s_type'].'');
		
				$G->set_system_log($param);
		
		
						
	 }	
	 
	 
	  $P_V['WHERE_FILTER']='';
	  
	 $get_cus_filter =  get_cus_filter();
	  
	 $P_V['WHERE_FILTER'].= $get_cus_filter[0];
	  
	
	 
	 

		$WHERE_FILTER= where_filter(array(
									
									'check_field'  => @$D_SERIES['check_field'], 
									
									'search_filter' => array('search_field' => @$D_SERIES['search_field'],
								
								         'search_id'	=> @$D_SERIES['search_id']) 
								)
							);
	
	
		$P_V['WHERE_FILTER'].=  @$D_SERIES['key_filter'];	
	
		$P_V['WHERE_FILTER'].=$WHERE_FILTER[0];						
		
		$SORT_FIELD = array();
		 
		if(@$D_SERIES['gx']==0){
			       
				$no_s 		=  count(@$D_SERIES['sort_field']);
				 
				$s_count	=  1;
					
				for($s_field_i=0;$s_field_i< $no_s;$s_field_i++){
					       
					$SORT_FIELD[$s_count]= @$D_SERIES['sort_field'][$s_field_i];
						
					$s_count++; 
				}
				
		} // end
		  
		$OREDR_DIRECTION['1']='ASC';
		
		$OREDR_DIRECTION['2']='DESC'; 
	
	//$G->cookies_expire($app_key.'s_id');
	
	/*if(@$_GET['filter_off_id']){ 
	
	#	echo '============-';
		 $P_V['f_off_data'] = explode('[C]',$_GET['filter_off_id']);
		
		 $P_V['f_off_cookies_id'] = $app_key.'_'. $P_V['f_off_data'][0].$P_V['f_off_data'][1];
		
		 $get_sort_d =  $G->get_cookies($P_V['f_off_cookies_id'].'_sort_d' ,@$_GET['sort_d'],@$_GET['sort_d'],'');
		 
		 $get_sort_f =  $G->get_cookies($P_V['f_off_cookies_id'].'_sort_f',@$_GET['sort_f'],@$_GET['sort_f'],'');
		 
		# print_r($_COOKIE);
	
	}
	
	else{
	
	
		 $get_sort_d =  $G->get_cookies($app_key.'sort_d',@$_GET['sort_d'],@$_GET['sort_d'],@$P_V['is_cokies_expire']);
		 
		 $get_sort_f =  $G->get_cookies($app_key.'sort_f',@$_GET['sort_f'],@$_GET['sort_f'],@$P_V['is_cokies_expire']);
	}*/
		
		
		
		
		 $get_sort_d =  $G->get_cookies($P_V['cokies_id'].'sort_d',@$_GET['sort_d'],@$_GET['sort_d'],@$P_V['is_cokies_expire']);
		 
		 $get_sort_f =  $G->get_cookies($P_V['cokies_id'].'sort_f',@$_GET['sort_f'],@$_GET['sort_f'],@$P_V['is_cokies_expire']);
		
		 @$sort_by =   @$D_SERIES['list_sort'][$_GET['sort_by']]['query'];
		 
		 $get_sort_by =  $G->get_cookies($P_V['cokies_id'].'sort_by',@$sort_by,@$sort_by,@$P_V['is_cokies_expire']);
		 
		 $get_sort_by_id =  $G->get_cookies($P_V['cokies_id'].'sort_by',@$_GET['sort_by'],@$_GET['sort_by'],@$P_V['is_cokies_expire']);
		
	         $P_V['order_direction']=(@$get_sort_d )?((@$get_sort_d==1)?2:1):1;	
	 
	 
	
	 
		
		
	if(@$get_sort_f){
		  	       
		  $P_V['BUILD_ORDER']=" ORDER BY ".$GX[$D_SERIES['gx']]['get_sort_field']($SORT_FIELD,$D_SERIES['data'],@$get_sort_f).
		                       ' '.$OREDR_DIRECTION[$P_V['order_direction']];
		   
		   
		   
		  //set_system_log
		   
				$param = array('user_id'=>$USER_ID,
					       
						'page_code'=>@$D_SERIES['page_code'],
						
						'action_type'=>'ORDB',
						
						'action'=>'View the '.$get_sort_f.''.$OREDR_DIRECTION[$P_V['order_direction']].' order ');
				
				$G->set_system_log($param);
		
	  }
	  
	  else{
		
		//if urrl have
		if(@$_GET['sort_by']>-1){
		    $P_V['BUILD_ORDER']= (@$sort_by)? 'ORDER BY '.$sort_by: @$D_SERIES['order_by'];	
		}
		// or cookies store data
		elseif($get_sort_by_id>-1){
		   $get_sort_by = @$D_SERIES['list_sort'][$get_sort_by]['query'];
		  
		   $P_V['BUILD_ORDER']= (@$get_sort_by)? 'ORDER BY '.$get_sort_by: @$D_SERIES['order_by'];	
		}
		// by default in no data available 
		else{
		  $P_V['BUILD_ORDER']=  @$D_SERIES['order_by'];	
		}
		
		
		 
		 //set_system_log
		     $param = array('user_id'=>$USER_ID,
				    
				   'page_code'=>$D_SERIES['page_code'],
				   
				   'action_type'=>'ORDB',
				   
				   'action'=>'View the data by descending order');
		    
		    $G->set_system_log($param);
		
		 
		 		
	}
	
	
		
	
		
		$pager_info = $G->table_no_rows(
								array(
										'table_name'   => (@$D_SERIES['table_name'])?$D_SERIES['table_name']:'',
										
										'WHERE_FILTER' => $P_V['WHERE_FILTER']
									 )
							);
							
		$nrow  = $pager_info[0];
		
		$start = $pager_info[1];
		
		$P_V['start'] = $pager_info[1];
	 
	 
	// setcookie("per_page",@$_GET['page']);
	 
	 $get_per_page =  $G->get_cookies($P_V['cokies_id'].'get_per_page',@$_GET['page'],@$_GET['page'],@$P_V['is_cokies_expire']);
	 
	
	 
		 $per_page =  (@$get_per_page)?@$get_per_page:$show_default_rows;
	  
		if(!@$D_SERIES['show_all_rows']){
		
				//todo-postgresql/mysql optimization				
				//P_V['PAGER'] = "LIMIT $start, $per_page";
				$P_V['PAGER']=$DC->db_limit($start,$per_page);
		}else{
	                        
				$P_V['PAGER'] = "";
		}
	 
		if(@$_POST['export_data']){
				
				$field_name = '';
				$col_counter = 1;
				
				if($D_SERIES['export_csv']['export_csv_data']){
							   
					foreach($D_SERIES['export_csv']['export_csv_data'] as $key=>$value){
						
					    //todo
					     $field_name.= $value['field']." as v$col_counter,";
					     //$field_name.= $key.',';
					     $col_counter++;
				         }//end each
					 
				}else{
				    foreach($D_SERIES['data'] as $key=>$value){
						
					$field_name.= $value['field']." as v$col_counter,";
					$col_counter++;
				    }//end each
				}
				
				$csv_file_name = export_data(substr($field_name,0,-1));
				
				if($csv_file_name){
					
						$P_V['message']  = "Successfully Created";
						
					
						//set_system_log
						
						$param = array('user_id'=>$USER_ID,
							       
								'page_code'=>$D_SERIES['page_code'],
								
								'action_type'=>'CCSV',
								
								'action'=>'create the csv_file');
						
						$G->set_system_log($param);
				}
		} // end of export
		
		// export label
		
		if(@$_POST['export_label']){
				
				
				$label_file_name = export_label(@$_POST['export_label_key']);
				
				if($label_file_name){
					
						$P_V['message']  = "Successfully Created";
											
						//set_system_log
						
						$param = array('user_id'=>$USER_ID,
							       
								'page_code'=>$D_SERIES['page_code'],
								
								'action_type'=>'CCSV',
								
								'action'=>'create the csv_file');
						
						$G->set_system_log($param);
				}
				
		} // end of export
		
		
	
	/***23-sep*****Checking for Header and Sno Hide**********/
		
		$P_V['get_header']=1;
		
		$P_V['get_sno']=1;
		
		if(@$D_SERIES['hide_header']==1)
		{
				$P_V['get_header'] = 0;
		}
		if(@$D_SERIES['hide_sno']==1)
		{
				$P_V['get_sno']=0;
						
		}
		
	 /***23-sep*****To Display a  action field by--->is_edit is_view flag************/
		
		$action_decision = array();
		
		$action_decision['is_edit'] = @$D_SERIES['action']['is_edit'];
					 
		$action_decision['is_view'] = @$D_SERIES['action']['is_view'];
		
		$action_decision['custom_action']=@$D_SERIES['custom_action'];
		
		$action_decision['action_type']=($action_decision['is_edit']||$action_decision['is_view']||$action_decision['custom_action'])?1:0;
		
	/********************************************************************************************/
	
	/****25--sep********To Check Table Name****************************/
		//$P_V['table_class_set']="basic";
		//
		//
		//
		//if(@$D_SERIES['hide_header']==1)
		
	/*****************************************************************************************/
		 
		#TEMPLATE:
			
		$options 	= array("filename"=>"$LIB_PATH/template/d_series.html", "debug"=>0,"loop_context_vars"=>1);
		
		
					
		$T 	 	= new Template($options);
		
		//$T->AddParam('message',@$message);
		
       /********* 23-Sep------flag to hide header and sno--------************/
		
		$T->AddParam('LIB_PATH',$LIB_PATH);
		
		$T->AddParam('PAGE_ID',$PAGE);
		
		$T->AddParam('hide_header',$P_V['get_header']);
		
		$T->AddParam('hide_pager',@$D_SERIES['hide_pager']);
		
		$T->AddParam('hide_show_all',@$D_SERIES['hide_show_all']);
		
		$T->AddParam('title',@$D_SERIES['title']);
		
		$T->AddParam('table_attr',@$D_SERIES['table_attr']);
		
		$T->Addparam('hide_sno',$P_V['get_sno']);
		
		$T->Addparam('is_action',$action_decision['action_type']);
		
		$T->AddParam('summary',get_summary());
		
		$T->AddParam('is_top_js_file',@$D_SERIES['js']['is_top']);
		
		$T->AddParam('top_js_file',@$D_SERIES['js']['top_js']);
		
		$T->AddParam('is_bottom_js_file',@$D_SERIES['js']['is_bottom']);
		
		$show_all_label = (@$D_SERIES['show_all_label'])?$D_SERIES['show_all_label']:'Show All';
		
		$T->AddParam('show_all_label',$show_all_label);
		
		if(@$_GET['filter_off_id']){				
		        $get_filter_off =  $G->get_cookies($P_V['cokies_id'].'filter_off',@$_GET['filter_off'],@$_GET['filter_off'],@$P_V['is_cokies_expire']);			
			$T->AddParam('filter_off',(@$get_filter_off)?@$get_filter_off:@$D_SERIES['filter_off']);
		}else{		        
			$filter_off= (@$D_SERIES['filter_off'])?1:0;
		        $T->AddParam('filter_off',$filter_off);			
		}
		
		//$T->AddParam('default_option_value',@$D_SERIES['default_option_value']);
		$T->AddParam('del_button',@$D_SERIES['del_permission']['able_del']);
		
		$T->AddParam('cus_bulk_action',get_custome_bulk_action());
		
		$T->AddParam('able_del',@$D_SERIES['del_permission']['able_del']);
		
		$T->AddParam(build_desk());
		
		$T->AddParam(((@$D_SERIES['add_button'])?@$D_SERIES['add_button']:[]));
		
		
		
		// 16 jun 2015
		
		$search_filter_off = (@$D_SERIES['search_filter_off'])?$D_SERIES['search_filter_off']:0;
		
		$T->AddParam('search_filter_off',$search_filter_off);
		
		if(@$D_SERIES['search']){
		    $T->AddParam(custom_build_search_text());		
		}else{
		    $T->AddParam(build_search_text());
		}		
		
		
		
		if(@$D_SERIES['is_custom_filter']){
		
			$T->AddParam(custom_filter());
		}
			
		$P_V['custom_filter'] = custom_filter();
		
		
		$T->AddParam('custom_sort_label',@$D_SERIES['set']['label']);
		$T->AddParam('custom_sort_by',custom_list_sort());
		
		if(@$_GET['sort_by']){
				
		 $T->AddParam('pre_sort_by',$_GET['sort_by']);		
		}
		
		$T->AddParam('custom_filter',$P_V['custom_filter'][0]);		
		
		//print_r( $WHERE_FILTER[1]);
		
		//$T->AddParam($WHERE_FILTER[1]);
		//$P_V['custom_filter'][1] .'----=============='.$P_V['custom_filter'][2]
		
		$T->AddParam('filter_text',$P_V['custom_filter'][1]);
		
		$T->AddParam('filter_value',$P_V['custom_filter'][2]);
		
		$T->AddParam('SORT_FIELD',@$get_sort_f);
		
		$T->AddParam('sort_by',@$get_sort_by_id);
		
		
		$T->AddParam('DIRECATION_ON_OF',"$P_V[order_direction]");   	//  sort direcation
		
		$T->AddParam('SORT_DIRECATION',@$get_sort_d);   	        //  sort direcation		
				
		$T->AddParam($WHERE_FILTER[2]);
		
		$T->AddParam('get_cus_filter',$get_cus_filter[1]);
		
		$T->AddParam('top_action',@$D_SERIES['top_action']);
		
		
	
		// for pre selct data filter off data
	
		$T->AddParam('filter_off_id',@$_GET['filter_off_id']);
		
		$T->AddParam('PAGER_OPTION',@$D_SERIES['PAGER_OPTION']);
		
		$T->AddParam('DEFAULT_ADDON',urlencode($DEFAULT_ADDON));
		
		$T->AddParam('LAYOUT',@$D_SERIES['layout']);
		
		$T->AddParam('NO_DATA',@$D_SERIES['no_data_message']);
		
		
		
		
		function get_custome_bulk_action(){
			
			global $D_SERIES;
			
			$bulk_action = @$D_SERIES['bulk_action'];
			
			$temp_result = array();
				
				if($bulk_action){
				
			
						foreach(@$bulk_action as  $key=>$value){
						
									$temp = array();
									
									$temp['is_bulk_button']  = @ $value['is_bulk_button'];
									
									$temp['button_name']  =  @$value['button_name'];
									
									$temp['js_call']  =  @$value['js_call'];
									array_push($temp_result,$temp);
							}
				
				}
				//print_r ($temp_result);
				
				if(count($temp_result)){
						
					@$D_SERIES['del_permission']['able_del']=1;	
				}
				
				
				return $temp_result;
				
		}	//custom_filter();
		
		if($nrow>5){
		
				$T->AddParam('pager', $G->pager_single_act($nrow,$per_page,$start));
				
				//set_system_log
				$param = array('user_id'=>$USER_ID,
					       
						'page_code'=>$D_SERIES['page_code'],
						
						'action_type'=>'PAGR',
						
						'action'=>'View '.$per_page.' data per page');
				
				$G->set_system_log($param);
				
		}
		
		
		$T->AddParam('CURRENT_PAGE',(($start/$per_page) + 1));
		
		
		$T->AddParam('SHOW_PAGE',$per_page);
		
		
	   $start_date =  $G->get_cookies($P_V['cokies_id'].'start_date',@$_GET['start_date'],@$_GET['start_date'],@$P_V['is_cokies_expire']);
				
	   $end_date =  $G->get_cookies($P_V['cokies_id'].'end_date',@$_GET['end_date'],@$_GET['end_date'],@$P_V['is_cokies_expire']);
	   
	  // $is_apply_date = ($start_date)
				
		$T->AddParam( array(
								'is_apply_date' => (@$start_date)?1:0,
								
								'start_date'    => (@$start_date)?$start_date:date('d-m-Y'),
								
								'end_date'	    => @$end_date?$end_date:date('d-m-Y'),
								
								'is_date_filter' => @$D_SERIES['date_filter']['is_date_filter'],
								
								'is_export_file' => @$D_SERIES['export_csv']['is_export_file'],
								
								'button_name'	 => @$D_SERIES['export_csv']['button_name'],
								
								'csv_file_name'	 => @$csv_file_name,
								
								'label_file_name'=>@$label_file_name
								
							)
					);	
					
		$T->AddParam($URL =  array( 
									'app_key' => $app_key,
									
									's_text'  => @$_GET['s_text'],
									
									'page'    =>  $per_page, //(@$_GET['page'])?$_GET['page']:$show_default_rows,
									
									'message' => @$P_V['message']
						)
					);
		
		if(@PAGE_PERM){
				
			 $MENU_OFF  = (@$D_SERIES['menu_off'])?$D_SERIES['menu_off']:'';
			 
			 $PAGE_INFO = $T->Output();
		}
		else{
				
		    $SG->check_entry(PAGE_PERM);
		}
		
		
	
	/******************************************************************************************************************/	
	 //doubt of call
	 //todo unused
	 get_filter_off_default_url();
	 
	 function get_filter_off_default_url(){
	  		
			$URL = $_GET;
			
			#print_r($URL);
			$value = '';
			
			foreach($URL as  $key=>$value){
				
				$value.= '&'.$key.'=>'.$value; 	
				
			//	echo $key.'--<br>';
			}	
			
			//echo $value;
	  }		 
	 
	 
	function custom_action($no_row){
			
		global $D_SERIES;	
			
		$C_INFO = array();
		
		if(@$D_SERIES['custom_action']){
	
				for($custom_i =0; $custom_i<count(@$D_SERIES['custom_action']); $custom_i++ ){
					
					$temp  = array();
					
					$temp['fun_name'] = 'onclick="JavaScript:'.@$D_SERIES['custom_action'][$custom_i]['fun_name'].'('.$no_row.')'.';"';	
					
					$temp['action_name'] = @$D_SERIES['custom_action'][$custom_i]['action_name'];
					
					$temp['html']        = @$D_SERIES['custom_action'][$custom_i]['html'];	
					
					$temp['row_count']  = $no_row;
					
					
					
					//$temp['html_'.$custom_i] = $D_SERIES['custom_action']['html_'.$custom_i];	
					
					array_push($C_INFO,$temp);
				}
		}
				
		return $C_INFO; 	
			
	}
			
			
			
	/******************************************************************************************************************/
	
	function custom_build_search_text(){
				
			global $D_SERIES;
				
			global $rdsql;
			
			//$search_array = search();
			$get_array='';
			
			$temp_search_label = '';
			
			for($s_key_i =0; $s_key_i<count(@$D_SERIES['search']); $s_key_i++){
			  # echo $search_array.'======'. $s_key_i.'-----------<br>';
			   
			   $title = $D_SERIES['search'][$s_key_i]['title'];
			   $get_array.=custom_search($s_key_i);
								
			   $temp_search_label.=$title.',';
			}
			
			return array('list_array'   => substr($get_array,0,-1),
					     'search_label' => substr($temp_search_label,0,-1));
				
		}
		
	
	function custom_search($s_key_i){
			
			global $D_SERIES;
				
			global $rdsql;
			
			//foreach($D_SERIES['search'] as $search_key =>$search_value){
			//$counter = 1;
			$search_array = '';
			
			
			//for($s_key_i =0; $s_key_i<count($D_SERIES['search']); $s_key_i++){
				
				#echo  count($D_SERIES['search']).'---------<br>';
				
				$field_id = $D_SERIES['search'][$s_key_i]['data']['field_id'];
				
				$field_name = $D_SERIES['search'][$s_key_i]['data']['field_name'];
				
				$table_name = $D_SERIES['search'][$s_key_i]['data']['table_name'];
				
				$title = $D_SERIES['search'][$s_key_i]['title'];
				
				$is_text = @$D_SERIES['search'][$s_key_i]['is_search_by_text']+0;
				
				$where_filter = @$D_SERIES['search'][$s_key_i]['data']['filter'];
				
				$select_sql = "SELECT DISTINCT $field_id , $field_name FROM  $table_name WHERE 1=1 $where_filter";				
				
				$exe_query = $rdsql->exec_query($select_sql,"Select data Search!");
				
				//$explode_field = explode(',',$field_name);
				
				
				
				while($get_row = $rdsql->data_fetch_array($exe_query)){
					
					$temp =(array)$get_row;
						
					$get_row_lc = (object)array_combine(array_map('strtolower', array_keys($temp)), $temp);						
					
					#modified-R	
					$search_array.='{id:\''.$get_row[0].'\',label:\''.$get_row[1].'\',category:\''.$title.'\',s_type:\''.$s_key_i.'\',is_s_text:'.$is_text.'},';
				        
					
				 }
				//$counter++;
			//}
			
			#echo  $search_array;
			return $search_array;
			
		
		}
			
			
	/******************************************************************************************************************/	

		function build_search_text(){
			
				global $D_SERIES;
				
				$get_array='';
				
				$temp_search_label = '';
				
				if(@$D_SERIES['search_text']){
				
						foreach(@$D_SERIES['search_text'] as $key=>$value){
					
								$get_array.=$value['get_search_text']['data'];
								
								$temp_search_label.=$value['get_search_text']['title'].',';
						
						}//each 
					
				}//end if
				
				return array('list_array'   => substr($get_array,0,-1),
					     'search_label' => substr($temp_search_label,0,-1));
		
		}//end of search text	
		
		
		// custom filter 
	
		function custom_filter(){
				
				 	//custom_filter
					
					global $D_SERIES;	
					
					
					
					$INFO = array();
					
					$F_TEXT = '';
					
					$F_VALUE = '';
					
					if(@$D_SERIES['custom_filter']){
					
						$custom_filter = @$D_SERIES['custom_filter'];
						
						for($c_f_i=0; $c_f_i<count($custom_filter); $c_f_i++){
							
							$temp = array();
							
							$temp['field_id']	 = @$custom_filter[$c_f_i]['field_id'];
							
							$temp['filter_option']	 = (@$custom_filter[$c_f_i]['filter_type']=='option_list')?1:0;
							
							$temp['multi_select'] 	 = (@$custom_filter[$c_f_i]['filter_type']=='multi_select')?1:0;
							
							$temp['option_value'] 	 = @$custom_filter[$c_f_i]['option_value'];
							
							$temp['search_text'] 	 = (@$custom_filter[$c_f_i]['filter_type']=='search_text')?1:0;
							
							$temp['placeholder'] 	 = @$custom_filter[$c_f_i]['placeholder'];
							
							$temp['field_name'] 	 = @$custom_filter[$c_f_i]['field_name'];
							
							$attr='';
							
							if(@$custom_filter[$c_f_i]['attr']){
									foreach(@$custom_filter[$c_f_i]['attr'] as $attr_key=> $attr_value ){
											
											$attr.=$attr_key.'='.$attr_value.' '; 
									}
							}
							
							
							$temp['html']      	 = (@$custom_filter[$c_f_i]['html'])?$custom_filter[$c_f_i]['html'] : $attr;
							
							
							$temp['cus_default_label']=(@$custom_filter[$c_f_i]['cus_default_label'])?@$custom_filter[$c_f_i]['cus_default_label']:'Select';
							
							$temp['no_default_option']= @$custom_filter[$c_f_i]['no_default_option'];
							
							
							$F_TEXT.=@$custom_filter[$c_f_i]['field_id'].',';
							
							$field_name=@$custom_filter[$c_f_i]['field_id'];
							
							if($temp['multi_select']){
							  $multi_value = $field_name.'_hidden';
							  $F_VALUE.=  "document.getElementById('$multi_value'),";
							}
							else{
							  $F_VALUE.= "document.getElementById('$field_name'),";		  		
							}
							
							
							array_push($INFO,$temp);	
						}
					
					
					} // end
					
					$F_TEXT = substr($F_TEXT,0,-1);
					
					$F_VALUE = substr($F_VALUE,0,-1);
					
					return array($INFO,$F_TEXT,$F_VALUE);
				
		}//end of custom filter
		
		//custom sort by(){
		function custom_list_sort(){
				
				global $D_SERIES;
				
				unset($D_SERIES['list_sort']['set']);
				
				
				
				
				//print_r($D_SERIES['list_sort']);
				
				//echo $D_SERIES['list_sort'][1]['name'];
				$INFO = array();
				
				if(@$D_SERIES['list_sort']){
				
						$custom_sort_by = @$D_SERIES['list_sort'];
						
						for($c_f_i=1; $c_f_i<=count($custom_sort_by); $c_f_i++){
							
							$temp = array();
							//echo  $D_SERIES['list_sort'][$c_f_i]['name'].'------<br>';
							$temp['text_option'] = $D_SERIES['list_sort'][$c_f_i]['name'];
							
							//$temp['query'] = $D_SERIES['list_sort'][$c_f_i]['query'];
							
							$temp['sort_value'] =  $c_f_i;
							
							//echo $D_SERIES['list_sort'][$c_f_i]['name'].'----<br>';
							array_push($INFO,$temp);
						}
				} // end
				
				return $INFO;
					
		}
		
		
		function export_data($field_name){
				
				global $D_SERIES;
				 
				global $P_V; 
				
				global $G;
				
				global $rdsql;
				
				$WHERE_FILTER = ($P_V['WHERE_FILTER'])?$P_V['WHERE_FILTER']:'';
				
				$BUILD_ORDER  = ($P_V['BUILD_ORDER'])?$P_V['BUILD_ORDER']:'';
				
				 
				
				$count = (@$D_SERIES['export_csv']['export_csv_data'])?count(@$D_SERIES['export_csv']['export_csv_data']):count($D_SERIES['data']);
				
				//
				$csv_heading='';
				
				$P_V['csv_data'] = '';
				
				$csv_function = array();
				
				$head_counter  = 0;
				
				if($D_SERIES['export_csv']['export_csv_data']){
							   
				
						foreach(@$D_SERIES['export_csv']['export_csv_data'] as $key=>$value){
						
								$head_counter++;
								
								$csv_heading.=$value['th'].'::';						
								
								
								if(@$value['fun']){						
										$csv_function[$head_counter]['fun'] = @$value['fun'];
										$csv_function[$head_counter]['opt'] = (@$value['opt'])?@$value['opt']:'';						
								}else{
										$csv_function[$head_counter]['fun'] = '';						
										$csv_function[$head_counter]['opt'] = '';
								}// end
						}
						
				}else{
						foreach($D_SERIES['data'] as $key=>$value){
							    
								$csv_heading.=$value['th'].'::';
						}//end each
				}
				
				
				
				$P_V['csv_data']='S.No ::'.substr($csv_heading,0,-2).'[R]';
				
				
				// select data
				$SELECT   = "SELECT $D_SERIES[key_id] as key_id, $field_name FROM $D_SERIES[table_name]  WHERE 1=1 $WHERE_FILTER $BUILD_ORDER ";
					
				$ex_query = $rdsql->exec_query($SELECT,"CSV Error!");
				
				$csv_data_index = 1;
				 
				while($get_row = $rdsql->data_fetch_object($ex_query)){
						
				
					$P_V['csv_data'].= $P_V['start']+$csv_data_index.'::';
					
					$data = '';
					
					for($d_i = 1; $d_i<= $count; $d_i++){
						
						$alias  = 'v'.$d_i;
						
						// if fun exists						
						if(@$csv_function[$d_i]['fun']){
								
						   $data.=$csv_function[$d_i]['fun']($get_row->$alias,@$csv_function[$d_i]['opt']).'::';
						   
						}else{
								
						   $data.=$get_row->$alias.'::';
						   
						}
						
					} // each row
										
					$P_V['csv_data'].=$data;					
					$P_V['csv_data'].='[R]';					
					$csv_data_index+=1;
					
				} // end
				
				
				
				
				$csv_file_name = $D_SERIES['export_csv']['csv_file_name'];
				
				$P_V['csv_file_name'] = $G->set_csv_data(
											$def=array(	
							 
											  'csv_data' => $P_V['csv_data'],
											
											   'file_name' =>  $csv_file_name // '../csv/alaram_'.time().'.csv'
											)
							);
					
				return $P_V['csv_file_name'];		
							
							
		}//end of csv
		
		// export label
		
		function export_label($key){
				
				global $D_SERIES;
				 
				global $P_V; 
				
				global $G;
				
				global $rdsql;
				
				$WHERE_FILTER = ($P_V['WHERE_FILTER'])?$P_V['WHERE_FILTER']:'';
				
				$field=$D_SERIES['export_label'][$key]['field'];
				
				$default_template = $D_SERIES['export_label'][$key]['style']; //html file name
				
				$file_name = $D_SERIES['export_label'][$key]['file_name'];
				
				$per_page =$D_SERIES['export_label'][$key]['per_page_data'];
				
				// select data
				$SELECT= "SELECT $field FROM $D_SERIES[table_name]  WHERE 1=1 $WHERE_FILTER ";
				
				$SELECT_QUERY_EXEC = $rdsql->exec_query($SELECT,"Error in label creation");
				
				$LABEL_INFO = array();
				
				$label_counter = 1;
				
				
			        while($get_row = $rdsql->data_fetch_assoc($SELECT_QUERY_EXEC)){
						
						$get_row['is_page_break']=($label_counter%$per_page==0)?1:0;
						
				           array_push($LABEL_INFO,$get_row);
					   
				$label_counter++;
					   
				}//end while
				
				
				$label_options 	= array("filename"=>"template/".$default_template.".html", "debug"=>0,"loop_context_vars"=>1);
		
		                 $L	 	= new Template($label_options);
				 
				 $L->AddParam('LABEL_INFO',$LABEL_INFO);
				 
				 $label_output = $L->Output();
				 
				 $label_file_name = $G->set_html_file($label_output,$file_name);
				 
				 return $label_file_name;			
				
				 
				 //return $label_output;
				
		} // export label
		
		
		
		function build_desk(){
		
				global $D_SERIES,$DB_ENGINE;	
				
				$data      = $D_SERIES['data'];
				
				$temp_info = array();
				
				$temp_field = array();
								
				//dynamic alias name for field
		
				$alias_variable=$D_SERIES['CONST']['alias_var'];
				
				foreach($data as $key=>$value){
				
						$temp = array();
						
						$temp['th'] =  @$value['th'];
						
						$temp['html'] = @$value['html'];
						
						$temp['font'] = @$value['font'];
						
						$temp['span'] = @$value['span'];
						
						$temp['th_attr'] = @$value['th_attr'];
						
						$temp['is_sort'] = @$value['is_sort'];
						
						$temp['sort_id'] = @$key;
						
						//$temp['js_call'] =@$value['js_call'];
						
						if($temp['th']){						
								array_push($temp_info,$temp);
						}
						
				}
				// select data from table	
				$field_name='';
				
				
				
				if($D_SERIES['gx']==1){
						
						foreach($data as $key=>$value){
								
								$value['field']=(@$value['field_composite'])?build_field_composite(['field_composite' => @$value['field_composite'],
																    'db_engine'       => $DB_ENGINE
																    ]):$value['field'];
							
								#echo "<br>".$value['field_temp']."<br>";
							
								$field_name.= $value['field'].' as '.$alias_variable.$key.',';
								
								$temp_field[$key] = $value['field'];
						}
						
						if($field_name && @$D_SERIES['prime_index'] && @$D_SERIES['del_permission']['able_del']){
						
								$field_name.= $temp_field[$D_SERIES['prime_index']].' as prime_label,';		
						}
				}
				else{
						
						foreach($data as $key=>$value){
						
								$field_name.= $value['field'].',';
								
								$temp_field[$key] = $value['field'];
						}
				}
				
				$field_name = substr($field_name,0,-1);
				
				
				
				 
				return array(
							 'TH_INFO'	  => $temp_info,
							 
							 'DATA_INFO'  =>get_data($field_name),
							 
						);
		                
							
						
		}//end of build desk
		
		
		
		
		function get_data($field_name){
					
				 global $D_SERIES;
				 
				 global $P_V;
				 
				 global $rdsql;
				 
				 global $PAGE_ID;
				 
				 global $DEFAULT_ADDON;
				  
				  
				 $WHERE_FILTER = ($P_V['WHERE_FILTER'])?$P_V['WHERE_FILTER']:'';
				
				 $hidden_value ='';	
				 
				 $h_counter = 1;
				 
				$key_id = '';
				 
				 				 
				if(@$D_SERIES['key_id']){				  
				   $key_id="$D_SERIES[key_id] as key_id,"; 
				}
				 
				if(@$D_SERIES['hidden_data']){				 
						
						foreach(@$D_SERIES['hidden_data'] as $key=>$value){
									       
								$hidden_value.=$value.',';									
								$h_counter++;
						}
						
				}	
				
				
				 $del_field = '';
				  if(@$D_SERIES['del_permission']['avoid_del_field']){	
				      $del_field = $D_SERIES['del_permission']['avoid_del_field'].' as avoid_del_field,';
				  }
				  
				  
							 
				# echo $hidden_value;
				// select data
			 	
				  $SELECT = "SELECT $key_id $hidden_value  $del_field $field_name  ";
					
			           if(@$D_SERIES['table_name']){
					$SELECT.=" FROM $D_SERIES[table_name]  WHERE 1=1 $WHERE_FILTER   $P_V[BUILD_ORDER] $P_V[PAGER]";							
				   } // end
				 
				  if(@$D_SERIES['show_query']){
						
					echo $SELECT;
				  }	
				  
				
				  $ex_query = $rdsql->exec_query($SELECT,"Field does not matching!");
				  
				  $data_info = array(); 
				  
				  $counter=1;
				  
				  $count=count($D_SERIES['data'])+3;
				  
				//$script_function=($D_SERIES['view']);


				while($get_row = $rdsql->data_fetch_object($ex_query)){
										  
				  	 $temp_data = array();
					 
					 $TEMP_INFO = array();
					 
				
					 foreach($D_SERIES['data'] as $key => $value){
						
						
						$alias  = 'v'.$key;
						 
						$temp = array();
						 
						$temp['VALUE']       = $get_row->$alias;
						
						$temp['row_counter'] =  $counter;
						
						$td_attr='';
						
						if(@$D_SERIES['data'][$key]['attr']){
								
								foreach(@$D_SERIES['data'][$key]['attr'] as $attr_key=> $attr_value ){
										
										$td_attr.="  ".$attr_key.'="'.$attr_value.'"'; 
								}
						}
						
						$temp['TD_ATTR']     = ($td_attr)?$td_attr:@$D_SERIES['data'][$key]['td_attr'];
						
						$temp['JS_CALL']     = @$D_SERIES['data'][$key]['js_call'];
						
						$temp['is_js']       = ($temp['JS_CALL'])?1:0;
						
						$temp['IS_HIDE']     = @$D_SERIES['data'][$key]['is_hide'];
						
						if(@$D_SERIES['data'][$key]['filter_out']){
						 
						   $temp['VALUE']       = @$D_SERIES['data'][$key]['filter_out']($temp['VALUE']);
						}
						
					       
						array_push($TEMP_INFO,$temp);  
						
						$h_c = 'h'.$key;												
					 }
					 
				   //16 May 2015: (for colspan)
				   
					 // custom_row_action
					 // if flag existis
					 
					 $row_info=array();
					 
					 if(@$D_SERIES['is_custom_row_action']){
						
						$TEMP_INFO = custom_row_action($TEMP_INFO);
						
					 }//end
					 
					 
					 $hidden_v = array();
					 
					 if(@$D_SERIES['hidden_data']){
					 
						 foreach(@$D_SERIES['hidden_data'] as $key=>$value){
						 
									$temp_h = array();
									
									$temp_h['h_value'] = $get_row->$value;
									
									$temp_h['row_counter'] =  $counter;
									
									array_push($hidden_v,$temp_h);			
						 }
					}					 
					  
								 
					 $temp_data+=@$D_SERIES['action'];
					 
					 $temp_data['page_f_series']  =  $P_V['f_series'][$PAGE_ID];
					 $temp_data['is_narrow_down'] = @$D_SERIES['is_narrow_down'];
					 					 
					 $temp_data['action_th_attr'] = (@$D_SERIES['action']['action_th_attr'])?@$D_SERIES['action']['action_th_attr']:'width="5%"';
					 					 
					 $temp_data['app_key'] = $P_V['app_key'];
					 
					 $temp_data['key_id'] =  (@$D_SERIES['key_id'])?$get_row->key_id:'';
					  
					 $temp_data['COL_RESULT'] =  $TEMP_INFO;					 
					 
					 @$temp_data['del_name'] =  $get_row->prime_label;
					 
					 $temp_data['col_count']=$count;
					 
					 $temp_data['able_del'] = $D_SERIES['del_permission']['able_del'];
					 
					 if(@$D_SERIES['del_permission']['avoid_del_field']){
						
						$del_value = @$D_SERIES['del_permission']['avoid_del_value'];
					
						$temp_data['is_row_able_del'] = ($get_row->avoid_del_field == "$del_value")?1:0;
					 }
					 
					 $temp_data['custom_action'] = custom_action($counter);
				
					 $temp_data['action_type']   =(@$temp_data['is_edit']||@$temp_data['is_view']||@$temp_data['is_add_more_info']||@$temp_data['custom_action'])?1:0;
					 					
					 $temp_data['hidden_data'] = $hidden_v;
					 
					 $temp_data['hide_sno']=(@$D_SERIES['hide_sno'])?0:1;
					 
					 
					 $temp_data['default_addon'] = urlencode($DEFAULT_ADDON);
					 
					 $counter++; 
					 
					 array_push($data_info,$temp_data);
						  
				}	
				return $data_info; 					
						
		}//end of get data
		
	/******************************************************************************************************************/	
		//build custom filter
		/* function custom_filter(){
		 			
				 global $D_SERIES;	
				 
				 print_r($D_SERIES['custom_filter']);	 	
		 
		 }*/
	/******************************************************************************************************************/	
		
		
		
		function where_filter($def){
		
				global $P_V;
				
				global $D_SERIES;
				
				global $G;
				
				$WHERE='';
				
				$KEY_VALUE = array(); 	
				
				$URL = array();
				
				if($def['check_field']){
				
					$filter_keys = array_keys($def['check_field']);
					
					$filter_values = array_values($def['check_field']);
	
				
					for($key_i=0; $key_i<count($filter_keys); $key_i++){
							
							$filter_value = ($filter_values[$key_i])?$filter_values[$key_i]:@$_COOKIE[$filter_keys[$key_i].'_cookies'];
								
							if($filter_value){
								
								$WHERE.= ' AND '.$filter_keys[$key_i].'='.$filter_value; 
								
								$temp = array(); 
								
								$temp[$filter_keys[$key_i]] = $filter_value;
								
								array_push($KEY_VALUE,$temp);	
							}	
					}
				}				
				
			//filter by user	
			if(@$P_V['is_user_base_query']){
			
				if(@$P_V['SUPER_ADMIN']){
						
						$WHERE.= '';
						
		     //set_system_log
					$param = array('user_id'=>$USER_ID,
						       
						       'page_code'=>$D_SERIES['page_code'],
						       
						       'action_type'=>'VADM',
						       
						       'action'=>'View the user detail');
					
				       $G->set_system_log($param);
				
				
				     
				}
				
				else{
					$WHERE.=' AND user_id = '.$P_V['user_id'];
					
					
					//set_system_log
					
					$param = array('user_id'=>$USER_ID,
						       
						       'page_code'=>$D_SERIES['page_code'],
						       
						       'action_type'=>'VUSR',
						       
						       'action'=>'View the user detail');
					
				       $G->set_system_log($param);
				
					
				}
				
			}	
						 
				$search_text = (@$_GET['s_text'])?@$_GET['s_text']:@$_COOKIE['search_text']; 
				
				if(@$P_V['SEARCH']){
					
						
						 $WHERE.= $P_V['SEARCH'];
						 
						/* setcookie('s_text',@$_GET['s_text']);
						 
						 $s_text = (@$_GET['s_text'])?@$_GET['s_text']:@$_COOKIE['s_text'];
						 
						 setcookie('s_id',@$_GET['s_id']);
						 
						 $s_id = (@$_GET['s_id'])?@$_GET['s_id']:@$_COOKIE['s_id'];
						 
						 setcookie('s_type',@$_GET['s_type']);
						 
						 $s_type = (@$_GET['s_type'])?@$_GET['s_type']:@$_COOKIE['s_type'];
						 
						 setcookie('is_s_text',@$_GET['s_text_type']);
						 
						 $is_s_text = (@$_GET['s_text_type'])?@$_GET['s_text_type']:@$_COOKIE['s_type'];
						 */
						 //$P_V['s_id'] $P_V['s_type']$P_V['s_text_type']$P_V['s_text']
						 
						 //$s_text  = ($_GET['s_text'])
						 
						/* array_push($KEY_VALUE, array('s_text' => $_GET['s_text'],'s_id'=>$_GET['s_id'],'s_type'=>$_GET['s_type']));
						
						 $URL =  array('s_text' => $_GET['s_text'],'s_id'=>$_GET['s_id'],'s_type'=>$_GET['s_type'],'is_s_text'=>$_GET['s_text_type']);*/
						 
						// echo $P_V['s_text'];
						 array_push($KEY_VALUE, array('s_text' => $P_V['s_text'],'s_id'=>$P_V['s_id'] ,'s_type'=>$P_V['s_type']));
						
						 $URL =  array('s_text_data' =>$P_V['s_text'],'s_id_data'=>$P_V['s_id'],'s_type_data'=>$P_V['s_type'],'is_s_text_data'=>$P_V['s_text_type']);
						
						#print_r($URL);	
				}
			
			
			   	$start_date =  $G->get_cookies($P_V['cokies_id'].'start_date',@$_GET['start_date'],@$_GET['start_date'],@$P_V['is_cokies_expire']);
				
				$end_date =  $G->get_cookies($P_V['cokies_id'].'end_date',@$_GET['end_date'],@$_GET['end_date'],@$P_V['is_cokies_expire']);
				
				//20-aug-2014(alt_date):
				
				$start_alt_date =  $G->get_cookies($P_V['cokies_id'].'start_date',@$_GET['start_alt_date'],@$_GET['start_alt_date'],@$P_V['is_cokies_expire']);
				
				$end_alt_date =  $G->get_cookies($P_V['cokies_id'].'end_date',@$_GET['end_alt_date'],@$_GET['end_alt_date'],@$P_V['is_cokies_expire']);
				//
				
			  //  setcookie('start_date',$start_date);
				
				//$start_date = (@$_GET['start_date'])?@$_GET['start_date']:@$_COOKIE['start_date']; 
				
				
				//setcookie('end_date',@$_GET['end_date']);
				
				//$end_date = (@$_GET['end_date'])?@$_GET['end_date']:@$_COOKIE['end_date']; 
				
				
				if($start_alt_date && $end_alt_date){
				
					//echo $WHERE.=" AND date_format(".$D_SERIES['date_filter']['date_field'].",'%Y-%m-%d') BETWEEN '$start_date'  and '$end_date' ";
					
					//20-aug-14
					
					//19 june 2015
					
					if(@$D_SERIES['date_filter']['date_field']){
					       $WHERE.=" AND date_format(".$D_SERIES['date_filter']['date_field'].",'%Y-%m-%d') BETWEEN '$start_alt_date'  and '$end_alt_date' ";	
					}else{
						$WHERE='';
					}//
				}
		return  array($WHERE,$KEY_VALUE,$URL );
		
		}//end of where filter
		
		//todo manipulation param additional to v2
		function get_search_array($table_name,
					  $field_name,
					  $s_text,
					  $s_type,
					  $is_s_text,
					  $manipulation){
				
				global $D_SERIES;
				
				global $rdsql;
					
				$select_sql = "SELECT DISTINCT $field_name FROM $table_name $manipulation";
				
				$exe_query = $rdsql->exec_query($select_sql,"Select data Search!");
		
				$search_array = '';
				
				
				
				while($get_row = $rdsql->data_fetch_object($exe_query)){
						
				     //26-Aug-2014
						
						//get_row-> object change to lowercase
						
						$temp =(array)$get_row;
						
						$get_row_lc = (object)array_combine(array_map('strtolower', array_keys($temp)), $temp);
						
						/*if($get_row->ST2){
								
						          
							//$search_array.='{id:\''.$get_row->ST1.'\',label:\''.$s_text.':'.$get_row->ST2.'\',s_type:'.$s_type.'},';
							
							
							
						 $search_array.='{id:\''.$get_row->ST1.'\',label:\''.$get_row->ST2.'\',category:\''.$s_text.'\',s_type:'.$s_type.'},';
						
							
						}	*/
						
						if(@$get_row_lc->st1){
								
						          
							//$search_array.='{id:\''.$get_row->ST1.'\',label:\''.$s_text.':'.$get_row->ST2.'\',s_type:'.$s_type.'},';
							
							
							
						 $search_array.='{id:\''.$get_row_lc->st1.'\',label:\''.$get_row_lc->st2.'\',category:\''.$s_text.'\',s_type:\''.$s_type.'\',is_s_text:'.@$is_s_text.'},';
						
							
						}
				}
				
				$P_V['search_array'] = $search_array;
				
				return array('data'=>$P_V['search_array'],'title'=>$s_text);
				
				
		}//end of search
			
			
	/*************************************************************************************************/		
		function get_cus_filter(){
			
			global $D_SERIES;
			
			global $G;
			
			global $P_V;
			
			
			 $WHERE_FILTER='';
			 
			 $PREE_DATA = '';
			 
			 if(@$D_SERIES['custom_filter']){
			
				for($c_f_i= 0; $c_f_i<count(@$D_SERIES['custom_filter']); $c_f_i++){
					       
					       $P_V['filter_by'] = @$D_SERIES['custom_filter'][$c_f_i]['filter_by'];
					       
					       $P_V['field_id']  = @$D_SERIES['custom_filter'][$c_f_i]['field_id']; //$_GET['dsr_select'];
					       
					       $P_V['default_option'] = @$D_SERIES['custom_filter'][$c_f_i]['default_option'];
					       
					       
					       
					       $temp =  $P_V['filter_by'];
					       
					       $get_value='';
					       
					       //setcookie("bgColor",$newbgColor,time()+3600);
					       //setcookie("txtColor",$newtxtColor,time()+3600);
						if(@$P_V['field_id']){
				       
						       $get_value =  $G->get_cookies($P_V['cokies_id'].'get_field_id'.$c_f_i,@$_GET[$P_V['field_id']],@$_GET[$P_V['field_id']],@$P_V['is_cokies_expire']);
						       
						       
					       } // end
					       
						
					       if(@$D_SERIES['custom_filter'][$c_f_i]['filter_type'] == 'option_list'){
						       
						       #echo $get_value.'------------<br>';	
						       if($get_value > -1){
									       
							       //	echo
							       
								       if(@$D_SERIES['custom_filter'][$c_f_i]['is_number_match']){							
										       $WHERE_FILTER.= ' AND '. $P_V['filter_by'].'=' ."$get_value";
										       $PREE_DATA.= "E_V_PASS('$P_V[field_id]',$get_value);";
										       
								       }else if(@$D_SERIES['custom_filter'][$c_f_i]['is_one_to_many']){
										       
										       $WHERE_FILTER.= " AND  $get_value  IN($P_V[filter_by])";
										       $PREE_DATA.= "E_V_PASS('$P_V[field_id]',$get_value);";
										       
										       
								       }else{
										       $WHERE_FILTER.= ' AND '. $P_V['filter_by'].'=' ."'$get_value'";
										       $PREE_DATA.= "E_V_PASS('$P_V[field_id]','$get_value');";
								       }
								  
								       
								  
								  
						       }elseif($get_value == -1){
						       
							      $PREE_DATA.= "E_V_PASS('$P_V[field_id]','$get_value');";
								       
							
						       }else{
							       
								       $WHERE_FILTER.=$P_V['default_option']? 'AND '.$P_V['filter_by'].'=\''.$P_V['default_option'].'\'':'';
								       
								       $PREE_DATA.=$P_V['default_option']? "E_V_PASS('$P_V[field_id]','$P_V[default_option]');":'';
						       
						       }
						       
					       }
					       
					       if(@$D_SERIES['custom_filter'][$c_f_i]['filter_type'] == 'multi_select'){
							$hidden_field = $P_V['field_id'].'_hidden' ;
							
							//echo $get_value.'====='.$hidden_field.'------<br>';
						       if($get_value > -1){
							 $WHERE_FILTER.= ' AND '. $P_V['filter_by'].' IN('."$get_value)";
							 //$PREE_DATA.= " $('#$P_V[field_id]').multiselect('select', [$get_value]);";
							 
							 $PREE_DATA.= "$('#$P_V[field_id]').selectpicker('val',[$get_value]);";
							 
							 $PREE_DATA.= "E_V_PASS('$hidden_field','$get_value');";
						       }
						       elseif($get_value == -1){
							   $PREE_DATA.= "E_V_PASS('$hidden_field','$get_value');";		
						       }						
						       else{
							   $WHERE_FILTER.=$P_V['default_option']? 'AND '.$P_V['filter_by'].'=\''.$P_V['default_option'].'\'':'';
								       
							   $PREE_DATA.=$P_V['default_option']? "E_V_PASS('$hidden_field','$P_V[default_option]');":'';		
								       
						       }
						       
						       
					       }
					       
					       if(@$D_SERIES['custom_filter'][$c_f_i]['filter_type'] == 'search_text'){
							       
							       if($get_value){
							       
									$WHERE_FILTER.= " AND  $P_V[filter_by] LIKE '%$get_value%'";	
									
									$PREE_DATA.= "E_V_PASS('$P_V[field_id]','$get_value');";
							       } 
					       
					       }
					       
					}
					
			 } // end count
				 
			#	echo  $PREE_DATA; 
				 
			return array($WHERE_FILTER,$PREE_DATA) ; 
	  } // end count	 
	/*************************************************************************************************/		
	
	
	/*************************************************************************************************/		
	
	
	function get_summary(){
	
			global $D_SERIES;
			
			global $P_V;
			
			global $rdsql;
			
			$INFO = array();
			
			if(@$D_SERIES['summary_data']){
			
				for($summary_i =0; $summary_i<count(@$D_SERIES['summary_data']);  $summary_i++){
					
					$temp = array();
					
					$field_name =  @$D_SERIES['summary_data'][$summary_i]['field'];
					$manipulation = @$D_SERIES['summary_data'][$summary_i]['manipulation'];
					
					$select = "SELECT  $field_name as summary_data FROM $D_SERIES[table_name] WHERE 1=1  $P_V[WHERE_FILTER] $manipulation ";
				
					$exe_select				= $rdsql->exec_query($select,"Error!summary");
						
					$get_row 				= $rdsql->data_fetch_object($exe_select);
					
					$temp['field_name'] 	=  @$D_SERIES['summary_data'][$summary_i]['name'];
					
					$temp['summary_value'] =  (@$get_row->summary_data)?$get_row->summary_data:0;
					
					$temp['html']	       = @$D_SERIES['summary_data'][$summary_i]['html'];
						
					array_push($INFO,$temp);	
					
				}
			} //
			return $INFO;
	  }
	  
	  
	  //todo unused 
	  function custome_sort(){
		  
		global $D_SERIES;
		global $rdsql;
		
		echo $D_SERIES['custome_sort'];
	  }
		  
		// str to arr
		
		function get_str_to_arr_info($str,$options){
	     
		     $result = array();
		     
		     $arr    = json_decode($str);
		     
		     $slice  = $options['slice'];
		     
		     $glue   = ($options['glue'])?$options['glue']:',';
		     
		     foreach($arr as $key=>&$value){
			 
			     $count  = count($arr[$key]);
			     
			 
			     if($count>0){
				 
				 $temp = $arr[$key];
				 
				 $is_must_pass = 1;
				 
				 $column_data  = '';
				 
				 foreach($slice as $d_key=>$d_value){
				  
					 if( ((@$slice[$d_key]['is_must']) && (@$temp[$d_key]) ) ||
					      (!@$slice[$d_key]['is_must'])){
					 
					     $column_data.=@$slice[$d_key]['pfx'].$temp[$d_key].@$slice[$d_key]['sfx'];
					 
					 }elseif((@$slice[$d_key]['is_must']) && (!@$temp[$d_key])){
					     
					     $is_must_pass = 0;
					     
					 }// if
					 
				 } // end
				 
				 if($is_must_pass){
				     
				     array_push($result,$column_data);
				     
				 } // end
				 
			     } // if array has data
			     
		     } // each row
		     
		     // result
			 
		     return (count($result)>0)?join($glue,$result):'';
		     
		} // end of func
               
	       
	        # page router
	        
		function action_router($p){
				
				
				
				$temp = array(
						
						'd_series'=>function($p){
								
							$temp_path = "inc/data/".$p['page_id']."/".$p['page_name'].".php";	
							
							if(is_file($temp_path)){								
							     return array('action'=>$temp_path);
							}else{								
							     return array('action'=>false);
							} // end
							
						}, // end
						
						
						'd'=>function($p){
								
						        $p['page_name']=str_replace('__','/',$p['page_name']);
								
						        $temp_path = $p['lib_path']."/def/".$p['page_name']."/".$p['page_id'].".php";
							
							if(is_file($temp_path)){
							     return array('action'=>$temp_path);						
							}else{								
							     return array('action'=>false);
							} // end
							
						}, // end
						
						'dx'=>function($p){
								
						        $p['page_name']=str_replace('__','/',$p['page_name']);
								
							$temp_path = "def/".$p['page_name']."/".$p['page_id'].".php";
							
							if(is_file($temp_path)){
							     return array('action'=>$temp_path);						
							}else{								
							     return array('action'=>false);
							} // end
							
						} // end
						
				);
				
				return $temp[$p['page_id']]($p); 
				
				
				
		} // end
		
		
		// 
		function build_field_composite($param){
				
				$lv = array();
				
				//Data Requirement
				//c3001.graphBase('{["x","Total","Total 20"],["2018-09-18",13,33],["2018-09-20",6,26]}');
				
				//Data Skelton Manual
				//concat('{','[\"x\",\"Total\",\"Total_20\"],',GROUP_CONCAT('[\"',date,'\",',total,',',(total+20),']'),'}')
				
				
				$lv['action']['rdsql_mysqli'] = function($param){
				
						$lv['header'] = implode("\"',',','\"",array_keys($param['field_composite']['fields']));
						
						$lv['first_field'] = array_shift($param['field_composite']['fields']);
						
						$lv['value_fields'] = implode(',\',\',',array_values($param['field_composite']['fields']));	
						
						$lv['query_field'] = " concat('{','[','".'"'."$lv[header]".'"'."','],',GROUP_CONCAT('[\"',$lv[first_field],'\",',$lv[value_fields],']'),'}')";
						
						$lv['filter'] = (@$param['field_composite']['filter'])? " AND ".$param['field_composite']['filter']:'';
						
						$lv['order']  = (@$param['field_composite']['order'])? " ORDER BY ".$param['field_composite']['order']:'';						
							
						$lv['query']       = "( SELECT $lv[query_field] FROM  ".$param['field_composite']['table']." WHERE 1=1 $lv[filter] $lv[order] )";
							
						return $lv['query'];
				};
				
				return ($lv['action'][$param['db_engine']])?$lv['action'][$param['db_engine']]($param):'';
				
		}
		
		// function mode run
		
		function set_mode($d_series){
				
				
				$lv = array();
				
				$lv['action']['graph'] = function($d_series){
						
						$d_series['is_graph']   	=1;
                                    
						$d_series['hide_header']	=1;
				    
						$d_series['hide_sno']		=1;
						
						$d_series['hide_pager']		=1;
						
						$d_series['filter_off']		=1;
						
						$d_series['search_filter_off']	=1;
						
						$d_series['layout']	        ='dashboard';
						
						$d_series['table_attr']         ='class="div_of_div panel col-md-12 " ';
						
						return $d_series;
				};
				
				return (@$lv['action'][$d_series['mode']])?$lv['action'][$d_series['mode']]($d_series):$d_series;
		}
       
    
       // $path = ('../../ws/step/vx/inc/export');
	
	//$menu_path = ('../../ws/step/vx/inc/export/left_menu');
    
////////////////////////////////////////////////////////////////////////
// 11-May-2015 added hide_pager & show_all_rows variable
// 03-Jul-2015 addition of export CSV in a customized option ( addition of fun,opt in defnation)
// 03-Jul-2015
// 18-Jul-2015 if d_series table not there left the right part of query
// 09-Sep-2015 menu_off variable added
// 11-Sep-2015 Clear history added
////////////////////////////////////////////////////////////////////////

		
		
?>