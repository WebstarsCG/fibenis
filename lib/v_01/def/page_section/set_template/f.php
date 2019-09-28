<?PHP
    
    $temp       = [];
    $temp       = json_decode(urldecode($_GET['default_addon']),true);
    
    $F_SERIES	=	array(
				#Title
				
				'title'	=>'Section Template',
				
				#Table field
                    
				'data'	=>   array(
				    
						    '1' =>array( 'field_name'=> 'Page ',
                                                               
								'field_id' => 'parent_id',
                                                               
								'type' => 'option',
								
								'option_data'=>$G->option_builder("eav_addon_varchar","parent_id,ea_value","WHERE ea_code='ECSN' AND parent_id=".$temp['p']),
                                                               
								'avoid_default_option' => 1,
								
								'is_mandatory'=>1,
								
								'input_html'=>'class="w_150"',
								
                                                               
                                                             ),
						    
						    '2' =>array( 'field_name'=> 'Content Template ',
                                                               
								'field_id' => 'ecb_id',
                                                               
								'type' => 'option',
								
								'option_data'=>$G->option_builder("entity_child_base","id,sn","WHERE entity_code='SC' ORDER BY sn ASC"),
                                                               
								'avoid_default_option' => 0,
								
								'is_mandatory'=>1,
								
								'input_html'=>'class="w_150"',
								
								//'attr' => ['data-update-prefill-off' => 1,
								//	    'class' => 'w_150'],
								//				  
                                                               
                                                             ),
						   
					    ),
				
                                    
				'table_name'    => 'eav_addon_ecb_id',
				
				'key_id'        => 'id',
				
				'is_user_id'       => 'user_id',
				
				'back_to'  => NULL,
				
				'default_fields'    => array('ea_code' => "'PGTM'"),
                                
				'flat_message' => 'Sucesssfully Updated',
				
				'show_query'    =>0,
				
				'before_add_update'=>1,
                                
			);
    
    # update case
    
    if(@$temp['t']){
	$F_SERIES['button_name']= ' Update '.$F_SERIES['title'];       
    }else{
	$F_SERIES['button_name']= ' Set '.$F_SERIES['title'];       
    }
    
    function before_add_update($key_id){
	
	    global $rdsql;
	    
	    $temp = [];
	    $temp                    = json_decode(urldecode($_GET['default_addon']),true);
    
	    $rdsql->exec_query("DELETE FROM eav_addon_ecb_id WHERE parent_id=$temp[p] AND ea_code='PGTM'","Error");	
	    
	    return 1;
		
    }
    
    
?>

<script language="JavaScript">
    
    document.onreadystatechange = () => {
	if (document.readyState === 'complete') {
	      document.getElementById('X2').value=<?PHP echo $temp['t'];?>;
	}
    };
</script>