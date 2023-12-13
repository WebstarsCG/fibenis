<?PHP

    $temp_config=[
        "host"          =>   "localhost",
        "db_name"       =>   "fibenis_live",
        "user"          =>   "root",
        "pass"          =>   "",
        "db_engine"     =>  "rdsql_mysqli",

        "domain_name"   =>  "http://localhost:8080/fibenis/",        
        "title"         =>  "Fibenis - An Adaptive Web Framework based on Communiction Patterns & Natural Language Principles",
        "lib_path"      =>  "lib/v_01/",

        "auth_type"		=> 'base', #base/ldap
        "is_open"       => 0,
        'avoid_gate'    => 0,
        'entry_gates'	=> '',
        "is_otp"		=> 0,
        "signup_user_role"=>'BAS',						

        "access_key"    => "fortknox",

        "ldap"			=> ['host'			=> '<ldap_address>',
                            'port'			=>	'<ldap_port>',
                            'basedn'		=> 'dc=<domain_name>,dc=com',
                            'usersdn'		=> 'ou=users',
                            'exclude_users'	=> [] # allow the user in base security											
                            ],	

        "is_smtp_mail"  =>  1, #0 for default PHP send_mail                           
        "smpt_host"     =>  "",
        "smpt_port"     =>  "",
        "smpt_secure"   =>  "ssl",
        "smpt_mail"     =>  "",
        "smpt_pswrd"    =>  "", 

        "to_admin"      =>  "<user_email>",
        "cc_mail"       =>  "",
        "bcc_mail"      =>  "<user_email>",

        "theme"         =>  "ml",
        "theme_path"    =>  "theme",
        "theme_blend"   =>  "base",

        "engine"        => 'eav',
        "is_multiple"   => 0,
        "coach_path"    => "terminal/"
    ];

?>