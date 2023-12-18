<?PHP
	       
	include("$LIB_PATH/inc/lib/d_addon.php");

	$D_SERIES       =   array(

		'title'			=> 'Desk',
		'table_name' 	=>'entity_child',
		'data'			=> array(),
		'key_id'    	=>'id',								
		'action' 		=> array('is_action'=>1, 'is_edit' =>1, 'is_view' =>0 ),		
		'summary_data'	=> array(
								['name'=>'No.','field'=>'count(id)','html'=>'class=summary']
							),
		'del_permission'=> array('able_del'=>1), 
		'add' 			=> array('is_add'=>1),
		'export_csv'    => array('is_active' => 1),		
		'show_query'=>0
	
	);



	if(@$_GET['default_addon']){
		$D_SERIES['temp']=d_addon(['default_addon'=>$_GET['default_addon'],
		'd_series'     => ['data'=>$D_SERIES['data']],
		'rdsql'        => $rdsql
		]);

						
		foreach($D_SERIES['temp'] as $akey => $aval){		
			$D_SERIES[$akey]=$aval;
		}

		$D_SERIES['action']['action_default_addon'] = @$_GET['default_addon'];

	} // end 

	if(@$_GET['menu_off']==1){
		$LAYOUT            							= 'layout_full';
		$D_SERIES['filter_off'] 					= 1;		
		$D_SERIES['is_narrow_down']            		= 1;
		$D_SERIES['action']['action_menu_off']    	= 1;
		$D_SERIES['action']['action_narrow_down'] 	= 1;
	}

	$D_SERIES['bulk_action'] = array(
										array('is_bulk_button' => 1,
										'button_name'    => 'Set Active ',
										//'js_call'        => 'update_action',

													'prompt'	       => ['is_active'  =>1,
											'title'      =>'Select Parent',
											'input_type' => 'select',
																		'options'    =>$G->get_id_name('entity','code,sn', 
															'WHERE is_lib=0') ],
													// additional action column
													'action'		   => [ 'series'    => 'ax',          // optional, based on series it will be taken (dx=>ax,d=>a)
																				'def'  	    => 'demo__flat',  // optional, it will take the current def
												'token'	    => 'OPT_UPD']
												)
	); 
	
?>