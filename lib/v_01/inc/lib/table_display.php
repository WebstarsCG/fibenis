<?PHP
                
        class Table{
                
                
                protected $rdsql;
              
              
        function __construct(){
                     
                  $this->rdsql =new rdsql();
        }
                
        //define the function display_table for displaying the field
            //input:query result,$display_field
            //using array of array to get the result
            //display the required fields
            //return the array of the value
            
            function display_table($given_query_obj,$display_field){
                
                        global $rdsql;
                                
                        $info=array();
                
                        while($get_row    =  $rdsql->data_fetch_assoc($given_query_obj)){
                              
                              $temp  = array();
                              
                              $field = '';
                              
                              // data to info
                              
                              foreach ($display_field as $field){
                              
                                      $temp[$field]        = $get_row[$field];
                                     
                                     
                              } // for each
                              
                              array_push($info,$temp);
                              
                        }
                        
                return $info;
         
            } //end of display_table
            
            function get_table_single_data($given_query_obj,$display_field){
                      
                      global $rdsql;
                                
                     $info=array();
                
               while($get_row    = $rdsql->data_fetch_assoc($given_query_obj)){
                     
                     $temp  = array();
                     
                     $field = '';
                     
                     // data to info
                     
                     foreach ($display_field as $field){
                     
                             $temp[$field]        = @$get_row[$field];
                            
                            
                     } // for each
                     
                     //array_push($info,$temp);
                     
               } 
                return @$temp;
            }
            
            //define the function for display table heading
            //input: array of header_fields
            //push the array of field name into temp
            //return the required value
            
            function display_header_info($th_attr,$header_fields){
                
                $temp           =       array();
                
                $field='';
                
                foreach($header_fields as $field){
                         
                         array_push($temp,array('NAME'=>$field,'ATTR'=>$th_attr));
                         
                }//for each
                
               return $temp;
                
            }//end of header_info
            
            
        // display_table_auto
        //input: array of table data
        //output:data info 
        
        function display_table_auto($td_attr,$given_query_obj,$display_field){
                
                global $rdsql;
                
                $info=array();
                
                //'<td '".$class."'></td>'
                while($get_row    =  $rdsql->data_fetch_assoc($given_query_obj)){
                     
                     $temp  = array();
                     
                     // data to info
                     
                     foreach($display_field as $field){                        
                                        
                                // echo $field."---".$get_row[$field]."<br>";        
                                     
                                array_push($temp,array('NAME'=>$get_row[$field],'ATTR'=>$td_attr));
                    
                     } // for each                     
                     array_push($info,array('ROW_INFO'=>$temp));
                     
                } // each row
                
                return $info;
                                    
        } //end of display_table_auto
        
        
}
            
?>