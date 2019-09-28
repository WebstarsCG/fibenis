

    $(function() {

        var lv = new Object({'t':'tx','tx':'t'});
    
        G.$('X7').value=(G.$('X2').value+'[S]'+G.$('X3').value);
       
        G.$('X2').removeChild(G.$('opt_'+lv[G.$('X2').value]));
        
    });