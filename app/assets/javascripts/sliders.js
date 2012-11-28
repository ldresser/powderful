 $(function() {
        $( "#slider-range-distance" ).slider({
            range: true,
            min: 0,
            max: 500,
            values: [ 75, 300 ],
            slide: function( event, ui ) {
                $( "#amount-distance" ).val( ui.values[ 0 ] + " miles - " + ui.values[ 1 ]  + " miles");
            }
        });
        $( "#amount-distance" ).val( $( "#slider-range-distance" ).slider( "values", 0 ) +
            " miles - " + $( "#slider-range-distance" ).slider( "values", 1 ) + " miles");
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