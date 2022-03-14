<?PHP

    include("$LIB_PATH/def/ecb_parent_child/f.php");
    
    //defaults
    $F_SERIES['title']        = 'Definition';
    
    $F_SERIES['temp']['DFTY'] =  'INT'; // Internal
    
    # option data
    
    $F_SERIES['data']['1']['option_data']=$G->option_builder('entity','code,sn'," WHERE code='DF' ORDER by sn ASC");
                                      
    $F_SERIES['data']['2']['field_id'] = 'sn';
    
    $F_SERIES['data']['3']['field_id'] = 'ln';
                                             
    $F_SERIES['data']['6']['field_name'] = 'Definition';
    
    // Column 7
    
    $F_SERIES['data'][7] = ['type'      =>'heading',
                            'field_name'=>'User Role Access'];
    
    $F_SERIES['data'][8] = ['type'         => 'list_left_right',
                            'field_name'   => 'User Role Access',
                            'field_id'     =>"'2,4'",								    
                            
                            'option_data'  => $G->option_builder("user_role","id,ln","WHERE sn <> 'ANY' ORDER BY ln ASC"),                            
                            'input_html'   => ' class="w_200" rows="2"  style="height:200px !important"  ',
                            'ro'        => 1
                        ];
    
    
    //$F_SERIES['back_to']['back_link']    = '?d=def';
    
    $F_SERIES['show_query']=0;
    $F_SERIES['avoid_trans_key_direct']=1;
    
    $F_SERIES['default_fields']=array('dna_code'=>'EBDF');
    $F_SERIES['divider']       = 'tab';
      
    // unset  
    unset($F_SERIES['data'][4]);
    
    # customization
    $F_SERIES['temp']['engines']          = array("'d'","'f'","'t'","'a'");
    $F_SERIES['data']['5']['field_name']  = 'Engines';
    $F_SERIES['data']['5']['option_data'] = $G->option_builder('entity_child_base',
                                                               'id,sn',
                                                               "  WHERE entity_code='EG' AND token IN(".implode(',',$F_SERIES['temp']['engines']).")");
    
    
    // during edit
    if(@$_GET['key']){
        
        $F_SERIES['temp']['key']=@$_GET['key'];
        
        $F_SERIES['data'][8]['field_id']="'".$G->get_one_column(['table'       =>'user_role_permission_matrix',
                                                                 'field'       =>$DC->group_concat('DISTINCT user_role_id'),
                                                                 'manipulation'=>" WHERE user_permission_id IN(SELECT ecb_matrix.id FROM ecb_parent_child_matrix as ecb_matrix WHERE ecb_parent_id=".$F_SERIES['temp']['key'].")"
                                                                ])."'";
        
    } // end
    
    use GuzzleHttp\Client;
    use GuzzleHttp\Query;
    
    // after_add_update    
    $F_SERIES['after_add_update']=function ($key_id){
        
        global $DC,$G,$rdsql,$USER_ID,$F_SERIES,$LIB_PATH;
        
        $lv;
        $lv['content'] =[];
        $lv['def_type']=$F_SERIES['temp']['DFTY'];
                
        # update def        
        $rdsql->exec_query("UPDATE entity_child_base SET token=md5(sn) WHERE id=$key_id","0");
        
        # def type
            # delete old
            $rdsql->exec_query("DELETE FROM ecb_av_addon_varchar WHERE parent_id=$key_id AND ea_code='DFTY'","DEL FAILED");
            
            #insert type
            $rdsql->exec_query("INSERT INTO ecb_av_addon_varchar(parent_id,ea_code,ea_value,user_id) VALUES($key_id,'DFTY','$lv[def_type]',$USER_ID)","INSERT");
                
        # empty matrix        
        $rdsql->exec_query("DELETE FROM ecb_parent_child_matrix WHERE ecb_parent_id=$key_id","0");
        
        # insert data
        
        $lv['temp_options'] = $_POST['X5'];
       
        if($lv['temp_options']){
        
            foreach(preg_split("/,/",$lv['temp_options']) as $key){
                
                array_push($lv['content'],"($key_id,
                                            $key,
                                            md5(concat((SELECT sn FROM entity_child_base WHERE id=$key_id),'__',
                                            (SELECT token FROM entity_child_base WHERE id=$key))),
                                            $USER_ID)");
                // 
                
            }
            
        } // end
        
        if(count($lv['content'])>0){
            
            $lv['matrix_data'] = implode(',',$lv['content']);
            
            $lv['matrix_query'] = " INSERT INTO ecb_parent_child_matrix(ecb_parent_id,ecb_child_id,parent_child_hash,user_id) VALUES $lv[matrix_data] ";
            
            $rdsql->exec_query($lv['matrix_query'],$lv['matrix_query']);
            
            //def child id
            
            $lv['def_child_id_query'] = " SELECT".$DC->group_concat('id')." FROM ecb_parent_child_matrix WHERE ecb_parent_id=$key_id";
            
            $lv['def_child_id_text']       = $G->get_one_column(['field'        => $DC->group_concat('id'),
                                                           'table'        => 'ecb_parent_child_matrix',
                                                           'manipulation' => " WHERE ecb_parent_id=$key_id" ]);
            
        } // end
        
        
        // Role        
        $lv['temp_user_role_access'] = $_POST['X8'];
                
        if($lv['temp_user_role_access'] && $lv['def_child_id_text']){
            
            $lv['def_child_ids'] = explode(',',$lv['def_child_id_text']);
         
            // each user
            foreach(preg_split("/,/",$lv['temp_user_role_access']) as $user_role_id){
                
                $lv['user_role_perm_content'] = [];
            
                // def child ids
                foreach($lv['def_child_ids'] as $def_child_id){
                
                    array_push($lv['user_role_perm_content'],"($user_role_id,
                                                               $def_child_id,
                                                               $USER_ID)");
                } // def
                
                // user role permission insert
                
                 if(count($lv['user_role_perm_content'])>0){
            
                    $lv['user_role_perm_query_values'] = implode(',',$lv['user_role_perm_content']);
                    
                    $lv['user_role_perm_query']        = " INSERT INTO user_role_permission_matrix(user_role_id,
                                                                                                   user_permission_id,
                                                                                                   user_id)
                                                                    VALUES
                                                                         $lv[user_role_perm_query_values] ";
                    
                    // user role permission matrix
                    $rdsql->exec_query($lv['user_role_perm_query'],"User Role Permission Matrix");
                    
                    // user role permission combine text
                    $rdsql->exec_query("UPDATE
                                                user_role_permission
                                        SET
                                                user_permission_ids=(SELECT ".$DC->group_concat('user_permission_id')." FROM user_role_permission_matrix WHERE user_role_id=$user_role_id)","User Role Permission Matrix Combine");
                    
                } // if user role permission                
                
            } // user role
            
        } // if role & def child
        
        // def creation
        if(($F_SERIES['temp']['DFTY']=='YOU') &&
           ($_POST['X9'])){
            
            // create dir
			
			$str_rplce = str_replace('__','/',$_POST['X2']);
			$lv['def_path']    = 'def/'.$str_rplce;
			 
			 
           // $lv['def_path']    = 'def/'.$_POST['X2'];
            $lv['entity_code'] = $_POST['X9'];
            
            echo 'DIR'.var_dump(is_dir($lv['def_path']));
            
            echo $lib = $LIB_PATH.'/comp/guzzle_rest/vendor/autoload.php';				

            require_once $lib ;
		  
            $client = new Client(['timeout'  => 2.0,]);
                        
            if(!is_dir($lv['def_path'])){
                mkdir($lv['def_path']);
                   
                    // def
                    auto_def_creation(['def_name'    => $_POST['X2'],
                                       'def_path'    => $lv['def_path'],
                                       'entity_code' => $lv['entity_code'],
                                       'client'      => $client,
                                       'g'           => $G   
                                       ]);
                                                     
            }
            
        } // end
        
        
    }; # end
    
    
    // auto def creation
    // param -(path,entity_code,client)
    function auto_def_creation($param){
        
            $lv = [];
        
            $lv['client']       = $param['client'];
            $lv['g']            = $param['g'];
            unset($param['client']);
            unset($param['g']);
        
            $lv['req']         	= json_encode($param);
		    
            $lv['trans_key']    = time().rand().$PASS_ID;
		    
            $lv['temp_req']     = $lv['g']->encrypt($lv['req'],$lv['trans_key']);
		   
            $node_res_form      = $lv['client']->GET($_SERVER["REQUEST_SCHEME"].'://'.$_SERVER["HTTP_HOST"].$_SERVER["SCRIPT_NAME"],
                 
                                                        [   'query'     => ['t' => 'def__entity_auto__form',
                                                                            'req'       => $lv['temp_req'],
                                                                            'trans_key' => $lv['trans_key']]
                                                        ]
                                                    );
            
            // desk
            
            $node_res_desk      = $lv['client']->GET($_SERVER["REQUEST_SCHEME"].'://'.$_SERVER["HTTP_HOST"].$_SERVER["SCRIPT_NAME"],
                 
                                                        [   'query'     => ['t' => 'def__entity_auto__desk',
                                                                            'req'       => $lv['temp_req'],
                                                                            'trans_key' => $lv['trans_key']]
                                                        ]
                                                    );
            
            //print_r($lv);
            //echo $node_res->response();
            
    } // ends
    
?>