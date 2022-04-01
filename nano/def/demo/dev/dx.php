<?PHP
    $D_SERIES =array(
	    #Title#
		
		'title' => 'Demo dev',
		'gx' => 1,
		
		#Table Data#
		'data'  =>array(
					
					2=> array( 
							 'th'=>'Text',
							 'field'=>"text_flat",
							 'th_attr'=>'width="15%"',
							 'attr' => array('class'=>'label_father align_LM'),
							 'is_sort'=>0
							 ),
					3=> array(
							 'th'=>'Textarea',
							 'field'=>"text_area",
							 'td_attr'=> ' class="align_LM" width="20%" ',
							 'is_sort'=>0
							 ),
					4 => array(
								'th' => 'Date ',
								'field' => "date_format(date_flat,'%d-%b-%Y')",
								'td_attr' => ' class="align_LM" width="12%"',
								'is_sort' => 0
							),
					5 => array(
							 'th' => 'Decimal ',
						     'field' => "decimal_flat",
						     'td_attr' => ' class="align_LM" width="10%"',
                             'is_sort' => 0
                           ),
					6 => array(
								'th' => 'Auto Complete ',
								'field' => "(SELECT sn FROM entity WHERE id = autocomplete)",
								'td_attr' => ' class="align_LM" width="10%"',
								'is_sort' => 0
							),
					7 => array(
								'th' => 'Left Right ',
								//'field' =>"(SELECT ".$DC->group_concat('text_flat')." FROM demo as d_out WHERE d_out.id IN (demo.left_right))",
								'field' => "(SELECT group_concat(text_flat) FROM demo as d_out WHERE FIND_IN_SET(d_out.id,demo.left_right))",
								'td_attr' => ' class="align_LM" width="10%"',
								'is_sort' => 0
								),
		
		'7a'=>array('th'=>'Option',
         'field' =>"option_single",        
         'td_attr' => ' class="align_LM" width="10%"',        
         'is_sort' => 0,    
        
         ),
         8 => array(
             'th' => 'Image',
             'field' => "image_flat",
             'td_attr' => ' class="align_LM" width="10%"',
             'is_sort' => 0
         ),
         10 => array(
             'th' => 'Checkbox',
             'field' => "checkbox",
             'td_attr' => ' class="align_LM" width="10%"',
             'is_sort' => 0
         ),
         11 => array(
             'th' => 'Radio',
             'field' => "radio",
             'td_attr' => ' class="align_LM" width="10%"',
             'is_sort' => 0
         ),
         9 => array(
             'th' => 'Updated On',
             'field' => "date_format(timestamp_punch,'%d-%b-%Y %H:%I') ",
             'td_attr' => ' class="no_wrap clr_gray_a align_LM txt_size_11" width="10%"',
             'is_sort' => 1
         ),
         12 => array(
             'th' => 'Checkbox Multistate',
             'field' => "checkbox_ms",
             'td_attr' => ' class="align_LM" width="10%"',
             'is_sort' => 0
         )
										
		),
		#table info#
		'table_name' => 'demo',
		'key_id'	 =>'id',
		'add_button' =>array('is_add'=>1,'page_link' => 'fx=demo__dev'),
		'action'     =>array('is_action'=> 1, 'is_edit'=> 1),
		'del_permission'=> array('able_del'=> 1)
		
		);
?>