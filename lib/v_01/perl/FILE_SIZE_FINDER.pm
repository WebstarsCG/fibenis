#!/usr/bin/perl -w 

    package FILE_SIZE_FINDER;
    
    use File::Find;
    
    use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
	
	use Schedule::ByClock;
	
	use File::Path 'remove_tree';
    
#Used to find the size of file 
    sub file_size(){
        
       # my $file    =   "D:/xampp/htdocs/backup/step_Feb_12_2015_10_41_50.zip";
        
        my $file    =$_[0];
        
        my $size;
                    
        find(sub{ -f and ( $size += -s ) },$file );
        
        $size = sprintf("%.02f",$size / 1024 / 1024);
        
       # print "Directory '$zipfile' contains $size MB\n";
        
        my $size_kb  =   $size*1024;
                   
        
        return $size_kb;
    }
    
1;