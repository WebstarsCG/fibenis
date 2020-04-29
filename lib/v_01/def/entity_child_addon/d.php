<?PHP
	       
        $D_SERIES       =   array(
		
		
                                   'title'=>'',
                                    
				    'gx'	=> 1,
				    
                                    #table data
                                    
                                    'data'=> array(),
				    
					'action' => array('is_action'=>0, 'is_edit' =>1, 'is_view' =>0 ),
					
					'order_by'   =>'' ,
					
					'key_filter'	=> '',
						 
                                
                                    #Table Info
                                    
                                    'table_name' =>'entity_child',
                                    
                                    'key_id'    =>'id',
				    
                                    
                                    # Default Additional Column
                                
                                    'is_user_id'       => 'user_id',
                                
                                    # Communication
                                
                                    'prime_index'   => 1,
				    
				    'is_narrow_down' => 1,
				    
				    'summary_data'=>array(
								array(  'name'=>'No.','field'=>'count(id)','html'=>'class=summary'),
								
						),
						
                                
				#check_field
								
					'check_field'   =>  array('user_id' => @$_GET['user_id']),								
								
					'del_permission' => array('able_del'=>1,'user_flage'=>1), 
								
				
								
				#export data
				
				'export_csv'   => array('is_active' => 1),								
				
				'show_query'	=> 0,
                            
                        );
	
	if(@$_GET['default_addon']){
		
		$D_SERIES['temp']=d_addon(['default_addon'=>$_GET['default_addon'],
			    		   'd_series'     => ['data'=>$D_SERIES['data']]]);
					
		// each
		foreach($D_SERIES['temp'] as $akey => $aval){
			
			$D_SERIES[$akey]=$aval;
		}
		
		$D_SERIES['action']['action_default_addon'] = @$_GET['default_addon'];
	} // end
	
	if(@$_GET['menu_off']==1){
		
		$LAYOUT                 = 'layout_full';
		$D_SERIES['filter_off'] = 1;		
		$D_SERIES['is_narrow_down']            = 1;
		$D_SERIES['action']['action_menu_off']       = @$_GET['menu_off'];
		$D_SERIES['action']['action_narrow_down'] = 1;
	}
	
	// desk addon
	function d_addon($param){
		
		global $rdsql;
		
		$lv = ['data' =>[],
		       'dkeys'=>['th','th_attr','td_attr','filter_out','js_call','is_sort'],
		       'input_type'   =>[	'ITTX'=>['table'=>'varchar'],
					'ITNM'=>['table'=>'decimal'],
					'ITHD'=>['table'=>''],
					'ITLA'=>['table'=>''],
					'ITIG'=>['table'=>'num'],
					'ITTA'=>['table'=>'text'],
					'ITCE'=>['table'=>'text'],
					'ITTG'=>['table'=>'bool'],
					'ITTE'=>['table'=>'text'],
					'ITSL'=>['table'=>'varchar'],
					'ITFT'=>['table'=>'text'],
					'ITFD'=>['table'=>'varchar'],
					'ITFI'=>['table'=>'varchar'],
					'ITDT'=>['table'=>'date'],
					'ITRG'=>['table'=>'varchar'],
					'ITTB'=>['table'=>'varchar'],
				],
			'key_filter'=>''
		       ];
		
		$lv['counter'] = ['row'=>1];
		
		$lv['d_query'] = "SELECT
					token,
					get_ecb_av_addon_varchar(id,'APIT') as input_type,
					get_ecb_av_addon_varchar(id,'ADXN') as th,
					get_ecb_av_addon_varchar(id,'ADXA') as th_attr,
					get_ecb_av_addon_varchar(id,'ADXC') as td_attr,
					get_ecb_av_addon_varchar(id,'ADXF') as filter_out,
					get_ecb_av_addon_varchar(id,'ADXJ') as js_call,
					get_ecb_av_addon_varchar(id,'ADXS') as is_sort
				FROM
					entity_child_base
				WHERE
					entity_code='$param[default_addon]' AND
					get_ecb_av_addon_varchar(id,'ADXI') = 1";
					
					
		$lv['d_query_result'] = $rdsql->exec_query("$lv[d_query]","Error d_addon child");
		
		while($lv['d_query_info']  = $rdsql->data_fetch_assoc($lv['d_query_result'])){
			
			$temp = [];
			
			//print_r($lv['d_query_info']);
			
			foreach($lv['dkeys'] as $dkey){
				
				if(@$lv['d_query_info'][$dkey]){
					$temp[$dkey]=$lv['d_query_info'][$dkey];	
				}
			}
			
			if($lv['d_query_info']['input_type'] && $lv['d_query_info']['token']){
				
				$temp['field']="get_exav_addon_".$lv['input_type'][$lv['d_query_info']['input_type']]['table'].
				               "(id,'".$lv['d_query_info']['token']."')";
			
				$lv['data'][$lv['counter']['row']]=$temp;
				$lv['counter']['row']++;
			}
			
		} // end
		
		// filter
		if(@$param['default_addon']){
			
			$lv['key_filter'] = " AND entity_code='$param[default_addon]'";			
		}
		
		
		return ['data'      =>$lv['data'],
			'key_filter'=>$lv['key_filter']];
		
	} // end
	
	
	
?>