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

            'allow' => 'd10[.]',

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

            'input_html' => 'class="w_200" onchange="check_new_entity(this);"',

            'avoid_default_option' => 0,

        ) ,

        '22' => array(
            'field_name' => 'New Entity code',
            'field_id' => 'option_code',
            'type' => 'text',
            'allow' => 'w2=',
            'is_hide' => 1,
            'ro' => 1,
            'is_mandatory' => 1,
            'input_html' => 'class="w_50 txt_case_upper" onchange="check_entity_code(this);"',
        ) ,

        '23' => array(
            'field_name' => 'New Entity name',
            'field_id' => 'option_sn',
            'type' => 'text',
            'allow' => 'x16',
            'is_hide' => 1,
            'ro' => 1,
            'iis_mandatory' => 1
        ) ,

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
                    'column' => 'DoB',
                    'width' => '50',
                    'type' => 'date',
                ) ,
            )

        ) ,

        '10' => array(
            'field_name' => 'Date',

            'field_id' => 'date_flat',

            'type' => 'date',

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

        ) ,

        '19' => array(
            'field_name' => 'Radio',

            'field_id' => 'radio',

            'type' => 'radio',

            'is_mandatory' => 0,

            'options' => $G->radio_option_builder(['table' => 'entity_child_base', 'field_label' => 'ln', 'field_value' => 'id', 'where' => " WHERE entity_code='GN'"]) ,

            'input_html' => ' class="w_200"  style="height:100px !important"  ',

            'is_mandatory' => 1

        ) ,

        '20' => array(
            'field_name' => 'Checkbox',

            'field_id' => 'checkbox',

            'type' => 'checkbox',

            'is_mandatory' => 0,

            'options' => [['label' => 'PHP',
            'value' => 'PH'],
            ['label' => 'Python',
            'value' => 'PY'],
            ['label' => 'Android',
            'value' => 'AN']],

            'is_multistate' => 0,

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

    'is_user_id' => 'user_id',

    # Communication
    'back_to' => array(
        'is_back_button' => 1,
        'back_link' => '?dx=demo__flat',
        'BACK_NAME' => 'Back'
    ) ,

    'js' => ['is_top' => 1,
    'top_js' => 'def/demo/flat/fx'],

    //'flat_message'	=> 'Successfully Added',
    'prime_index' => 7,

    'message' => '(SELECT sn FROM entity WHERE id=option_single)',
    'is_save_form' => 1,

    'divider' => 'accordion',

    'field_id_as_token' => 1,

    'avoid_trans_key_direct' => 1,

    'before_add_update' => 1,

    'show_query' => 0
    #for debugging
    

    
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

?>
<style>


</style>
