<?PHP
     $LAYOUT = 'layout_basic';
	 $F_SERIES=array(
					'title' => 'RO UPS',

					'table_name' => 'query_detail',

					'key_id' => 'id',

					'gx' => 1,
					
					 'data' => array(
										'1' => array(
													 'field_name' => 'Queries',
													 'type' => 'heading'
													 ) ,

										'2' => array(
													'field_name' => 'Call for Reason',
													'field_id' => 'call_for_reason',
													'type' => 'option',
													'is_mandatory' => 1,
													'input_html' => 'class="w_200"'
													) ,

										'3' => array(
													'field_name' => 'Sub Reason',
													'field_id' => 'sub_reason',
													'type' => 'textarea',
													'input_html' => 'class="w_200"',
													'allow' => 'x250'
													) ,

										'4' => array(
													'field_name' => 'Caller Name',
													'field_id' => 'caller_name',
													'type' => 'text',
													'allow' => 'x50',
													'is_mandatory' => 1,
													'input_html' => 'class="w_200"'
													),
										'5' => array(
													'field_name' => 'Caller Address/Area',
													'field_id' => 'caller_address',
													'type' => 'Textarea',
													'allow'=>'x250',
													'is_mandatory'=>1,
													'input_html' => 'class="w_200"',

													),
										'6' => array(
													'field_name' => 'Caller Mobile No.',
													'field_id' => 'caller_mobile',
													'type' => 'text',
													'allow'=>'d10',
													'is_mandatory' => 1,
													'input_html' => 'class="w_200"',

												) ,
										'7' => array(
													'field_name' => 'Caller Status',
													'field_id' => 'caller_status',
													'type' => 'option',
													'is_mandatory' => 0,
													'input_html' => 'class="w_200"',
													) ,
										'8' => array(
													   'field_name' => 'Date',
													    'field_id' => 'date',
														'type' => 'date',
														'is_mandatory' => 1,
													) ,
										'9' => array(
													'field_name' => 'Call Attender(Staff name)',
													'field_id' => 'staff_name',
													'type' => 'option',
													'is_mandatory' => 1,
													'input_html' => 'class="w_200"',
													) ,

										
									),
					'is_user_id' => 'user_id',

					# Communication
					'back_to' => array(
										'is_back_button' => 1,
										'back_link' => '?dx=ro_ups',
										'BACK_NAME' => 'Back'
										) ,

					//'flat_message'	=> 'Successfully Added',
					//'prime_index' => 7,
					'message' => '(SELECT sn FROM entity WHERE id=option_single)',
					'show_query' => 0
					
	);
    
	
?>
