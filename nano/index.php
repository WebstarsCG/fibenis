<?PHP
    
    # config            
    include("YfSLT9CRm55cBPGH.php");
    
    # engine    
    $ENGINE = get_config('engine');    
    $ENGINE = ($ENGINE)?$ENGINE:'abc';               
                    
    # load    
    include(get_lib_path()."engine/$ENGINE/outer.php");
        
?>