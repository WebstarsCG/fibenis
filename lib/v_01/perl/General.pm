package General;

        use File::stat;

        sub get_list_of_files(){
                        
                my (%l_v,@list_files,@tmp_files,$file_search);                
                
                $l_v{'param'} = shift @_;
                
                # scalar
                
                if( ($l_v{'param'}->{'process_files'}) && (scalar(@{$l_v{'param'}->{'process_files'}})>0)){
                
                         @list_files = @{$l_v{'param'}->{'process_files'}};                
                        
                }else{  # act on all files in the directory
                        
                         
                        # Here open the directory
                
                        opendir ( DIR, $l_v{'param'}->{'process_in'} ) || die "Error in opening dir $l_v{'param'}->{'process_in'} \n";
                
                            while( ($l_v{filename} = readdir(DIR))){  
                               
                                        push (@list_files,$l_v{filename});
                               
                            }
                    
                        closedir(DIR);   
                    
                        @list_files = sort(@list_files); 
                            
                        shift(@list_files);     # Remove Dots
                    
                        shift(@list_files);     # Remove Double Dots                        
                        
                } # end                
                
                return \@list_files;
        
    } # get list of files
        
    
    # Delete Files
    # [ {file_list=>'', cut_off_time=>''} ]
    
    sub file_clean_action(){
        
        my @file_group = @{shift @_};
        
        my %l_v;
        
        $l_v{'current_time'} = time();
        
      
        
        for my $member_info (@file_group){
            
            # cutoff time
            
            $l_v{'cutoff_time'}  = $member_info->{'cutoff_time'};
            
            for my $file_name (@{$member_info->{'file_list'}}){
                
                
                $l_v{'file_with_path'} = $member_info->{'process_in'}.$file_name;
                                
                $l_v{'file_info'}      = stat($l_v{'file_with_path'});
                
                if( ($l_v{'current_time'}-$l_v{'file_info'}->mtime) > $l_v{'cutoff_time'} ){
                    
                    unlink($l_v{'file_with_path'});
                                        
                } # end
            
            }  #end
            
        } # end        
        
    } # unlink files
    
       sub get_time(){
        
            return 10;
        
       }
       
        ###############################################################################################
        #  i/p -> 02-Jun-2012 10:10                                                                   #
        #  o/p -> 2012-06-02 10:10:00								      #
        ###############################################################################################
		
        sub get_datetime_picker_to_pg(){
                
                my $lv;
                
                $lv->{'param'}       = shift @_;   
                
                $lv->{'month_short'} ={'1'=>'jan',
                                        '2'=>'feb',
                                        'mar' =>3,
                                        'apr' =>4,
                                        'may' =>5,
                                        'jun' =>6,
                                        'jul' =>7,
                                        'aug' =>8,
                                        'sep' =>9,
                                        'oct' =>10,
                                        'nov' =>11,
                                        'dec' =>12};
                                
                @{$lv->{matches}}=$lv->{'param'}=~m/(\d+)(\-)(\w+)(\-)(\d+)(\s+)(\d+)(\:)(\d+)/ig;
                 
               # return $lv->{matches}->[4];
                 
                return $lv->{'matches'}->[4].'-'.$lv->{'month_short'}->{lc($lv->{'matches'}->[2])}.'-'.$lv->{'matches'}->[0].' '.$lv->{'matches'}->[6].':'.$lv->{'matches'}->[8].':00';
                                                
        } # end
       

        # data to csv
        
        ####################### Graph CSV File Save ##########################
          
          
        sub data_to_csv(){

                    my (%l_v,$values);
                    
                    $l_v{'param'}           = shift @_;                 
                    
                   # $l_v{'period'}          = $P_V{'image_id'};
                    
                    open (FH, ">../csv/".$l_v{'param'}->{'file_name'}) or die "$!";
                    
                    
                    $values=$l_v{'param'}->{'title'}."\n\n";
                    
                    
                    for my $label(@{$l_v{'param'}->{'columns'}}){
                        
                              $values.=$label.',';      
                    }
                    
                    $values.="\n";
                    
                    # Data
                    
                    $l_v{'row_length'} = (scalar(@{$l_v{'param'}->{'data'}})-1);
                    
                    $l_v{'column_length'} = (scalar(@{$l_v{'param'}->{'data'}->[0]})-1);
                    
                    for my $row(0..$l_v{'row_length'}){
                           
                            for my $column(0..$l_v{'column_length'}){
                                
                                $values.=$l_v{'param'}->{'data'}->[$row]->[$column].','; 
                                
                            } # each row
                            
                            $values.="\n";
                            
                    } # end
                    
                    #for my $column(0..$l_v{'column_length'}){
                    #       
                    #        for my $row(0..$l_v{'row_length'}){
                    #            
                    #            $values.=$l_v{'data'}->[$row]->[$column].','; 
                    #            
                    #        } # each row
                    #        
                    #        $values.="\n";
                    #        
                    #} # end                    
                    
                    print FH "$values\n"; 
                    
                    close(FH);                 
           
                    return $l_v{'param'}->{'file_name'};
           
        } # end of graph csv
        
        
        ##########################################################################################
	##											##	
	##	Name		: get_date_time							##
	##											##
	##											##
	##	Description	: return date time with style format	 			##
	##			:								##
	##											##
	##	Input		: hasfref {'time'=>time(),'style'=><style_type>}		##
	##											##
	##	Return		: 								##	
	##			: 								##
	##			:								##
	##	Example i#p	: get_date_time({'time'=>time(),'style'=>'file'})		##
	##											##
	##	Example	o#p	: 01_Sep_2014_10hr_10mi_10se					##
	##											##
	##			:								##
	##											##
	##	Creation	: 26-Jul-2012							##
	##											##
	##	Modification	:								##
	##											##
	##########################################################################################
	
	sub get_date_time(){
                    
			my ($lv,$t,$style,$param);
			
			$param                  = shift @_;
			
			# $t -> time
			
			$lv->{'custom'}         = (($param->{'year'}) || ($param->{'month'}))?1:0;
			
			$lv->{'year'}           = $param->{'year'} || 1900;
			
			$lv->{'month'}          = $param->{'month'} || 1;
			
			# if no custom
			  
			$lv->{'timestamp'}      = $param->{'time'} || time() if(!$lv->{'custom'});
			
			$lv->{'style'}          = $param->{'style'} || 'file';
			
					
			$lv->{'month_short'}  = {'01'=>'Jan',
						  '02'=>'Feb',
						  '03'=>'Mar',
						  '04'=>'Apr',
						  '05'=>'May',
						  '06'=>'Jun',
						  '07'=>'Jul',
						  '08'=>'Aug',
						  '09'=>'Sep',
						  '10'=>'Oct',
						  '11'=>'Nov',
						  '12'=>'Dec'};
        
			#  style
			
			$style->{'file'} = sub(){
					
					my $t = shift @_;
				
					
				
					return "$t->{day}_$t->{month_short}_$t->{year}_$t->{hour}hr_$t->{min}mi_$t->{sec}se";					
			};
			
						
			if ($lv->{'style'}!~m/file/) {
				
				$style->{$lv->{'style'}} = sub(){					
					my $t = shift @_;					
					return $t->{$lv->{'style'}};					
				};
				
			} # end
			
		       ($t->{'sec'},
			$t->{'min'},
			$t->{'hour'},
			$t->{'day'},
			$t->{'mon'},
			$t->{'year'}) = ($lv->{'custom'})?&get_local_time({'year'=>$param->{'year'},
									    'month'=>$param->{'month'}}):localtime($lv->{'timestamp'});
	
			$t->{'year'}   = $t->{'year'}+1900;
			
			$t->{'mon'}    = $t->{'mon'}+1;
			 
			
			$t->{'day'}    = sprintf("%02d",$t->{'day'});
			 
			$t->{'mon'}    = sprintf("%02d",$t->{'mon'});
			 
			$t->{'month_short'}    = $lv->{'month_short'}->{$t->{'mon'}};
			 
			
			 
			return $style->{$lv->{'style'}}->($t);
		    
        } # end utc_to_iso
        
        
        # get max date
	
	sub get_max_date(){
              
            my %l_v             = %{shift @_}; 
     
            $l_v{'last_time'}   = POSIX::mktime(0,0,0,0,$l_v{'month'},($l_v{'year'}-1900),0,0,-1);
                 
            @_                  = localtime($l_v{'last_time'});
                 
            return  $_[3];
            
        } # end
           
	   
	# get date time
	
	sub get_local_time(){
              
            my %l_v             = %{shift @_}; 
     
            $l_v{'last_time'}   = POSIX::mktime(0,0,0,1,($l_v{'month'}-1),($l_v{'year'}-1900),0,0,-1);
                 
            return localtime($l_v{'last_time'});
            
        } # end
	
	
	# get
	
	# get_param_from_query($ENV{"QUERY_STRING"})
    
	sub get_param_from_query(){
	    
	    my ($lv,$temp);
	    
	    $lv->{'param'}          = shift @_;
	    
	    @{$lv->{'value_pairs'}} = split(/&/,$lv->{'param'});
	    
	    # each pair
	    
	    foreach my $key_value(@{$lv->{'value_pairs'}}){
		
		($lv->{'key'},$lv->{'value'}) = split(/=/,$key_value);       
		
		$temp->{$lv->{'key'}}         = $lv->{'value'};
	    }
	    
	    return $temp;
	    
	} # end
	
	# 
	sub get_param_array_query(){
	    
	    my ($lv,$temp,@result);
	    
	    $lv->{'param'}          = shift @_;
	    
	    @{$lv->{'value_pairs'}} = split(/&/,$lv->{'param'});
	    
	    # each pair
	    
	    foreach my $key_value(@{$lv->{'value_pairs'}}){
		
		($lv->{'key'},$lv->{'value'}) = split(/=/,$key_value);       
		
		push(@result,{$lv->{'key'}=> $lv->{'value'}});
	    }
	    
	    return \@result;
	    
	} # end

1;
