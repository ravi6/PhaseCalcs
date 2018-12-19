// Author: Ravi Saripalli
// 6th April 2016
//
// Global variables (YUK...fix it)
 var y = [97,2,0.7,0.3,0,0,0,0,0,0];  // Molar composition of LNG (at startup)
 var dPmax = 46 ;  // Default value
 var bPmax = 46 ;  // Default value


/*      Set up all call backs for User interaction
 *      ============================================
 */
$(function() {
  // Disable defaultbehaviour ??? of submit type 
    $("input[type=submit],  button").click(
	function(e) { e.preventDefault(); });
    $("#rlink").hide();

    $("#calc")
     .click(function (e) {
  	      calcPhaseEnv();
	  //    alert("Calculate Executed");
            });

    $('.yi').each(  // Make sure composition is right
      function(index, element) {
	    element.value = y[index];
	    $(element).on('input', 
		    function() {
			 checkInputVal(this, 0, 100) ;
			 y[index] = parseFloat(this.value) ;
	                  $('#sumy').html(sum(y)) ;
		    });
	  });


     $('#bPmax').on('input',
		     function() {  // Bubble Curve Max. Pressure Input
			 checkInputVal(this, 0, 70) ;
			 bPmax = parseFloat(this.value);
		       });

     $('#bPmax').val(dPmax);
     $('#dPmax').val(bPmax);

     $('#dPmax').on('input',
		     function() {  // Dew Curve Max. Pressure Input
			 checkInputVal(this, 0, 70) ;
			 dPmax = parseFloat(this.value);
		       });

}); // End of loading all functions

/*     Generic Functions and Calls to Server
 *     This is where all the action is 
 */

function checkInputVal(obj, low, high) {
// Tests for valid real input value is in limits
	var tmp = obj.value ;
        if (!$.isNumeric(tmp) || tmp < low || tmp > high ) {
        	 $(obj).css("background-color","red");
        } else {
    	        $(obj).css("background-color","");
          };
} // end of checkInputVal

function sum(vec) 
{
  var n = vec.length ;
  var total = 0 ;
  for(var i = 0; i < n; i++) 
	    total += vec[i];  
  return(total);
}

function fmt(astr, scale)
{
  var num  ;
  num = parseFloat(astr) * scale ;
  num = num.toPrecision(2) ;
  return(num); 
}; // end of fmt

function loadResult() { // get txt file from server and show 
$.ajax({
           url : "peng.txt",
           dataType: "text",
           success : function (data) {
                       $("#result").text(data);
                    }});
} // loadResult done

function refreshPlot() { // refresh Plot avoid Cache
	d = new Date();
	$("#aplot").attr("src", "/peng.png?"+d.getTime());
} // loadResult done



function calcPhaseEnv()
{
 dataToSend = { "y"   : y,
	        "bPmax" : bPmax,
	        "dPmax" : dPmax
             }; // A json Data Object
 txtToSend = JSON.stringify(dataToSend);
 $("#rlink").hide() ;

// Make an http request with Ajax
$.ajax({
  cache: true,
  method: "GET",
  url: "peng.php",
  data: txtToSend,
  success: function( response ) {
             if (response == "done"){
	            alert(response);
                    $("#rlink").show() ;
		    refreshPlot();
	    // $("#calc").prop("disabled", false);
                    	 // loadResult(); 
		 } else { alert ("simulation failed") ; };
           }});
}; // end PhaseEnv
