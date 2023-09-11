<?PHP
 

 
  $rdsql = new rdsql();
 
  //Define the class:
 
    class rdsql{
     
		  private  $CONN;
		   
		  function __construct(){
		    
			       global $db_conn_info;
			   			
			       $this->CONN = $db_conn_info;
		  }
		 
		 #Query Execution:
			   
			   function exec_query($sql,$error_msg){
			    
					  $conn = $this->CONN;
			  
					   
					   $query = mysqli_query($conn,$sql)or die($error_msg.''.mysqli_error($conn));
					   
					   return $query;
			   }//end
			   
			 #Fetch Object:
			 
			   function data_fetch_object($exec_query){
					    
				      $fetch_obj = mysqli_fetch_object($exec_query);
				      return $fetch_obj; 
			   }//end
			   
			   
			 #Fetch Array:
			   
			   function data_fetch_array($exec_query){
			    
					 $fetch_array =mysqli_fetch_array($exec_query);
					 
					 //$fetch_array =pg_fetch_array($exec_query);
					 
					 return $fetch_array;
			   }//end
			   
			   
			 #Fetch Assoc:
			 
			   function data_fetch_assoc($exec_query){
			    
					 $fetch_assoc=mysqli_fetch_assoc($exec_query);
					 
					 //$fetch_assoc=pg_fetch_assoc($exec_query);
					 
					 return $fetch_assoc;
			   }//end
			   
			   
			 #Fetch Row:
			 
			   function data_fetch_row($exec_query){
			    
					 $fetch_row = mysqli_fetch_row($exec_query);
					 
					 //$fetch_row = pg_fetch_row($exec_query);
					 
					 return $fetch_row;
			   }//end
			   
			   
			 #Escape String:
			 
			   function escape_string($string){
			      		$conn = $this->CONN;
					  $escape_string = mysqli_real_escape_string($conn,($string ?? ''));
					  
					  //$escape_string = pg_escape_string($string);
					  
					  return $escape_string;
	       
			   }//end
			 
			 #Insert Id:
			 
			   function last_insert_id($table_name){
			    $conn = $this->CONN;
			          //$insert_id_query = 'SELECT currval(\''.$table_name.'_id_seq\')';
				  
				  //$insert_id_query_exec =$this->exec_query($insert_id_query,"ERROR");
				  
				  //$get_row = $this->data_fetch_array($insert_id_query_exec);
				  
				  //$last_insert_id = $get_row['currval'];
				  
				    $last_insert_id = mysqli_insert_id($conn);
				  
				    return $last_insert_id;
			   }//end
			   
			
			  # result_rows			   
                           function num_rows($result){                          
                            
                                    return mysqli_stmt_num_rows($result);                            
                           }
			   
	   
	   }//class		

?>
