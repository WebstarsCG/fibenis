<?php

  

		function upload($param){
				
			#print_r($param);
		  
			$file_name=$_FILES[$param['image_name']]['name'];				// store file
			
			$file_source=$_FILES[$param['image_name']]['tmp_name'];		// temp location of file	
			
			$file_location = $param['location'].$param['key_id'];  //$location.$img_id.'_'.$file_name;
			
			$allowedExts = array("gif", "jpeg", "jpg", "png");
				
			$temp = explode(".", $_FILES[$param['image_name']]["name"]);
			
			$extension = end($temp);
			
			if(@$param['data_def']['image_size_auto']){
				
				return  upload_size_img($param);
			}
			
			elseif(@$param['upload_type'] == 'image'){
				return  upload_img($param);
			}
			
			//image_size_auto
			
			else{
				return upload_doc($param);	
			}					
			 
		}
		
		
	   
	   
	   function upload_doc($param){
				
			$name = $param['image_name'];
			
			$location = $param['location'];
			
			$save_img = ($param['img_name'])?$param['img_name']:md5($param['key_id']);
			
			$file_name=$_FILES[$name]['name'];				// store file
			
			$file_source=$_FILES[$name]['tmp_name'];		// temp location of file	
			
			$type_ext  = explode(".", $_FILES[$param['image_name']]["name"]);
			
			$save_ext = $type_ext[1];
			
			$save_ex_flage=0;
			
			
			if (is_array($param['allow_ext']) && in_array("$save_ext", $param['allow_ext'])) {
				$file_location = $location.$save_img.'.'.$save_ext;
				$upld= move_uploaded_file($file_source,$file_location);
				
				$get_file = $file_location.'.'.$save_ext;
			
				return $file_location;
			 }
			 else{
				$file_location = $location.$save_img.'.'.$save_ext;
				
				$upld= move_uploaded_file($file_source,$file_location);
				
				$get_file = $save_img.'.'.$save_ext;
			
				return $file_location;
				
			 }
			
		}
		
		function upload_img($param){
		
					//decalare variable
					
					$image_name = $param['image_name'];
					
					$location    = $param['location'];
					
					$image_size  = $param['image_size'];
					
					$key_id      = $param['key_id'];
					
					$old_image_file = $param['old_image'];
					
					$save_ext_type = $param['save_ext_type'];
					
					$image_data  = $_FILES[$image_name];
					
					$valid_exts = array('jpeg', 'jpg', 'png', 'gif');
					
					$default_sizes = array(500=>500);
					
					
					
					#print_r($image_size);
					
					$sizes = ($image_size)?$image_size:$default_sizes; //array(100 => 90, 150 => 150, 250 => 250);
					
					$ext_type = explode(".", $_FILES[$param['image_name']]["name"]);
				       
				        $img_counter =1;
					
					# HARD
					$save_img_name =($param['img_name'])?$param['img_name']:$key_id;
					
					//$save_image_name = '';
					//$save_file_name_prefix = @$param['data_def']['save_file_name_prefix'];
					//
					//$save_file_name_suffix = @$param['data_def']['save_file_name_suffix'];
					
					
					foreach ($sizes as $width => $height) {
						
						list($img_w, $img_h) = getimagesize($image_data['tmp_name']);
				
						$ratio = max($width/$img_w, $height/$img_h);
						$img_h = ceil($height / $ratio);
						$x = ($img_w - $width / $ratio) / 2;
						$img_w = ceil($width / $ratio);
						
						#$path =$location.''.$save_file_name_prefix.$save_img_name.$save_file_name_suffix.'_'.$img_counter;
						$path =$location.''.$save_img_name.'_'.$img_counter;
						
						$imgString = file_get_contents($image_data['tmp_name']);
						
						$image = imagecreatefromstring($imgString);
						$tmp  = imagecreatetruecolor($width, $height);
						imagealphablending($tmp, FALSE);
						imagesavealpha($tmp, TRUE);
						imagecopyresampled($tmp, $image,0, 0,$x, 0,$width, $height, $img_w, $img_h);
						
						
						if(is_file(@$param['old_image'])){
							  unlink($param['old_image']);		
						}
						
						if (is_array($param['allow_ext']) && in_array("$ext_type[1]", $param['allow_ext'])) {
								//echo 'image/'.$ext_type[1].'------------>>>>-'.$image_data['type'].'======<br>';
							switch ('image/'.$ext_type[1]){
								case 'image/jpg':
									imagejpeg($tmp, $path.'.jpg' , 100);
									$save_image_name.=$path.'.jpg'.','; 
									break;
								case 'image/jpeg':
									imagejpeg($tmp, $path.'.jpg' , 100);
									$save_image_name.=$path.'.jpg'.',';
									break;
								case 'image/png':
									imagegif($tmp, $path.'.png');
									$save_image_name.=$path.'.png'.',';
									break;
								default:
									exit;
									break;
							}
							
						}
						else{
							
							switch ($image_data['type']) {
								case 'image/jpeg':
									imagejpeg($tmp, $path.'.jpg' , 100);
									$save_image_name.=$path.'.jpg'.',';
									break;
								case 'image/png':
									imagepng($tmp, $path.'.png', 0);
									$save_image_name.=$path.'.png'.',';
									break;
								case 'image/gif':
									imagegif($tmp, $path.'.gif');
									$save_image_name.=$path.'.gif'.',';
									break;
								default:
									exit;
									break;
							}//switch case	
								
						}
										
										
										
							#return $path;
						        /* cleanup memory */
							imagedestroy($image);
						        imagedestroy($tmp);
							
							
					
						$img_counter++;	
					}
					
					
					#echo substr($save_image_name,0,-1);
					return substr($save_image_name,0,-1);
					
		}
		
		function upload_size_img($param){
				
				
				//decalare variable
					
					$image_name = $param['image_name'];
					
					#$location    = $param['location'];
					
					$image_size  = $param['image_size'];
					
					$key_id      = $param['key_id'];
					
					$old_image_file = $param['old_image'];
					
					$save_ext_type = $param['save_ext_type'];
					
					$image_data  = $_FILES[$image_name];
					
					$valid_exts = array('jpeg', 'jpg', 'png', 'gif');
					
					$default_sizes = array(500=>500);
					
					
					
					#print_r($image_size);
					
					$sizes = ($image_size)?$image_size:$default_sizes; //array(100 => 90, 150 => 150, 250 => 250);
					
					$ext_type = explode(".", $_FILES[$param['image_name']]["name"]);
				       
				        $img_counter =1;
					
					# HARD
					$save_img_name =($param['img_name'])?$param['img_name']:$key_id;
					
					
					$save_file_name_prefix = @$param['data_def']['save_file_name_prefix'];
					
					$save_file_name_suffix = @$param['data_def']['save_file_name_suffix'];
					
					
					list($img_w, $img_h) = getimagesize($image_data['tmp_name']);
					
					
					if($img_w < $img_h){						     
						$img_type ='portrait';		
					}elseif($img_w > $img_h){								
						$img_type ='landscape';			
					}else{
						$img_type ='square';									
					}
					
					 return get_image_size( array('type'=>$img_type, 'image_size'=> @$param['data_def']['image_size_auto'],
								   'img_w' => $img_w, 'img_h'=>$img_h,'location'=>$param['location'],
								   'save_file_name_prefix'=>@$param['data_def']['save_file_name_prefix'],
								   'save_file_name_suffix'=>@$param['data_def']['save_file_name_suffix'],
								   'save_img_name' => $save_img_name, 'old_image' => $param['old_image'],
								   'allow_ext' => $param['allow_ext'], 'ext_type' =>$ext_type[1], 'allow_ext' => $param['allow_ext'],
								   'image_data' => $image_data,
								   
								   )
							    );
				
		}
		
		
		function get_image_size($param){
			
			$type = $param['type'];
			
			$ratio_type = $param['image_size'][$type];
			
			$img_w =$param['img_w'];
			
			$img_h = $param['img_h'];
			
			$img_counter =1;
			
			$save_image_name = '';
			foreach($ratio_type as $key_size=>$size_value){
				
				$width = $size_value['w'];
				$height= $size_value['h'];
				
				$ratio = max($width/$img_w, $height/$img_h);
				$img_h = ceil($height / $ratio);
				$x = ($img_w - $width / $ratio) / 2;
				$img_w = ceil($width / $ratio);
				$path =$param['location'].''.$param['save_file_name_prefix'].$param['save_img_name'].$param['save_file_name_suffix'].'_'.$img_counter;
				
				$imgString = file_get_contents($param['image_data']['tmp_name']);
						
				$image = imagecreatefromstring($imgString);
				$tmp  = imagecreatetruecolor($width, $height);
				imagealphablending($tmp, FALSE);
				imagesavealpha($tmp, TRUE);
				imagecopyresampled($tmp, $image,0, 0,$x, 0,$width, $height, $img_w, $img_h);
				
				if(is_file(@$param['old_image'])){
				  unlink($param['old_image']);		
				 }
				
				
				if (is_array($param['allow_ext']) && in_array($param['eext_type'], $param['allow_ext'])) {
						switch ('image/'.$ext_type[1]){
							case 'image/jpg':
								imagejpeg($tmp, $path.'.jpg' , 100);
								$save_image_name.=$path.'.jpg'.','; 
								break;
							case 'image/jpeg':
								imagejpeg($tmp, $path.'.jpg' , 100);
								$save_image_name.=$path.'.jpg'.',';
								break;
							case 'image/png':
								imagegif($tmp, $path.'.png');
								$save_image_name.=$path.'.png'.',';
								break;
							default:
								exit;
								break;
						}// switc		
						
				}// if
				
				else{
						
					switch ($param['image_data']['type']) {
						case 'image/jpeg':
							imagejpeg($tmp, $path.'.jpg' , 100);
							$save_image_name.=$path.'.jpg'.',';
							break;
						case 'image/png':
							imagepng($tmp, $path.'.png', 0);
							$save_image_name.=$path.'.png'.',';
							break;
						case 'image/gif':
							imagegif($tmp, $path.'.gif');
							$save_image_name.=$path.'.gif'.',';
							break;
						default:
							exit;
							break;
					}//switch case				
						
						
				}//esle
				
				imagedestroy($image);
				imagedestroy($tmp);
				
			        $img_counter++;	
			}//loop
			
			return substr($save_image_name,0,-1);
				
		}//function
		
		
		
		if(@$_GET['action']=='DI'){
				
			unlink_image();	
		}
		
		function unlink_image(){
				$image_loc = '../../../'.$_GET['img_loc'];
				if(is_file($image_loc)){
					echo unlink($image_loc);
				}
				
		}
		
		
		

?>