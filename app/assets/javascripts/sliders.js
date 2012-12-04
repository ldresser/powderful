function time_format(secs) {
    var h = Math.floor(secs/3600);
    var m = Math.floor(secs % 3600 / 60);
    return h + ' hours ' + m + ' mins';
};

function stars(num){
    var a = Array(6);
    for (var i = 1; i < 6; i++) {
        if (i <= num) {
            a[i] = "★";
            // console.log("num=" + num + ", i=" + i + ", ★");
        }
        else {
            a[i] = "☆";
            // console.log("num=" + num + ", i=" + i + ", ☆");
        };
        
    };
    //console.log(num + " " + a);
    return a.join("");

};

 $(function() {
        $( "#slider-range-distance" ).slider({
            range: true,
            min: (drive_secs_min * 0.8),
            max: (drive_secs_max * 1.2),
            values: [ drive_secs_min * 0.99 , drive_secs_max * 1.01],
            slide: function( event, ui ) {
                $( "#amount-distance" ).val( time_format($( "#slider-range-distance" ).slider( "values", 0 )) + " - " + time_format($( "#slider-range-distance" ).slider( "values", 1 )) ); 
            },
            change: function( event, ui ) {
                updateScreen();
            }
            
        });


        $( "#amount-distance" ).val( time_format($( "#slider-range-distance" ).slider( "values", 0 )) + " - " + time_format($( "#slider-range-distance" ).slider( "values", 1 )));

    });

  $(function() {
        $( "#slider-range-conditions" ).slider({
            step: 1,
            range: true,
            min: 1,
            max: 5,
            values: [ 1, 5 ],
            change: function( event, ui ) {
                updateScreen();
                $( "#amount-conditions" ).val( stars($( "#slider-range-conditions" ).slider( "values", 0 )) + " - " + stars($( "#slider-range-conditions" ).slider( "values", 1 )) ); 
            }
        });
        $( "#amount-conditions" ).val( stars($( "#slider-range-conditions" ).slider( "values", 0 )) + " - " + stars($( "#slider-range-conditions" ).slider( "values", 1 )) ); 

    });


    $(function() {
        $( "#slider-range-price" ).slider({
            range: true,
            min: 0,
            max: price_max,
            values: [ price_min , price_max ],
            slide: function( event, ui ) {
                $( "#amount-price" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
            },
            change: function( event, ui ) {
                updateScreen();
            }

        });
        $( "#amount-price" ).val( "$" + $( "#slider-range-price" ).slider( "values", 0 ) +
            " - $" + $( "#slider-range-price" ).slider( "values", 1 ) );
    });

   
   

   function updateScreen(){
        var lb_distance = $( "#slider-range-distance" ).slider("values",0);
        var ub_distance = $( "#slider-range-distance" ).slider("values",1);
        var lb_price = $( "#slider-range-price" ).slider("values",0);
        var ub_price = $( "#slider-range-price" ).slider("values",1);
        var lb_conditions = $( "#slider-range-conditions" ).slider("values",0);
        var ub_conditions = $( "#slider-range-conditions" ).slider("values",1);

                    
                    $('#listing-table tr').each(function(){
                    $(this).find('td:nth-child(17)').each(function(){

                    if (
                            ((   
                                parseFloat($(this).text().substring(1)) < lb_price 
                                || parseFloat($(this).text().substring(1)) > ub_price
                            ) 
                            || (
                                parseFloat($(this).parent().find('td:nth-child(3)').text()) < lb_distance
                                || parseFloat($(this).parent().find('td:nth-child(3)').text()) > ub_distance
                            )
                            || (
                                parseFloat($(this).parent().find('td:nth-child(19)').text()) < lb_conditions
                                || parseFloat($(this).parent().find('td:nth-child(19)').text()) > ub_conditions
                            ))
                            && $(this).parent().is(":visible")
                        ) 
                            { 
                                //hide the row
                                $(this).parent().hide();
                                //remove marker from map
                                var lat = parseFloat($(this).parent().find('td:nth-child(1)').text());
                                var lng = parseFloat($(this).parent().find('td:nth-child(2)').text());
                                //console.log("passing " + lat + ", " + lng); //debug
                                delMarker(lat,lng); 
                            }

                    //(2) show & add if > lb and < ub and hidden
                    if (
                            parseFloat($(this).text().substring(1)) >= lb_price
                            && parseFloat($(this).text().substring(1)) <= ub_price
                            && parseFloat($(this).parent().find('td:nth-child(3)').text()) >= lb_distance
                            && parseFloat($(this).parent().find('td:nth-child(3)').text()) <= ub_distance
                            && parseFloat($(this).parent().find('td:nth-child(19)').text()) >= lb_conditions
                            && parseFloat($(this).parent().find('td:nth-child(19)').text()) <= ub_conditions
                            && !($(this).parent().is(":visible"))

                        ) {

                        //hide the row
                        $(this).parent().show();
                        //remove marker from map
                        var lat = parseFloat($(this).parent().find('td:nth-child(1)').text());
                        var lng = parseFloat($(this).parent().find('td:nth-child(2)').text());
                        var title = $(this).parent().find('td:nth-child(5)').text();
                        // console.log("passing " + lat + ", " + lng);// debug
                        addMarkers(lat,lng,title); 
                    }

                    })
                })
   };


 