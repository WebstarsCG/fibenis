<?PHP

        $temp_config=[
                        "host"          =>   "localhost",
                        "db_name"       =>   "fibenis_live",
                        "user"          =>   "root",
                        "pass"          =>   "",
                        "db_engine"     =>  "rdsql_mysqli",
                        
                        "domain_name"   =>  "http://localhost/wa_dev/fibenis/nano",
                        "lib_path"      =>  "../lib/v_01/",
						
						//ldap
						"ldap"			=> ['host'			=> 'ldap://172.17.2.201',
											'port'			=>	389,
											'basedn'		=> 'dc=kalycito,dc=com',
											'usersdn'		=> 'ou=users',
											'exclude_users'	=> ['sa@webstarscg.com']											
										   ],						
                        
                        "is_smtp_mail"  =>  1,                            
                        "smpt_host"     =>  "",
                        "smpt_port"     =>  "465",
                        "smpt_secure"   =>  "ssl",
                        "smpt_mail"     =>  "",
                        "smpt_pswrd"    =>  "",
						
						"auth_type"		=> 'ldap',
                        
                        "to_admin"      =>  "ratbew@gmail.com",
                        "cc_mail"       =>  "",
                        "bcc_mail"      =>  "ratbew@gmail.com",
                        
                        "title"         =>  "Fibenis - An Adaptive Web Framework based on Communiction Patterns & Natural Language Principles",
                        "theme"         =>  "ml",
                        "theme_path"    =>  "../theme",
                        "theme_blend"   => "base",
                        
                        "engine"        => 'eav',
                        
                        "is_open"       => 0,
                        'avoid_gate'    => 0,
                        
                        "access_key"    => "fortknox",
                        
                        "is_multiple"   => 0,
                        "coach_path"    => "terminal/"
                ];

    
        // host
        // db_name
        // user
        // pass
        // db_engine
 
        // domain_name
        // lib_path
       
 
        // is_smtp_mail
        // smtp_host
        // smtp_port
        // smtp_secure
        // smtp_mail
        // smtp_pswrd
        // to_admin
        // cc_mail
        // bcc_mail
        
        // coach_path
        // theme_path
        // theme
        // theme_blend
        
        // engine(optional)
        
        // is_open
        // access_key
              
        
        // custom_theme_pages
?>