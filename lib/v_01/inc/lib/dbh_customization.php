<?php
     
     // database customization
     
     	$DC = new DB_CUSTOMIZATION('');
     
     class DB_CUSTOMIZATION{
          
                  var $DB_ENGINE;
		  
		  var $dbh; 
				
               // 1. create construct for db 	
                    function __construct($DB_ENGINE){		
    
                                    $this->DB_ENGINE = $DB_ENGINE;
				    
				
                            
                    }
          
              // for limit 0.... 10;
	      
	       function db_limit($start,$per_page){
                  
                         global $DB_ENGINE;
                        
			 $LIMIT_ACTION   = array(
						 
						  'rdsql_mysql'  => "LIMIT $start,$per_page" ,
						  
						  'rdsql_mysqli'  => "LIMIT $start,$per_page" ,
						  
						  'rdsql_pgsql'  =>  "LIMIT $per_page OFFSET $start" 
						
			  			);
			 
			 return $LIMIT_ACTION[$DB_ENGINE];
     
                }
	      
	     function get_last_insert_id($id_seq){
			  
			  global $DB_ENGINE;
			   
			  $last_insert_id  = array( 
			  
						    'rdsql_mysql'   => "lastInsertID()",
						    
						    'rdsql_mysqli'   => "lastInsertID()",
						    
						    'rdsql_pgsql'   => "$id_seq" 
				            );
			 return $last_insert_id[$DB_ENGINE];
	     }
	     
	     
	     
	     // null
	     
	     
	      function get_null_str($id_seq){
			  
			  global $DB_ENGINE;
			   
			  $last_insert_id  = array( 
			  
						    'rdsql_mysql'   => "IFNULL",
						    
						    'rdsql_mysqli'   => "IFNULL",
						    
						    'rdsql_pgsql'   => "NULLIF" 
				            );
			 return $last_insert_id[$DB_ENGINE];
	     }
	     
	     // group concat
	     
	     function group_concat($field_id){
	       
		      global $DB_ENGINE;
		     
		      $group_concat   = array(
					      
					       'rdsql_mysql'  =>  " group_concat(".$field_id.")" ,
					       
					       'rdsql_mysqli'  => " group_concat(".$field_id.")" ,
					       
					       'rdsql_pgsql'  =>  "array_to_string(array_agg(".$field_id."),',')" 
					     
					     );
		      
		      return $group_concat[$DB_ENGINE];
  
	     }
	     
	     
	     
	       
	       
     }
     
     
      
?>