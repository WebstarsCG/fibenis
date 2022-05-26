#!/usr/bin/perl -w

        package Master_List_Data;
	
	BEGIN{            
	   #do "begin.pl";  
        }

	my %TEMP;
      
    
        my %IN_DATA=(
            
                    # Account Divison
                
                    'TEST'=>{'id'=>'id','name'=>'sn','tn'=>'TEST','od'=>'sn'},
                       
                    # User Role
                    
                    'CONTACT_GROUP' =>  {'id'      => 'code',
                                         'name'    => 'get_ea(code,\'sn\')',
                                         'tn'      => 'entity_attribute',
                                         'where'   => 'WHERE entity_code=\'CG\'',
                                         'od'      => 'sn'},
					# DSR
					
					'DSR'          =>  {'id'      => '(SELECT sn FROM communication WHERE id=comm_id)',
                                         'name'    => '(SELECT sn FROM communication WHERE id=comm_id)',
                                         'tn'      => 'hr_addon',
                                         'where'   => 'WHERE hr_role_code=\'DSR\' AND net_sales <> 0 ',
                                         'od'      => 'sn'},
					# Fin Year
					
					
                    'FINANCE_YEAR'=>{'id'=>'id',
                                     'name'=>'concat(start_year\'-\'end_year)',
                                     'tn'=>'finance_year',
                                    }
                    
                        
        );


        # get id anme data     
        sub Get(){ return $IN_DATA{shift @_};  };

   


        1;
