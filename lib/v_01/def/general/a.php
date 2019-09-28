<?PHP

												$A_SERIES       =   array(
		
					
						# Delete Image
					
						'DELI'=>function($param){					
												
								
									$inline_param     = json_decode($param['data'],true);
									
									$pass_id 	  = $param['pass_id'];
									
									$key     	  = $param['G']->decrypt($inline_param['data_III'],$pass_id);
									
									$key_id  	  = $param['G']->decrypt($inline_param['data_V'],$pass_id);
									
									$filter_data	  = "$key_id=".$key ;
									
									if( (@$inline_param['data_VI']) &&
									    (@$inline_param['data_VII'])){
										
										$child_field   = $param['G']->decrypt($inline_param['data_VI'],$pass_id);
										
										$child_code    = $param['G']->decrypt($inline_param['data_VII'],$pass_id);
										
										$filter_data.= " AND $child_field='$child_code'";
									}
									
									if(@$key){ 
							
										$table     	= $param['G']->decrypt($inline_param['data_I'],$pass_id);
										
										$field     	= $param['G']->decrypt($inline_param['data_II'],$pass_id);
										
										/*echo "SELECT $field
													FROM $table where 1=1 AND $filter_data "*/;
																			
										$exe_query 	= $param['rdsql']->exec_query("SELECT $field as image
																FROM $table where 1=1 AND $filter_data ",'====');
										
										$get_row   = $param['rdsql']->data_fetch_object($exe_query);
										
										// update field empty
										
										$exe_query = $param['rdsql']->exec_query("UPDATE  $table
															SET  $field = ''
															  where 1=1 AND $filter_data ",'====');
										$image 	   = $get_row->image;
										
										$explode_img = explode(',',$image);
										
										foreach($explode_img as $img_key=>$img_value){
											
											if(is_file($img_value)){
												unlink($img_value);			
											}
										}	
										
										return  preg_replace('/\s\s+/', ' ',$param['G']->decrypt($inline_param['data_IV'],$pass_id));
										
									}else{
										
										return 0;			
									}
						
						
						} // end
         

                            );
	
	
	
	
?>