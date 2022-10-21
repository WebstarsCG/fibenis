<?PHP
$LAYOUT = 'layout_basic';

$F_SERIES = array(

    'title' => 'Flat DB',

    'table_name' => 'demo',

    'key_id' => 'id',

    'gx' => 1,
	
	

    'data' => array(

        '1' => array(
            'field_name' => 'Basic',
            'type' => 'heading'
        ) ,

        '2' => array(
            'field_name' => 'Text',

            'field_id' => 'text_flat',

            'type' => 'text',

            'is_mandatory' => 1,

            'allow' => 'x5',

        ) ,

        '3' => array(
            'field_name' => 'Text area',
            'field_id' => 'text_area',
            'type' => 'textarea',
            'input_html' => 'class="w_200"',
            'allow' => 'x250'
        ) ,

        '4' => array(
            'field_name' => 'Decimal',

            'field_id' => 'decimal_flat',

            'type' => 'text',

            'allow' => 'c2,3',

            'is_mandatory' => 0,

            'input_html' => 'class="w_60"',

        ) ,

        '5' => array(
            'field_name' => 'Image',

            'field_id' => 'image_flat',

            'type' => 'file',

            'upload_type' => 'image',

            'save_file_name_prefix' => 'fdb_',

            'save_file_name_suffix' => '_img',

            'allow_ext' => array(
                'jpg',
                'jpeg',
                'png'
            ) ,

            'max_size' => 1024,
            'image_size' => array(
                400 => 640, # different size of images to create
                300 => 480, # width => height
                100 => 160
            ) ,
            'location' => 'media/',

            'is_mandatory' => 0,

            'input_html' => 'class="w_200"',

        ) ,

        '6' => array(
            'field_name' => 'Document',

            'field_id' => 'documents',

            'type' => 'file',

            'upload_type' => 'docs',

            'save_file_name_prefix' => 'fbn_',

            'save_file_name_suffix' => '_doc',

            'allow_ext' => array(
                'pdf'
            ) ,

            'max_size' => 1024,

            'location' => 'media/',

            'is_mandatory' => 0,

            'input_html' => 'class="w_200"',

        ) ,

        '7' => array(
            'field_name' => 'Option Single',

            'field_id' => 'option_single',

            'type' => 'option',

            'option_data' => $G->option_builder('entity', 'id,sn', ' WHERE is_lib = 0 ORDER by sn ASC') . '<option value=-1 class=clr_green>+Add New</option>',

            'is_mandatory' => 0,

            'input_html' => 'class="w_200" onchange="check_new_entity(this);setRightOptionLimit();"',

        ) ,

        '22' => array(
            'field_name' => 'New Entity code',
            'field_id' => 'option_code',
            'type' => 'text',
            'allow' => 'w2=',
            'is_hide' => 1,
            'ro' => 1,
            'is_mandatory' => 0,
            'input_html' => 'class="w_50 txt_case_upper" onchange="check_entity_code(this);"',
        ) ,

        '23' => array(
            'field_name' => 'New Entity name',
            'field_id'	 => 'option_sn',
            'type' 		 => 'text',
            'allow' 	 => 'x16',
            'is_hide' 	 => 1,
            'ro' 		 => 1,
            'is_mandatory' => 0,
			'input_html' => '' 
        ),
		

        '8' => array(
            'field_name' => 'Option Multiple',

            'field_id' => 'option_multiple',

            'type' => 'option',

            'is_list' => 1,

            'option_data' => $G->option_builder('entity', 'code,sn', ' WHERE is_lib = 0 ORDER by sn ASC') ,

            'is_mandatory' => 0,

            'input_html' => ' class="w_200"  style="height:200px !important"  ',

        ) ,

        '9' => array(
            'field_name' => 'Fiben Table',

            'field_id' => 'fiben_table',

            'is_fibenistable' => 1,

            'type' => 'fibenistable',

            'is_index' => 1,
			
			

            'is_mandatory' => 0,

            'colHeaders' => array(
                array(
                    'column' => 'Name',
                    'width' => '50',
                    'type' => 'text',
                ) ,
                array(
                    'column' => 'Rate',
                    'width' => '15',
                    'type' => 'text',
                ) ,
				
				array(
                    'column' => 'Qty',
                    'width' => '10',
                    'type' => 'text',
					'allow'=>'d2',
					 'key_up_addon' => "cal_total(this)"
                ) ,
				array(
                    'column' => 'Total',
                    'width' => '25',
                    'type' => 'text',
					'input_html'=>"readonly=true"
                ) ,
            )

        ) ,

        '10' => array(
            'field_name' => 'Date',

            'field_id' => 'date_flat',

            'type' => 'date',
			
			'is_mandatory' => 0,

        ) ,

        '11' => array(
            'field_name' => 'Range',

            'field_id' => 'range_flat',

            'type' => 'range',

        ) ,

        '12' => array(
            'field_name' => 'Toggle',

            'field_id' => 'toggle_switch',

            'type' => 'toggle',

            'is_round' => 1, # toggle will be in round type, by default it will be square
            'show_status_label' => 1, # show labels for on & off toggle status
            'on_label' => 'On', # shows during on status
            'off_label' => 'Off', # shows during off status
            'is_default_on' => 1, # set on status by default
            
        ) ,

        '13' => array(
            'field_name' => 'Auto Ccomplete',

            'field_id' => 'autocomplete',

            'type' => 'autocomplete',

            'remote_link' => 'router.php?series=ax&action=demo__flat&token=FT_AUT',

            'restrict_new_entry' => 1,

        ) ,

        '14' => array(
            'field_name' => 'Left Right',

            'field_id' => 'left_right',

            'type' => 'list_left_right',

            'option_data' => $G->option_builder("demo", "id,text_flat", "order by text_flat ASC") ,

            'input_html' => ' class="w_200" rows="2"  style="height:200px !important"  ',
			
			'right_option_limit'=>1,

        ) ,
		
		
		
        '20' => array(
            'field_name' => 'Checkbox',

            'field_id' => 'checkbox',

            'type' => 'checkbox',

            'is_mandatory' => 0,

            'options' => [['label' 	 => 'Option A',
							'value'  => 1],
							['label' => 'Option B',
							'value'  => 2],
							['label' => 'Option C',
							'value'  => 3]],

            'is_multistate' => 0,

            'is_mandatory' => 1

        ) ,

        '19' => array(
            'field_name' => 'Radio (Contact Attributes)',

            'field_id' => 'radio',

            'type' => 'radio',

            'is_mandatory' => 0,

            'options' => $G->radio_option_builder(['table' => 'entity_attribute', 'field_label' => 'sn', 'field_value' => 'code', 'where' => " WHERE entity_code='CO'"]) ,

            'input_html' => ' class="w_200"  style="height:100px !important"  ',

            'is_mandatory' => 1

        ) ,


        '21' => array(
            'field_name' => 'Checkbox Multistate',

            'field_id' => 'checkbox_ms',

            'type' => 'checkbox',

            'is_mandatory' => 0,

            /* 		 'options'	      =>$G->radio_option_builder(['table'	=>'entity_child_base',
            													 'field_label'=>'ln',
            													 'field_value'=>'id',
            													 'where'=> " WHERE entity_code='1A'"
            													  ]), */

            'options' => [['label' => "<img src='media/red.jpg' class='img-responsive' >",
            'value' => 'PH'],
            ['label' => "<img src='media/blue.jpg'  class='img-responsive' >",
            'value' => 'PY'],
            ['label' => "<img src='media/green.jpg'  class='img-responsive' >",
            'value' => 'AN']],

            'is_multistate' => 1,

            'maxstate' => 3,

            'is_mandatory' => 1

        ) ,
		
		

        '15' => array(
            'field_name' => 'Tab',

            'type' => 'heading',

        ) ,

        '16' => array(
            'field_name' => 'Text Editor',

            'field_id' => 'text_editor',

            'type' => 'textarea_editor',

            'input_html' => 'class="w_100"',

        ) ,

        '18' => array(
            'field_name' => 'Sub Heading',

            'type' => 'sub_heading',

        ) ,

        '17' => array(
            'field_name' => 'Code Editor',

            'field_id' => 'code_editor',

            'type' => 'code_editor',

            'input_html' => 'class="w_100"',

        ) ,
		
		

    ) ,

'get_last_insert'=>1,
    'is_user_id' => 'user_id',

    # Communication
    'back_to' => array(
        'is_back_button' => 1,
        'back_link' => '?dx=demo__flat',
        'BACK_NAME' => 'Back'
    ) ,

    'js' => ['is_top' => 1],

    //'flat_message'	=> 'Successfully Added',
    'prime_index' => 7,

    'message' => '(SELECT sn FROM entity WHERE id=option_single)',
    'is_save_form' => 1,

    'divider' => 'accordion',

    'is_field_id_as_token' => 1,

    #'avoid_trans_key_direct' => 1,

    'before_add_update' => 1,

    'show_query' => 0,
    #for debugging
		
	'session_off'=>1,
    
);

$F_SERIES['before_add_update'] = function ()
{

    global $rdsql, $G, $USER_ID;

    // check for new entity
    $lv = [];

    $lv['new_entity_code'] = $_POST['X22'];
    $lv['new_entity_sn'] = $_POST['X23'];

    if ((@$_POST['X7'] == - 1) && (strlen(@$_POST['X22']) == 2) && (strlen(@$_POST['X23']) > 0))
    {

        $lv['query'] = "INSERT INTO 
													entity(code,sn,is_lib,user_id) 
											VALUES
													('$lv[new_entity_code]','$lv[new_entity_sn]',0,$USER_ID)";

        $rdsql->exec_query($lv['query'], "Insert");

        $lv['new_entity_id'] = $rdsql->last_insert_id('entity');

        $_POST['X7'] = $lv['new_entity_id'];

    } // if new entity
    

}; // end




set_product(['rdsql'=>$rdsql,'f_series'=>$F_SERIES]);
	
	
// get product group
function set_product($param){
	
	global $F_SERIES;
	
	$lv = ['content'=>'','items'=>[],'counter'=>0];
	
	$lv['product_groups'] = $param['rdsql']->exec_query("SELECT get_exav_addon_text(id,'QCPG') as detail FROM entity_child WHERE entity_code='QC'",										   'Query');
	
	
	
	while($product_group_item=$param['rdsql']->data_fetch_assoc($lv['product_groups'])){
			
			$lv['item_detail']=json_decode($product_group_item['detail'],true);
			
			foreach($lv['item_detail'] as &$item){
				if($item[0]){
					$lv['counter']++;
					array_push($lv['items'],[$item[0],$item[1],0,0]);
				}
			}
			
			array_push($lv['items'],['Total',"","",""]);
			$lv['counter']++;
	}		
	
	$F_SERIES['data'][9]['default_data']=json_encode($lv['items']);
	$F_SERIES['data'][9]['default_rows_prop']= array('start_rows'=>$lv['counter'],'max_row'=>$lv['counter']);
	
} // end


/* if(@$_GET['trans_key'] && @$_COOKIE[@$_GET['trans_key']]){
	
	// get cookie message	
	$F_SERIES['temp']['message']= @$_COOKIE[@$_GET['trans_key']];
	
	// split message
	$F_SERIES['temp']['message_blocks'] = explode('block_pass:',$F_SERIES['temp']['message']);

	//set into content header
	$F_SERIES['header']	=	[ 'header_content'=> $F_SERIES['temp']['message_blocks'][1],
								   'header_style'  => 'alert alert-success'
								];
								
	// remove block
	setcookie($F_SERIES['temp']['trans_key'], time() - 3600);

	// remove form
	$F_SERIES['data']=[];

} // end  */

?>

<script>
 // cal total
        
    function cal_total(element) {
        
        var lv =new Object({});
        
        lv.pattern = /(\d+)(\_)(ft)(\_)(\d+)(\_)(\d+)/i;
        
        lv.element_in = element.id.match(lv.pattern);
        
        console.log(element.id);
        
        console.log(lv.element_in[5]);
        
        lv.row=element.id.replace(lv.pattern,function(m,p1,p2,p3,p4,p5,p6,p7,o,s){
                        
                    var temp_sum= new Array();
                    
                    temp_sum['c1']=0;
                    temp_sum['c2']=0;
                
                    var temp=new Object({ 'r':ELEMENT(p1+p2+p3+p4+'2'+p6+p7),
                             'q':ELEMENT(p1+p2+p3+p4+'3'+p6+p7),
                             't':ELEMENT(p1+p2+p3+p4+'4'+p6+p7),
                             
                            'c1_total':ELEMENT('5'+p2+p3+p4+'4'+p6+p7),
                           /* 'c2_total':ELEMENT('7'+p2+p3+p4+'3'+p6+p7),
                            'grand_total':ELEMENT('7'+p2+p3+p4+'4'+p6+p7) */
                    
                    });
                    
                    temp.t.value=Number(temp.r.value)*Number(G.isEmpty(temp.q.value,0));
                    
                   
                    
                    for(var c_index=1;c_index<=4;c_index++){
                    
                        console.log('E'+ELEMENT(c_index+p2+p3+p4+'2'+p6+p7).id+'='+ELEMENT(c_index+p2+p3+p4+'2'+p6+p7).value);
                    
                        temp_sum['c1']+=Number(G.isEmpty(ELEMENT(c_index+p2+p3+p4+'4'+p6+p7).value,0));
                       // temp_sum['c2']+=Number(G.isEmpty(ELEMENT(c_index+p2+p3+p4+'3'+p6+p7).value,0));
                        
                    }
                    
                    console.log('C1'+temp.c1_total.readonly);
                    
                    if (temp.c1_total.readonly!=true){
                        
                        temp.c1_total.readOnly=true;
                        //temp.c2_total.readOnly=true;
                       // temp.grand_total.readOnly=true;
                        
                        temp.c1_total.style='text-align:right;padding-right:7px;font-weight:bold;font-size:15px;color:#2364ce';
                       // temp.c2_total.style='text-align:right;padding-right:7px;font-weight:bold;font-size:15px;color:#2364ce';
                       // temp.grand_total.style='text-align:right;padding-right:7px;font-weight:bold;font-size:17px;color:#10a315;';
                    }
                    
                    temp.c1_total.value    = temp_sum['c1'];
                   // temp.c2_total.value    = temp_sum['c2'];
                   // temp.grand_total.value = Number(temp.c1_total.value)+Number(temp.c2_total.value);
                  
                    return 1;
                    
            });
        
    } // end
	
</script>