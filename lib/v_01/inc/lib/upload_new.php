<?php


		/*function upload($name,$location,$img_id){
		  
			$file_name=$_FILES[$name]['name'];				// store file
			
			$file_source=$_FILES[$name]['tmp_name'];		// temp location of file	
			
			$file_location=$location.$img_id.'_'.$file_name;
			
			$upld= move_uploaded_file($file_source,$file_location);
			//chmod("$upld",0777);
			
			return $file_name;
		}*/
		
		
		function upload($name,$location,$img_id){
		
				
				$allowedExts = array("gif", "jpeg", "jpg", "png");
				
				$temp = explode(".", $_FILES[$name]["name"]);
				
				$extension = end($temp);
				
				if ((($_FILES[$name]["type"] == "image/gif")
						|| ($_FILES[$name]["type"] == "image/jpeg")
						|| ($_FILES[$name]["type"] == "image/jpg")
						|| ($_FILES[$name]["type"] == "image/pjpeg")
						|| ($_FILES[$name]["type"] == "image/x-png")
						|| ($_FILES[$name]["type"] == "image/png"))
						&& ($_FILES[$name]["size"] < 20000)
						&& in_array($extension, $allowedExts)) {
						
						  if ($_FILES[$name]["error"] > 0) {
							echo "Error: " . $_FILES[$name]["error"] . "<br>";
						  } 
						  else {
						  
							/*echo "Upload: " . $_FILES[$name]["name"] . "<br>";
							echo "Type: " . $_FILES[$name]["type"] . "<br>";
							echo "Size: " . ($_FILES[$name]["size"] / 1024) . " kB<br>";
							echo "Stored in: " . $_FILES[$name]["tmp_name"];*/
							
							return  upload_img($name,$location,$img_id);
							
							exit;
						  }
						  
						}
						
						 else {
						 
						  if ($_FILES[$name]["error"] > 0) {
							echo "Error: " . $_FILES[$name]["error"] . "<br>";
						  } 
						  
						  else{
						  
						  	return upload_doc($name,$location,$img_id);
							
							exit;
						  
						  }
						 
						 // echo "Invalid file";
						 
						 
				}
				
	}
	
	
	
	
	function upload_img($name,$location,$img_id){
	
				 $imagename = $_FILES[$name]['name'];		//file source
						
				$file_source=$_FILES[$name]['tmp_name'];		//temp location of file
				
				$target_location=$location.$img_id.'.jpg';				//target location
			
				move_uploaded_file($file_source,$target_location);	//upload function
					  
				return   $imagename;
	
	}
	
	
	function upload_doc($name,$location,$img_id){
		  
			$file_name=$_FILES[$name]['name'];				// store file
			
			$file_source=$_FILES[$name]['tmp_name'];		// temp location of file	
			
			$file_location=$location.$img_id.'_'.$file_name;
			
			$upld= move_uploaded_file($file_source,$file_location);
			
			//echo $files = $location.''.$file_name;
			//chmod($files,0777);
			
			//echo  $file_name;
			$get_file = $file_name;
			
			return $get_file;
		}

?>