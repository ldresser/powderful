
function getLocation()
     {
    if (navigator.geolocation)
    {
    navigator.geolocation.getCurrentPosition(showPosition, handleError);
    }
    else {
        // geoloc not supported in this browser
        // render form to ask user for direct input
        // window.location.href = "/userlocations/new"
         $("#user-input-form-modal-mcb").show()
        ;}
    }
    function showPosition(position)
    {
    	 $("#user-input-form-modal-mcb").hide()
        $.ajax({
            type: "POST",
            url: "/userlocations",
            data: {
                "userlocation[address]": "js-file ajax send",
                "userlocation[lat]": position.coords.latitude,
                "userlocation[lng]": position.coords.longitude,
            },
            datatype: 'json',
            success: function(){window.location.href="/show"}
        });
       
    }

    function handleError(err) {
        // render form to ask user for manual input
        // window.location.href = "/userlocations/new"
         $("#user-input-form-modal-mcb").show()
        }

        