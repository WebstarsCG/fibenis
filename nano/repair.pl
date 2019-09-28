#! /usr/bin/perl -w

    BEGIN{        
	use lib 'perl';
	use lib '../../lib_v7/perl';
    }

    # System Modules
    
        #use strict;
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        use DBI;
        
        use Data::Dumper;
        
        use PHP::Session;
        
        use JSON::Any;
	
	#use PHP::Include (DEBUG => 1);
	
    
    # Custom Modules
        	
	use General;
    
    # Variables   
     
	my ($pv,$temp,$param);
    	
    # JSON Obj
    
        my $J       =  JSON::Any->new;
        
        # my $global  =  $J->decode(&get_file_content('global.txt'));
	
	
	
	#print $temp_config;
	#
	#my $global = $J->decode($temp_config);
	
	#my $global  =  {'db_name' => 'mmis_live',
	#		'host'    => 'localhost',
	#		'user'	  => 'root',
	#		'pass'    => '',
	#		'excel_path' => 'csv/'
	#		};
	
	my $global  =  {'db_name' => 'icms_2018',
			'host'    => 'localhost',
			'user'	  => 'root',
			'pass'    => '',
			'excel_path' => 'csv/'
			};
       
    # db connect
    
        my $dbh     =   DBI->connect('DBI:mysql:dbname='.$global->{'db_name'}.';host='.$global->{'host'}.'',$global->{'user'},$global->{'pass'});
	
	my $cdbh    =   DBI->connect ( "dbi:CSV:", "", "", {
					f_dir => "inc/data/config/",
					csv_tables       =>{
							       ea_enum   => { f_file   => "ea_enum.csv"   },
							       rel       => { f_file   => "rel.csv" },
							       idx       => { f_file   => "idx.csv" },
							       unq       => { f_file   => "unq.csv" },
							       len       => { f_file   => "len.csv" },
							       log       => { f_file   => "log.csv" },
							       parent    => { f_file   => "parent.csv" },
							       default   => { f_file   => "default.csv" },
							       setval     => { f_file   => "setval.csv" },
							       del_cols     => { f_file   => "del.csv" },
							    }
			});
        
      
    #  Content    
	$pv->{'content'} = '';
    
    # Content Type
    
    print "Content-type: text/html\n\n";    
    print "<html><head><title>DB Repair</title>
		      <style>body{ font-size:14px;font-family:Verdana;color:#454545;margin-top:350px; }
                              a{ text-decoration:none;color:#545454;}a:hover{ color:green; }  
                      </style></head>";
    print "<body>
            <div style='position:fixed;background-color:#fff;border-bottom:2px solid #242424;color:#919191;width:100%;top:0px;display:block;padding:25px;'>
		    <a href='?set=len'>1. Set Field Size</a>(Run it before import the data)<br><hr>
		    <a href='?clear=fk'>2. Clear Foriegn Keys</a><br>
		    <a href='?clear=idx_unq'>3. Clear Index & Unique Keys</a><br>
		    <a href='?set=engine'>4. Engine (InnoDB)</a><br>
		    <a href='?set=char_collate'>5. Char and Collation</a><br>		    
		    <a href='?set=ea_enum'>6. Set EA as enum</a><br>
		    <a href='?set=idx'>7. Set Index</a><br>
		    <a href='?set=default'>8. Set Default</a><br>
		    <a href='?set=rel'>9. Set Relation</a><br>
		    <a href='?set=log'>10. Log Table</a><br>
		    <a href='?set=setval'>11. Set Value</a><br>
		    <a href='?set=unq'>12. Set Unique</a>( Run it Finally )<br>
		    <a href='?unset=columns'>13. Delete Columns<br>	
		    <br><br>
		    <span>Data-> inc/data/config/</span>
	    </div>";    
    
	   
    
    # get param
    
    $param = &General::get_param_array_query($ENV{'QUERY_STRING'});
    
    ($temp->{'key'}) = keys(%{$param->[0]});
    
    $temp->{'action_key'} = $temp->{'key'}."_".$param->[0]->{$temp->{'key'}};
    
    # check array
    
    if (-f "perl/$temp->{'action_key'}.pl") {
	
	    # require
	    
	    do "perl/$temp->{'action_key'}.pl";
	    
	    # call action	    
	    print &action({'dbh'   => $dbh,
						'cdbh'  => $cdbh,
						'global'=> $global,
						'req'   => $param->[1]});
	    
	     print "<br><br><br><br>";
    } else{ # file
	
	    print " No action defined for $temp->{'action_key'}<br>" if($temp->{'action_key'}!~/\_/);
    }
    
    
    print "</body></html>";

    __END__
    
