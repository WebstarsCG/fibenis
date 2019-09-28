#!/usr/bin/perl -w
        
        package Excel;
        
        use Spreadsheet::WriteExcel;
        
        use Data::Dumper;
	
	use List::Util qw(sum);
	
	use List::MoreUtils qw(uniq);
        
        use General;
        
        
    # Page Variable
        
        my %P_V;
        

        sub make_report{
                
                my (%l_v,$param,$e_series,$path,$get,$summary,$custom_format);
                
                %l_v                = %{shift @_};
                
                $param              = $l_v{'param'};
                
                $e_series           = $l_v{'e_series'};
                
                $path               = $l_v{'path'};
		
		$get		    = $e_series->{'set'};
		
		$custom_format      = {};
		
		print "e_series ".Dumper($e_series) if($param->{'is_debug'}==1);
		
		print "Param ".Dumper($param) if($param->{'is_debug'}==1);
		
		$summary->{'data'}->{'total'}={};
                
                # pre set
                
                $l_v{time}          = &General::get_date_time({'time'=>time(),
							       'style'=>'file'});
                # Columns
                
                $e_series->{'dynamic_column'}->($l_v{'dbh'},
						$param,
						$e_series->{'data'},
						$e_series) if($e_series->{'dynamic_column'});        
                
		# Title
		
		$l_v{'heading'}     = $e_series->{'title'};
		
                
                $l_v{'col_length'}  = (scalar(@{$e_series->{'data'}})-1);                
                
                # Table
                 
                $l_v{'table'}         = ($e_series->{'table'})? ' FROM '.$e_series->{'table'}:'';
                
                # Where filter
                
                $l_v{'where_filter'}  = ($e_series->{'where_filter'})?" WHERE 1=1 ".$e_series->{'where_filter'}->($param,$e_series,$l_v{'dbh'}):'';
                                                
                # Group list
                
                $l_v{'group_list'}  = $e_series->{'group'}->{'list'};
						
		$l_v{'group_column'}= $e_series->{'group'}->{'column'};
		
		# group inline
		
		$l_v{'group'}	    = $e_series->{'group'};
                
                $l_v{'type'}        = ($param->{'group_type'})?$param->{'group_type'}:0;
		
		#return (single/multiple) with column index
		
		@{$l_v{'dynamic_group'}}=$l_v{'type'}=~m/^(S|M)(\d+)/ig;
		
		# order check
		
		if ($e_series->{'order'}){		
		
			$e_series->{'old_order'}=$e_series->{'order'};
		
			$e_series->{'old_order'}=~s/(ORDER\s+BY)//i;
		
		} # order
		
		$e_series->{'order'} = ($l_v{'dynamic_group'}->[1])? ' ORDER BY '.$e_series->{'data'}->[$l_v{'dynamic_group'}->[1]]->{'field'}.
		                                                                (($e_series->{'old_order'})?','.$e_series->{'old_order'}:''):$e_series->{'order'};
		
                $l_v{'file_name'}   = $param->{'e_series'}.'_'.$l_v{time}.".xls";
                
                $l_v{'excel_file'}  = $path.$l_v{'file_name'};
				
		$l_v{'group'}->{'outline'} = ($l_v{'group'}->{'outline'})?$l_v{'group'}->{'outline'}:$param->{'outline'};
		
		# counter
		
		$get->{'final_row_counter'}->{'counter_idx'} = ($l_v{'group'}->{'final_row_counter'}-1) if($l_v{'group'}->{'final_row_counter'});
		
		# Setup
     
        # here we create a excel        
                
                my $workbook        = Spreadsheet::WriteExcel->new($l_v{'excel_file'}) or die "unable to open ";            
      
        
        # here we define the excel format
        
                
                my $report_heading_format       = $workbook->add_format(
                                                        font    =>'Tahoma',
                                                        bold    => 1,
                                                        color   => 'black',
                                                        size    => 13,
                                                        merge   => 1,
                                                        align  => 'vcenter',
                                                        );
                
                my $group_format                = $workbook->add_format(
							
                                                        font    => "Tahoma",
                                                        bold    => 1,
                                                        color   => "black",
                                                        size    => 10,
                                                        merge   => 1						
                                                        );
		
		$group_format->set_align('left');
		#$group_format->set_bg_color('yellow');
                
                my $title_format                = $workbook->add_format(
                                                        font    => "Tahoma",
                                                        bold    => 1,
                                                        color   => "black",
                                                        size    => 8,
                                                        merge   => 1,
                                                        );
                
		my $summary_total_format                = $workbook->add_format(
							font    => "Tahoma",
							align  => 'right',
							bold    => 1,
							color   => "black",
							size    => 9,
							merge   => 1);
		
		$summary_total_format->set_num_format('0.00');
		
		
                my $group_title_format          = $workbook->add_format(
                                                        font    => "Tahoma",
                                                        bold    => 1,
                                                        color   => "black",
                                                        size    => 9,
                                                        merge   => 1
                                                        );
          
		# final roe format
          
		 my $final_row_format          = $workbook->add_format(
                                                        font    => "Tahoma",
							align  => 'left',
                                                        bold    => 1,
                                                        color   => "black",
                                                        size    => 9,
                                                        merge   => 1
                                                        );
		 
		my $final_row_right_format      = $workbook->add_format(
							font    => "Tahoma",
							align  => 'right',
							bold    => 1,
							color   => "black",
							size    => 9,
							merge   => 1
							);
	    
		my $row_format                = $workbook->add_format(
							
                                                        font    => "Tahoma",                                                      
                                                        color   => "black",
                                                        size    => 10		
                                                        );
		
		
		# set custom formats
	    
		$custom_format			=$e_series->{'format'}->($workbook) if($e_series->{'format'});
	    
        # DB Data Manipulation through query
        
               # query
               
               $l_v{'fields'} = '';
               
                foreach my $temp (@{$e_series->{'data'}}){
                        
                        $l_v{'fields'}.=$temp->{'field'}.',';
                        
                } # end
        
                chop($l_v{'fields'});
                
                $l_v{'query'} = "SELECT $l_v{'fields'} $l_v{'table'}  $l_v{'where_filter'} $e_series->{'order'}"; 
                
                print "Query ".$l_v{'query'} if($param->{'is_debug'}==1);
        
                my $records = $l_v{dbh}->selectall_arrayref($l_v{query}) or print "Error ".$l_v{dbh}->errstr();
                
		print "Scalar ".scalar(@{$records})."==" if($param->{'is_debug'}==1);
		
                print "Records ".Dumper($records) if($param->{'is_debug'}==1);
		
		# Dynamic grouping
		
		print "Dynamic group column ".$e_series->{'group'}->{'inline'} if($param->{'is_debug'}==1);
		
		if($l_v{'group'}->{'inline'}){
			
			#$l_v{type} = 1;
			
			$l_v{'group_list_temp'}='';
			
			for(@{$records}){
				
				push(@{$l_v{'group_list_temp'}},$$_[$l_v{'group'}->{'column'}]);
				
			} # end
			
			@{$l_v{'group_list_temp'}}=uniq @{$l_v{'group_list_temp'}};
						
			# build unique
			
			$l_v{'group_counter'} = 1;
			
			for(@{$l_v{'group_list_temp'}}){
				
				$l_v{'id_filter'}=$_;
				
				$l_v{'ff_filter'}=$_;
				
				$l_v{'ff_filter'}=~s/(\\|\/|\?|\+|\s)/_/ig;
				
				$l_v{'id_filter'}=~s/(\W|\s)//g;
				
				$l_v{'ff_filter'}=$l_v{'group_counter'}.".".$l_v{'ff_filter'};
				
				push(@{$l_v{'group_list'}},
				     {'ID'=>$l_v{'id_filter'},
				      'FF'=>substr($l_v{'ff_filter'},0,31),
				      'NAME'=>$_});
				
				$l_v{'group_counter'}++;
				
			} # end
			
			
			print "Dynamic group ".Dumper($l_v{'group_list'}) if($param->{'is_debug'}==1);

		} # end
                
        # Here  '1' condition get from (FILTER_ID) single sheet group
        
                if($l_v{type}=~m/^S(\d*)/ig){
                
                        $l_v{work_sheet}    = $workbook->add_worksheet($e_series->{'title'});
                        
                # Here we assign  the format of the excel sheet     
                        
                        $l_v{'col'} = 0;
			
			$l_v{'group_row'}   = 1;
			
			$l_v{'group_count'} = 0;
                        
                        foreach my $temp (@{$e_series->{'data'}}){
                            
                             $l_v{work_sheet}->set_column($l_v{'col'},0,$temp->{width});
			     
			     # default filter
			     
			     $e_series->{'data'}->[$l_v{'col'}]->{'filter_out'}=sub(){ return $_[0]; } if(!$temp->{'filter_out'});
			     
			     # default format act
			     
			     $e_series->{'data'}->[$l_v{'col'}]->{'format_act'}=sub(){ return $_[0]; } if(!$temp->{'format_act'});
			     
			     push(@{$summary->{'is_total'}},$l_v{'col'}) if($temp->{'is_total'});
                            
                             $l_v{'col'}++;
                        }
			
			# title once
			
			if ($l_v{'group'}->{'title_once'}){
					
					$l_v{row}++; 
								
					# Column fields
					
					$l_v{col} = 0;
					
					foreach my $temp (@{$e_series->{'data'}}){
					       
					    $l_v{work_sheet}->write($l_v{row},$l_v{col},$temp->{name},$title_format);
					    
					    $l_v{col}++;
					}
					
					# freeze pane
					
					freeze_panes({'work_sheet'=>$l_v{work_sheet},
						      'row'=>($l_v{row}+1),
						       'get'=>$get
						      });
			}else{
					# freeze pane
					freeze_panes({'work_sheet'=>$l_v{work_sheet},
						      'row'=>($l_v{row}+1),
						       'get'=>$get
						      });
			}
                                                
                # Write Report Heading
		
			# $l_v{'group_inline'}, inline group		
                        
                        $l_v{work_sheet}->merge_range(0,0,0,$l_v{'col_length'},$l_v{heading},$report_heading_format);                        
                        
                        print "Group ".Dumper($l_v{'group_list'}) if($param->{'is_debug'});						
						
                        for my $group_info(@{$l_v{group_list}}){                               
                              
                                $l_v{col} = 0;
				
				$l_v{'group_records'}=[];
				
				$l_v{'show_records'} =[];
				
				$l_v{'final_row'}    =[];
				
				$l_v{'group_records'} = &get_group_matches($group_info,
									   $l_v{'group_column'},
									   $records);
				
				# Records
				
				$l_v{'num_of_rows'} = scalar(@{$l_v{'group_records'}});
				
				print "Group Record Rows".$l_v{'num_of_rows'}.'<br>' if($param->{'is_debug'});
				
				# Ignore rou
				
				if($l_v{'num_of_rows'}){
					
						# if not final only
						if (!$l_v{'group'}->{'is_final_only'}){
							
							$l_v{row}++;
						
							$l_v{'group_head_row'} = $l_v{row};
							
							# merge disables
							$l_v{work_sheet}->merge_range($l_v{row},$l_v{col},$l_v{row},$l_v{'col_length'},$group_info->{NAME},$group_format);
							#$l_v{work_sheet}->merge_range($l_v{row},$l_v{col},$l_v{row},($l_v{'col'}+1),$group_info->{NAME},$group_format);
							
							# set outline					
							$l_v{work_sheet}->set_row($l_v{row},undef,undef,0,0) if($l_v{'group'}->{'outline'});
						
							#$l_v{work_sheet}->write($l_v{row},($get->{'column'}->{'total'}-1),'Total',$group_title_format);
						
							push(@{$l_v{'final_row'}}, {'label'   => 'Total',
										    'column'  => ($get->{'column'}->{'total'}-1),
										     'format' => $group_title_format});
							
						
						}else{ # final row only
					
							@{$l_v{'final_row'}} = ($l_v{'group'}->{'final_row_action'})?@{$l_v{'group'}->{'final_row_action'}->({'label'  => $group_info->{NAME},
														        'column'=> $l_v{'dynamic_group'}->[1],
									                                                 'format' => $final_row_format})}:
							                                                                {'label'  => $group_info->{NAME},
															 'column' => $l_v{'dynamic_group'}->[1],
															 'format' => $final_row_format} ;
					
						} # end
				
				
					$summary->{'data'}->{'total'}={};					
					
					if (!$l_v{'group'}->{'title_once'}){
						
						
						$l_v{row}++; 
									
						# Column fields
						
						$l_v{col} = 0;
						
						foreach my $temp (@{$e_series->{'data'}}){
						       
						    $l_v{work_sheet}->write($l_v{row},$l_v{col},$temp->{name},$title_format);
						    
						     $l_v{col}++;
						}
						
						# column field formats
						
						$l_v{col} = 0;
					    
					       foreach my $temp (@{$e_series->{'data'}}){
						    
						   $l_v{work_sheet}->set_column($l_v{col}, 0,$temp->{width});
						   
						   $l_v{col}++;
						}
					       
					} # title once
					
					# Here we write the report data into excel sheet
					
					$l_v{'group_row'}   = 1;
				    
					# outline records
					
					@{$l_v{'show_records'}} = @{$l_v{'group_records'}};
				    
				        @{$l_v{'show_records'}}=splice(@{$l_v{'show_records'}},0,(($param->{'outline_limit'}>0)?$param->{'outline_limit'}:0)) if($param->{'outline_limit'});
				    
					for my $row_data(@{$l_v{'show_records'}}){
							
									#code							
							
									$$row_data[0]=$l_v{'group_row'} if($get->{'column'}->{'counter'});
									
									$l_v{'group_row'}++;
									
									$l_v{row}++;
									
									$l_v{col} = 0;
									
									# outline
									
									$l_v{work_sheet}->set_row($l_v{row},undef,undef,1,1) if($l_v{'group'}->{'outline'}); # set outline										
								
									for my $column_data(@{$row_data}){
										
										$l_v{work_sheet}->write($l_v{row},$l_v{col},
													$e_series->{'data'}->[$l_v{col}]->{'filter_out'}->($column_data),
													$e_series->{'data'}->[$l_v{col}]->{'format_act'}->($row_format,$custom_format,$column_data));
										
										$l_v{col}++;
									}
					} # each row
					
					# summary
					
					########### Summary ####################################################### 
				
					for my $row_data(@{$l_v{'group_records'}}){
						
						$l_v{col} = -1;
						
						for my $column(@{$summary->{'is_total'}}){
								
							push(@{$summary->{'data'}->{'total'}->{$column}},$$row_data[$column]);
								
						} # summary columns						
					      
					} # end of summary
				
					# Summary Print
					
					if(scalar(@{$summary->{'is_total'}})>0){
						    
						$l_v{row}++;
						
						$l_v{'group_count'}++;
						
						# group counter
						
						if($get->{'final_row_counter'}){
							
							$l_v{work_sheet}->write($l_v{row},$get->{'final_row_counter'}->{'counter_idx'},
										$l_v{'group_count'},
										$final_row_right_format);
							
						} # set counter
						
						for my $column(@{$summary->{'is_total'}}){
						      
							# $l_v{'group_head_row'} -> $l_v{'row'}
							
							$l_v{'temp_group_total'} = sprintf("%.2f",sum(@{$summary->{'data'}->{'total'}->{$column}}));
							
							$l_v{work_sheet}->write($l_v{'row'},
										$column,
										sprintf("%.2f",sum(@{$summary->{'data'}->{'total'}->{$column}})),
										$e_series->{'data'}->[$column]->{'format_act'}->($row_format,$custom_format,$l_v{'temp_group_total'}));
							
							
								
						} 	# summary columns
						
						# each column
						
						for(@{$l_v{'final_row'}}){
						
							$l_v{work_sheet}->write($l_v{row},
										$_->{'column'},
										$_->{'label'},
										$_->{'format'});
						} # each final row
						
						
 						
					} #	
				
				} # ignore group
				
                        } # each group
                        
                }# Here Single condition ends
                
            
        # Here  '0' condition get from (FILTER_ID param), Multiple Sheet
        
            
                elsif($l_v{type}=~m/^M(\d*)/ig){
                        
                        # Here loop task for the each items ina group list
						
						print "Group ".Dumper($l_v{'group_list'}) if($param->{'is_debug'});
                        
                        for my $group_info(@{$l_v{group_list}}){
				
				
				# Group Record
			
				$l_v{'group_records'}=[];
				
				$l_v{'group_records'} = &get_group_matches($group_info,
									   $l_v{'group_column'},
									   $records);
                                
                                
                                # here we craete a individual excel sheet according to the group list
                            
                                $l_v{work_sheet}         =  $workbook->add_worksheet($group_info->{FF});
                                
                                $l_v{row}                =  1;
                                
                                $l_v{col}                =  -1;
                                
                        # Here we writes the column fields of the excel sheet         
                                
                                foreach my $temp (@{$e_series->{'data'}}){
                                    
                                        $l_v{col}++;
                                           
                                        $l_v{work_sheet}->write($l_v{row},$l_v{col},$temp->{name},$title_format);
                                }
                                
                        # Here we assign  the column fields format of the excel sheet 
                        
                                 $l_v{col}                =  -1;
                        
                                foreach my $temp (@{$e_series->{'data'}}){
                                    
                                        $l_v{col}++;
                                        
                                        $l_v{work_sheet}->set_column($l_v{col}, 0,$temp->{width});
                                }
                                
                        # Write Report Heading
                        
                                $l_v{work_sheet}->merge_range(0,0,0,$l_v{'col_length'},$l_v{heading},$report_heading_format);
                        
			# Freeze panes
			
				freeze_panes({'work_sheet'=>$l_v{work_sheet},
						'row'=>($l_v{row}+1),
						'get'=>$get
					});			
                        
                        # Here we write the report data into excel sheet
			
				$l_v{'group_row'}=1;
                               
                                for my $row_data(@{$l_v{'group_records'}}){

                                                $$row_data[0]=$l_v{'group_row'} if($get->{'column'}->{'counter'});
					    
                                                $l_v{row}++;
						
						$l_v{'group_row'}++;
                                                
                                                $l_v{col} = -1;
                                        
                                                for my $column_data(@{$row_data}){
                                                    
                                                        $l_v{col}++;
                                                        
                                                        $l_v{work_sheet}->write($l_v{row},$l_v{col},$column_data);
                                                }
                                       
                                }  # row
                        }
                        
                }# Here multiple condition ends            
            
            
            
         # Else
        
            
                else{
                        
                        
                        # here create a excel sheet
                        
                        $l_v{work_sheet}    = $workbook->add_worksheet($l_v{work_sheet});
                        
                        # here write the Sheet Heading
                        
                        $l_v{work_sheet}->merge_range(0,0,0,$l_v{'col_length'},$l_v{heading},$report_heading_format);
                        
                        
                        # Here we assign  the column fields format of the excel sheet
                        
                                $l_v{col}=0;
                        
                                foreach my $temp (@{$e_series->{'data'}}){
                                    
                                        $l_v{work_sheet}->set_column($l_v{col},0,$temp->{width});
					  
					# summary
			     
					push(@{$summary->{'is_total'}},$l_v{'col'}) if($temp->{'is_total'});
					
                                        $l_v{col}++;
                                }
                     
                        
                        $l_v{row}           = 1;
                        
                        # Here we write the fields fo the columns
                        
                        if($l_v{row} == 1){
                            
                                $l_v{col} = -1;    
                            
                                foreach my $temp (@{$e_series->{'data'}}){
                                    
                                        $l_v{col}++;
                                       
                                        $l_v{work_sheet}->write($l_v{row},$l_v{col},$temp->{name},$title_format);
                                }
				
				# freez pane setup
				
				freeze_panes({'work_sheet'=>$l_v{work_sheet},
						      'row'=>($l_v{row}+1),
						       'get'=>$get
						      });
				
                        } # header
                        
                        
                        # Here we writes the row record from DB through query
                       
                        for my $row_data(@{$records}){
                                
				$$row_data[0]=$l_v{'row'} if($get->{'column'}->{'counter'});
				    
                                $l_v{row}++;
                                
                                $l_v{col} = -1;
                                
                                for my $column_data(@{$row_data}){
                                    
                                        $l_v{col}++;
                                        
                                        $l_v{work_sheet}->write($l_v{row},$l_v{col},$column_data);
                                }  
                        }
			
			
			########### Summary ####################################################### 
			
			for my $row_data(@{$records}){
                                
                                $l_v{col} = -1;
                                
                              	for my $column(@{$summary->{'is_total'}}){
						
					push(@{$summary->{'data'}->{'total'}->{$column}},$$row_data[$column]);
						
				} # summary columns	
                              
                        } # end of summary
			
			# Summary Print
			
			if(scalar(@{$summary->{'is_total'}})>0){
			            
				$l_v{row}++;
				
				for my $column(@{$summary->{'is_total'}}){
				      
				        	
					$l_v{work_sheet}->write($l_v{row},
								$column,
								sprintf("%.2f",sum(@{$summary->{'data'}->{'total'}->{$column}})),
								$summary_total_format);
						
				} # summary columns
				
				$l_v{work_sheet}->write($l_v{row},($get->{'column'}->{'total'}-1),'Total',$group_title_format);
			} #				
                              
                        
			
                }# Here we else ends
               
                return {
                        'file_path'=>$l_v{'excel_file'},
                        'name'     =>$l_v{'file_name'},
                        'success'  =>1
                }
              
        }# make_report ends
        
    
	# get group matched records
	# 0.group_info->{ID},group_info->{NAME}
	# 1.group_column
	# 2. records
	
	sub get_group_matches(){
		
	    my $lv;
	    
	    $lv->{'temp_record'} = [];
	    
	    my $group_info   = shift @_;
	    
	    my $group_column = shift @_;
	    
	    my $records       = shift @_;
	    

		for my $row_data(@{$records}){
			
			my $grp = $row_data->[$group_column];
			
			$grp=~s/(\W|\s)//g;
			
			# Here we write data accorging to the group list items
			
			if($group_info->{ID} =~m/^$grp$/){
				
				push(@{$lv->{'temp_record'}},$row_data)
			}
			
		} # each row
		
		return $lv->{'temp_record'};
		
	} # end
    
    
        
    
	
	# Set Freeze pane
	
	sub freeze_panes(){
		
		$_[0]->{'work_sheet'}->freeze_panes($_[0]->{'row'},
						   ($_[0]->{'get'}->{'freeze_pane'}->{'col'} || 0));
		
	} # end
	
		
	
	# Here we use this function for return the values
	
        sub get_excel_final(){
          
              return  $l_v{'excel_file'};
               
              #return  $P_V{OUT};
        } # get
        
        
        
        
        
        
    1;
    
    ####################################-----------FUTURE IMPLEMENTS-----------#####################################################
    #
    # 24Feb2016 -> Filter_out hardly added for single sheet group ( To be added for multi sheet)
    # 1) Want to select the group of groups
    # 10Mar2016 -> single sheet named by title
    # 13Mar2016 -> Update on Format Act
    # 
    # Group Sample 
    # 'group'        => {    'column'        =>10, # column index to be grouped
    #                        'heading_merge' =>3,  # still not
    #                        'inline'        =>1,  # inline 
    #                        'outline'       =>0,  # collpase for outline           
    #                        'title_once'    =>0   # For group case title only once
    #                  },
    #
    #
    #
    #
    ##  'set'         => {
    #                                            # counter column serial no.
    #                                      
    #                                            'column'=>{'counter'=>1,
    #                                                       'total'=>2
    #                                            },
    #                                            
    #                                            # freez panel
    #                                      
    #                                            'freeze_pane'=>{'col'=>4}
    #                                            
    #                    } 
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    ###########################################################################################
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    