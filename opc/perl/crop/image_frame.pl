#!/usr/bin/perl 
    
    use CGI::Carp qw/fatalsToBrowser/;
    
    use File::Basename;    
    
    use Data::Dumper;
    
   # use Image::Resize;
    
   # use Imager;
    
   
    ########
    
    my $lv;

    print "Content-type: text/html\n\n";
    
    $lv->{'img_counter'} = 0;
   
    $lv->{'source'} = "source";
    
    $lv->{'crop'} = "temp";
    
    #$lv->{'source'} = "worked";
    #
    #$lv->{'target'} = "worked_scaled";
        
    # get files
    
    opendir(DIR,$lv->{'source'});
    
    @{$lv->{'files'}} = readdir(DIR);
    
    closedir(DIR);
    
    shift(@{$lv->{'files'}});
    shift(@{$lv->{'files'}});
            
    # content
    
    $lv->{'file_content'}='';
    $lv->{'img_content'}='';
            
    # Get files    
    for(sort(@{$lv->{'files'}})){
        
        $lv->{'img_counter'}++;
        
        if ($_=~m/(.*?)(\.jpg)/ig){
            
            $lv->{'source_image'}="$lv->{source}/$_";
            $lv->{'crop_image'}="$lv->{crop}/$lv->{img_counter}.jpg";
            
            
            #
            #$lv->{'file_content'}.=$lv->{'img_counter'}.') '.$_."<br>";
            
            system("convert $lv->{source_image} -crop 720x340+0+75   $lv->{crop_image}");
            
            
            
            $lv->{'img_content'}.="<img src='$lv->{crop_image}' width='10%'>";
        }           
    
    } # each file

    print $lv->{'img_content'};
    print $lv->{'file_content'};
    
    system("convert $lv->{source_image} -crop 720x340+0+75   $lv->{crop_image}");
    
   # my $newimg = $img->crop(left=>0, top=>70, width=>720, height=>340);
   # 
   #$newimg->write(file => "crop.jpg");
   
     # 
   #convert crop.jpg  -resize 33%  crop_33.jpg
     #montage crop_33.jpg crop_33_ii.jpg -tile x1  -geometry 238x112  crop_bulk.jpg
   # my $newimg = $img->crop(left=>0, top=>70, width=>720, height=>340);
 
 # montage temp/[1-9].jpg temp/1[0-9].jpg temp/2[0-9].jpg temp/3[0-5].jpg -tile x5  -geometry 230x109  dilse_wall.jpg
 #montage temp/2.jpg temp/8.jpg temp/9.jpg temp/12.jpg  temp/15.jpg temp/17.jpg temp/20.jpg temp/21.jpg -tile x4  -geometry 230x109  dilse_ne.jpg
 #montage temp/23.jpg temp/24.jpg temp/25.jpg -tile x4  -geometry 230x109  dilse_ne.jpg
 
 #montage temp/27.jpg temp/28.jpg temp/31.jpg temp/32.jpg  temp/34.jpg temp/35.jpg  -tile x2  -geometry 230x109  dilse_end.jpg
    