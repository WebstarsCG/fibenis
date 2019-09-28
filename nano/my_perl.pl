#! /usr/bin/perl -w

    BEGIN{
        
        use lib '../lib_v7/perl';
        use lib 'perl';
    }

    # System Modules
    
        #use strict;
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        use DBD::mysql;
        
        use Data::Dumper;
        
        use PHP::Session;
        
        use JSON::Any;
    
    # Custom Modules
    
        use Excel;
        
        use Masters_List;
        
        use DB;
	
	use General;
    
    
    # Variables
    
        our $E_SERIES;
	
	our $P_SERIES;
	
	our $K_SERIES;
        
        our $MASTER;
    
    # Param
    
        my $param = &General::get_param_from_query($ENV{'QUERY_STRING'});
	
    # JSON Obj
    
        my $J       =  JSON::Any->new;
        
        #my $global  =  $J->decode(&get_file_content('global.txt'));
	
	my $global  =  {'db_name'=>'webstarsdx_icmseavtest',
			'host'   =>'db119c.pair.com',
			'user'   => '1030551_13',
			'pass'   => 'i49P6McE'
		    };
       
    # db connect
    
        my $dbh     =  DBI->connect('DBI:mysql:dbname='.$global->{'db_name'}.';host='.$global->{'host'}.'',$global->{'user'},$global->{'pass'}) || &E_MESSAGE("DB error");
        
    # Master Obj
    
        $MASTER = new Masters_List();
        
        $MASTER->set_dbh($dbh);
    
    # DB
    
        my $D       = new DB();
        
        $D->set_dbh($dbh);
    
    # Session
    
   # my $S = PHP::Session->new($param->{'PASS_ID'},{'save_path'=>'../../../tmp' });
    
    # Header
    
    print "Content-type: text/html\n\n";
    
	#print $param->{'PASS_ID'}."--";
	
    my $report;
       
    $report    = &track_e_series($dbh,$param,$global->{'excel_path'}) if($param->{'e_series'});
    
    $report    =  &track_p_series($dbh,$param,$global) if($param->{'p_series'});
    
    $report    =  &track_k_series($D,$param,$global) if($param->{'k_series'});
   
    
    if($report->{'success'}){        
       
        # report log
        
        print '1:'.$report->{'file_path'}.':'.$report->{'name'};
        
        
        $D->insert({ 'table'=> 'report_created',
                           'data' => {
                               
                                   'report_id'  => $param->{'report_id'},
                                   'doc_detail' => $report->{'file_path'},
                                  # 'user_id'    => $S->get('user_id')
				    'user_id'    => 0
                           }                    
                   });
        
    } # report success 
    
   
    ############################################ functions ########################################################################################
   
    # set e_series
    
    sub track_e_series(){
        
        my $lv;
        
        $lv->{'dbh'}   = shift @_;
        
        $lv->{'param'} = shift @_;
        
        $lv->{'path'}  = shift @_;
                
        do "inc/data/e_series/".$param->{'e_series'}.".pl";
        
        $lv->{'e_series'} = $E_SERIES;
        
        return &Excel::make_report($lv);       
        
    } # e_series
    
    
    # set plugin
    
    sub track_p_series(){
        
        my $lv;
        
        $lv->{'dbh'}     = shift @_;
        
        $lv->{'param'}   = shift @_;
        
        $lv->{'global'}  = shift @_;
	
	$lv->{'key'}     = $param->{'p_series'};
        
	$lv->{time}      = &General::get_date_time({'time'=>time(),
						    'style'=>'file'});
	
        do "inc/data/p_series/".$lv->{'param'}->{'p_series'}.".pl";
	        
	return play($lv);
        
    } # e_series
        
	
    # k_series
    
     # set plugin
    
    sub track_k_series(){
        
        my $lv;
	
	use KG_abc;	
        
        $lv->{'d'}     = shift @_;
        
        $lv->{'param'}   = shift @_;
        
        $lv->{'global'}  = shift @_;
	
	$lv->{'key'}     = $param->{'k_series'};
        
	$lv->{time}      = &General::get_date_time({'time'=>time(),'style'=>'file'});
	
	$K_SERIES->{'req'} = $lv;
	
        do "inc/data/k_series/".$lv->{'key'}.".pl";
	        
	&KG_abc::create($K_SERIES->{'page'},
		        $K_SERIES->{'header'},
		        $K_SERIES->{'data'});
	
	return{'success'	=> 1,
	       'file_path'	=> $K_SERIES->{'page'}->{'file_name'},
	       'report_name'	=> $lv->{'key'}
	}
	
        
    } # k_series
    
    

    	

    
    

    