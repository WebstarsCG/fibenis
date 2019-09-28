<?PHP


$D_SERIES = array(
	
	'title' => 'User Information',

	#query display depend on the user

	'is_user_base_query' => 0,
        
        'gx'=>1,

	#table data

	'data' => array(

		1 => array(
                                'th' => 'User Name',
                                
                                'field' => "get_eav_addon_varchar(is_internal,'COFN')",			
                                
                                'attr' =>['class'=>'label_grand_father align_LM',
                                                    'width'=> '18%'
                                        ] 
		),
                
		2 => array(
                                'th' => 'User Role',
			
                                'field' => '(SELECT ln FROM user_role WHERE id=user_role_id)',
			
                                'attr' =>['class'=>'clr_gray_7 txt_size_11 align_LM',
                                                    'width'=> '10%'
                                        ] 
                       
		),
                
		3 => array(
                                'th' => 'Login Email',
                                
                                'field' =>"get_eav_addon_varchar(is_internal,'COEM')",
                                
                                'attr' =>['class'=>'b"',
                                                    'width'=> '10%'
                                  ] 
		), 
		
		4 => array(
                                'th' => 'Status',
			
                                'field' => 'is_active',
                         
                                'attr' =>['class'=>'align_CM',
                                                    'width'=> '10%'
                                  ] ,
			
                                'js_call' => 'boolean_display'
		),
                
                5 => array(
                                'th' => 'Last Login',
                                
                                'field' => "date_format(last_login,'%d-%b-%Y %T')",
                         
                                'attr' =>['class'=>'label_grand_child',
                                                    'width'=> '20%'
                                        ] ,
                        
                                'is_sort'=>1 
			
		),

	),

	'action' => array('is_action' => 1, 'is_edit' => 0, 'is_view' => 0),

	'order_by' => 'ORDER BY id ASC',

	#Table Info

	'table_name' => 'user_info',

	'key_id' => 'id',

	'key_filter' => '',

	# Default Additional Column

	'is_user_id' => 'user_id',

	'hidden_data'=>array('id','email'),

	# Communication

	'prime_index' => 1,

	'search_filter_off' => 1,
				 
	# File Include

	'js' => array('is_top' => 1, 'top_js' => "$LIB_PATH/def/user_neutral/d"),

	
        # user ineternal
        
        'custom_filter' => array(
            
                        array(

				'field_name' => 'Role ',

				'field_id' => 'cf1', 

				'filter_type' =>'option_list', 

				'option_value'=> $G->option_builder('user_role','id,ln'," ORDER BY ln ASC"),
									  
				'cus_default_label' => 'Show All',

				'html' => ' class="w_100"',

				'filter_by'  => 'user_role_id'
                        ),
            

			array(

				'field_name' => 'Status ',

				'field_id' => 'cf2', 

				'filter_type' =>'option_list', 

				'option_value' => '<option value="2">Active</option><option value="1">In-Active</option>' ,

				'cus_default_label' => 'Show All',

				'html' => ' class="w_100"',

				'filter_by'  => '(is_active+1)'
                        )
                        
                        

	),
        
	#check_field

	'check_field' => array('id' => @$_GET['id']),								

	'add_button' => array('is_add' => 1, 'page_link' => 'f=user_neutral', 'b_name' => 'Add User' ),

	'del_permission' => array('able_del' => 1,'user_flage' => 1), 

	'bulk_action' => array(
                                array('is_bulk_button' => 1, 'button_name' => 'Deactivate', 'js_call'=>'deactive_users'),
                                array('is_bulk_button' => 1, 'button_name' => 'Activate', 'js_call'=>'active_users')
	),

	'date_filter' => array('is_date_filter' => 0, 'date_field' => 'timestamp_punch'),	

	#export data
	
	'export_csv' => array('is_export_file' => 0, 'button_name' => 'Create CSV', 'csv_file_name' => 'csv/log_'.time().'.csv'),

	'page_code' => 'DUSI'

);

?>