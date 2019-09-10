<?PHP
        	
	$LAYOUT = "layout_full";
				
	$T_SERIES       =   array( 
		
                                'table' => 'entity',
				 
				'data'  => array(
						 
							'code'=>array('field'=>'code'),
							
							'name'=>array('field'=>'sn'),
						
						),	
				
				
				'key_id' => '',
				
				'key_filter'=>' ',
				
				'show_query'=>1,
				
				'template'       => $LIB_PATH.'def/db_report/t.html',
				
				// save data 
				'save_as'=> array(
						
						array('type'=>'html',
						      'file_name'=>'db_report',
						      'path'=>$LIB_PATH.'def/db_report/')
						
					)

                            );
	
	
    
?>