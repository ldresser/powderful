function time_format(secs) {
    secs = number(secs)
    var h = math.floor(secs/3600);
    var m = math.floor(secs % 3600 / 60);
    return h + 'h ' + m + 'min';
};


 $(function() {
        $( "#slider-range-distance" ).slider({
            range: true,
            min: (drive_secs_min * 0.8),
            max: (drive_secs_max * 1.2),
            values: [ drive_secs_min * 0.99 , drive_secs_max * 1.01],
            slide: function( event, ui ) {
                $( "#amount-distance" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ]); 
            },
            change: function( event, ui ) {
                var lb = ui.values[0];
                var ub = ui.values[1];


                // ** CHANGE THE MAP AND TABLE ROWS **
                // logic: if row is out of bounds AND not hidden
                // then hide and remove from map
                // else if row is is bounds AND hidden
                // then show and add to map
                // else nothing


                $('#listing-table tr').each(function(){
                    $(this).find('td:nth-child(11)').each(function(){
                        console.log("cell 11: " + $(this).text());
                    //do your stuff, you can use $(this) to get current cell

                    //(1) hide & remove if (< lb or > ub) and not yet hidden
                    if ((parseFloat($(this).text()) < lb || parseFloat($(this).text()) > ub) && $(this).parent().is(":visible")) {
                        //hide the row
                        $(this).parent().hide();
                        //remove marker from map
                        var lat = parseFloat($(this).parent().find('td:nth-child(7)').text());
                        var lng = parseFloat($(this).parent().find('td:nth-child(8)').text());
                        console.log("passing " + lat + ", " + lng);
                        delMarker(lat,lng);
                    }

                    //(2) show & add if > lb and < ub and hidden
                    else if (parseFloat($(this).text()) > lb && parseFloat($(this).text()) < ub && $(this).parent().not(":visible")) {
                        //hide the row
                        $(this).parent().show();
                        //remove marker from map
                        var lat = parseFloat($(this).parent().find('td:nth-child(7)').text());
                        var lng = parseFloat($(this).parent().find('td:nth-child(8)').text());
                        var title = $(this).parent().find('td:nth-child(1)').text();
                        console.log("passing " + lat + ", " + lng);
                        addMarkers(lat,lng,title);
                    }

                    })
                })

            }
            
        });
        $( "#amount-distance" ).val( $( "#slider-range-distance" ).slider( "values", 0 ) +
            " - " + $( "#slider-range-distance" ).slider( "values", 1 ));

    });

  $(function() {
        $( "#slider-range-conditions" ).slider({
            range: true,
            min: 0,
            max: 500,
            values: [ 75, 300 ],
            slide: function( event, ui ) {
                $( "#amount-conditions" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
            }
        });
        $( "#amount-conditions" ).val( "$" + $( "#slider-range-conditions" ).slider( "values", 0 ) +
            " - $" + $( "#slider-range-conditions" ).slider( "values", 1 ) );
    });

    $(function() {
        $( "#slider-range-price" ).slider({
            range: true,
            min: 0,
            max: 500,
            values: [ 75, 300 ],
            slide: function( event, ui ) {
                $( "#amount-price" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
            }
        });
        $( "#amount-price" ).val( "$" + $( "#slider-range-price" ).slider( "values", 0 ) +
            " - $" + $( "#slider-range-price" ).slider( "values", 1 ) );
    });

   
   