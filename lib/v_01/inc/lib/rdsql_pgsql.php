<?PHP

 //class instance
  
  $rdsql = new rdsql();
 
 
 //Define the class:
 
    class rdsql{
     
		   //protected $dbh;
		   
		    //function __construct(){
		     
		     //$this->dbh = $dbh;
		     
		     
		    //}
		    
			//function sql_type($)
			
			#Query Execution:
			   
			   function exec_query($sql,$error_msg){
			    
					   //global $dbh;
			   //$conn=pg_connect("host=localhost dbname=kubera user=postgres password=postgres");
					   
					   //echo $sql;
					   
					   $query = pg_query($sql);
					   
					   //$query = mysql_query($sql)or die($error_msg.''.mysql_error());
					   
					   return $query;
			   }//end
			   
			 #Fetch Object:
			 
			   function data_fetch_object($exec_query){
					   
				      //$fetch_obj = mysql_fetch_object($exec_query);
				      
				      $fetch_obj = pg_fetch_object($exec_query);
				      
				      return $fetch_obj; 
			   }//end
			   
			   
			 #Fetch Array:
			   
			   function data_fetch_array($exec_query){
			    
					 //$fetch_array =mysql_fetch_array($exec_query);
					 
					 $fetch_array =pg_fetch_array($exec_query);
					 
					 return $fetch_array;
			   }//end
			   
			   
			 #Fetch Assoc:
			 
			   function data_fetch_assoc($exec_query){
			    
					 //$fetch_assoc=mysql_fetch_assoc($exec_query);
					 
					 $fetch_assoc=pg_fetch_assoc($exec_query);
					 
					 return $fetch_assoc;
			   }//end
			   
			   
			 #Fetch Row:
			 
			   function data_fetch_row($exec_query){
			    
					 //$fetch_row = mysql_fetch_row($exec_query);
					 
					 $fetch_row = pg_fetch_row($exec_query);
					 
					 return $fetch_row;
			   }//end
			   
			   
			 #Escape String:
			 
			   function escape_string($string){
			    
					  //$escape_string = mysql_real_escape_string($string);
					  
					  $escape_string = pg_escape_string($string);
					  
					  return $escape_string;
	       
			   }//end
			 
			 #Insert Id:
			 
			   function last_insert_id($table_name){
			    
			          $insert_id_query = 'SELECT currval(\''.$table_name.'_id_seq\')';
				  
				  $insert_id_query_exec =$this->exec_query($insert_id_query,"ERROR");
				  
				  $get_row = $this->data_fetch_array($insert_id_query_exec);
				  
				  $last_insert_id = $get_row['currval'];
				  
				       return $last_insert_id;
			   }//end
                           
                           
                           # result_rows
			   
                           function num_rows($result){                          
                            
                                    return pg_num_rows($result);                            
                           }
                           
			   
			   
	   
	   }//class		

?>