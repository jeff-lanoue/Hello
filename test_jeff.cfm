<!DOCTYPE html>
<!--
//https://youtu.be/_8V5o2UHG0E?t=5101
//https://vizhub.com/
-->
<html lang="en">
    <head>
    <meta charset="utf-8">
    <title>title</title>
        <!--- <link rel="stylesheet" href="style.css"> --->
        <script>
            let cars = [];
            cars.push({make: "Honda", model: "Accord", year: 1998, price: 2000});
            cars.push({make: "Chevy", model: "Camaro", year: 1975, price: 2500});
            cars.push({make: "Kia", model: "Soul", year: 2018, price: 25000});
            cars.push({make: "Doge", model: "Caravan", year: 2008, price: 20000});

            console.log(cars);
            const printCarPrice = car => {console.log(car.price)};
            cars.forEach(printCarPrice);

            const models = cars.map(car => car.model);
            console.log(models.sort());

            const cheapCars = cars.filter(car => car.price < 5000);
            console.log(cheapCars);

            let formatCar = car => `Car : ${car.year} ${car.make} ${car.model} : $${car.price}`;
            console.log(formatCar(cars[1]));

            //dustructuring
            let formatCar2 = car => {
                const {
                    year,
                    make,
                    model,
                    price
                } = car;
               return `Car : ${make} ${model} ${year} : $${price}`;
            }
            console.log(formatCar2(cars[2]));

            const report = cars
                .filter(car => car.price < 5000)
                .map(formatCar2)
                .join('\n');

            console.log(report);    

            console.log(JSON.stringify(cars, null, 4));
            console.log("done");
        </script>
    </head>
    <body>
    <!-- page content -->
    </body>
</html>
<cfabort>
<html>
    <head>
        <meta charset="utf-8">
        <title>Index Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <script>

            const dataCollectionUrl = 'https://jeff.knightpiesold.com/fulcrum/cfc/ws/SenseMetrics.cfc?method=automatedDataCollectionTest';

            var gDataBundle = {
                ANALYTEID: 4560,
                METRIC: "f",
                METRICUNIT: "digits",
                SENSORID: "/fn/41D4F0/node/campbellavw200/292626/device/vw1-21/sensor",
                UNIT: "B unit"
            }

            var series = {data : 123}
            var dataCount = 547;
            var unit = 'm';

            var analyteID = 4625;
            var gDataBundled = {}
            gDataBundled[analyteID] = series.data;
            gDataBundled["count_"+analyteID] = dataCount;
            gDataBundled["unit_"+analyteID] = unit;
//            gDataBundled.paramList.push(analyteID);

            console.log(gDataBundled);

            const jsonMappingUrl = 'https://jeff.knightpiesold.com/fulcrum/cfc/ws/SenseMetrics.cfc?method=getSenceMetricsJSON';
            const getSenseMapping = async () => {
                await axios({
                    method: 'post',
                    url: jsonMappingUrl,
                    headers: {
                        apikey: 'F38E7C9D-98EC-E611-A4CF-0050568C7146'
                    }
                }).then((response) => {
                    $("#resultStatusOutput").html('<div>'+ response.data +'</div>');
                    console.log(response);
                    return response.data;
                }).catch((e) => {
                    console.log(e);
                    throw new Error(e);
                });
            }; 
            
            const headerTest = async () => {

                dataBundle = gDataBundle;
                
                axios({
                    method: 'post', //you can set what request you want to be
                    url: dataCollectionUrl,
                    params: {dataBundle},
                    headers: {
                        apikey: 'F38E7C9D-98EC-E611-A4CF-0050568C7146'
                    }
                }).then((response) => {
                    $("#resultStatusOutput").html('<div>'+ response.data +'</div>');
                }).catch((e) => {
                    console.log(e);
                });
            }; 

            function makeRequest() {

                dataBundle = gDataBundle;
                //this one works FINALLY !
                axios({
                    url: dataCollectionUrl,
                    method: 'post',
                    params: {dataBundle}
                }).then((response) => {
                    $("#resultStatusOutput").html('<div>'+ response.data +'</div>');
                    console.log(response.data);
                })
                .catch(function (error) {
                    console.log(error);
                });
            }

            function makeRequestJq() {

                var data = JSON.stringify(gDataBundle);
                console.log(data);

                $.ajax ({
                    url     : dataCollectionUrl,
                    data	: ({dataBundle: data}),
                    type    : "POST",
                    success	: function(result){
                        $("#resultStatusOutput").html('<div>'+ result +'</div>');
                    },
                    error: function (request, status, err){
                        console.log(status + " " + err);
                    }
                });                
            }

            function makeHeaderRequestJq() {

                var data = JSON.stringify(gDataBundle);
                console.log(data);
                var dataCollectionUrl = 'https://vancouver.knightpiesold.com/fulcrum/cfc/ws/SenseMetrics.cfc?method=automatedDataCollectionTest';

                $.ajax ({
                    url     : dataCollectionUrl,
                    headers: {
                        'apikey': 'F38E7C9D-98EC-E611-A4CF-0050568C7146'
                    },
                    data	: ({dataBundle: data}),
                    type    : "POST",
                    success	: function(result){
                        $("#resultStatusOutput").append('<div>'+ result +'</div>');
                    },
                    error: function (request, status, err){
                        console.log(status + " " + err);
                    }
                });

            }

            function getAnalytesByUnit() {
                var unit = 'mg/L';
                axios({
                    url		:"cfc/Analyte.cfc?method=getAnalytesByUnit&ReturnFormat=json",
                    method: 'post',
                    params: {unit}
                }).then(function(response) {
                    $("#resultStatusOutput").html('<div>'+ response.data +'</div>');
                    console.log(response.data);
                })
                .catch(function (error) {
                    console.log(error);
                });
            }

            function getAnalytesByUnit2() {
                var selUnit = 'mg/L';

                $.ajax({
                    url		:"cfc/Analyte.cfc?method=getAnalytesByUnit&ReturnFormat=json",
                    dataType: "text",
                    data	: ({unit:selUnit}),
                })
                .done(function(data, textStatus, jqXHR){ //same as .success (depricated as of 1.8)
                    $("#resultStatusOutput").html('<div>'+ data +'</div>');
                    console.log(data);
                    console.log("done");
                    console.dir(arguments);
                })
                .fail(function(jqXHR, textStatus, errorThrown){ //replaces .error
                    $("#resultStatusOutput").html('');
                    console.log("error");
                    console.dir(arguments);
                })
                .always(function(/*data|jqXHR, textStatus, jqXHR|errorThrown*/){ //replaces .complete
                    console.log("always");
                    console.dir(arguments);
                });						                
            }

            function getAnalytesByUnit3() {
                var selUnit = 'mg/L';

                $.ajax ({
                    url		:"cfc/Analyte.cfc?method=getAnalytesByUnit&ReturnFormat=json",
                    data	: ({unit: selUnit}),
                    type    : "POST",
                    success	: function(result){
                        $("#resultStatusOutput").append('<div>'+ result +'</div>');
                    },
                    error: function (request, status, err){
                        console.log(status + " " + err);
                    }
                });                
            }

        </script>
    </head>
    <body>

        <h2>Test page</h2>
        <p>
             Test Axios
        </p>
        <p>
            <input type="Button" value="Axios request" onclick="makeRequest()">
            <input type="Button" value="JQuery request" onclick="makeRequestJq()">
            <input type="Button" value="JQuery Header Test" onclick="makeHeaderRequestJq()">
            <input type="Button" value="Axios Header Test" onclick="headerTest()">
            <input type="Button" value="Axios Get Mapping" onclick="getSenseMapping()">
            <input type="Button" value="Axios Get Analytes" onclick="getAnalytesByUnit()">
            <input type="Button" value="Axios Get Analytes 2" onclick="getAnalytesByUnit2()">
            <input type="Button" value="Axios Get Analytes 3" onclick="getAnalytesByUnit3()">

            <div id="resultStatusOutput"></div>
        </p>        
    </body>
</html>


<cfabort>

<cfoutput>
<cffunction name="getMappings" access="remote">
    <cftry>
		<cfinvoke component="#APPLICATION.cfcs#ws.SenseMetrics" method="getSenceMetricsJSON" returnvariable="Result">
		</cfinvoke>
		<cfcatch><cfset Result = cfcatch.message></cfcatch>
	</cftry>
    
    <!--- #Result# --->
    <cfreturn Result>
</cffunction>    

#getMappings()#
</cfoutput>
<cfabort>

<cfoutput>

    <cftry>
		<cfinvoke component="#APPLICATION.cfcs#ws.SenseMetrics" method="getSenceMetricsJSON" returnvariable="Result">
		</cfinvoke>
		<cfcatch><cfset Result = cfcatch.message></cfcatch>
	</cftry>
    <!--- <cfdump  var="#Result#"> --->
    <!--- <cfdump  var="#Result#"> --->
    #Result#

<!--- 
    <cfset servicePath = "https://#APPLICATION.domainname#/fulcrum/cfc/ws/SenseMetrics.cfc?WSDL" />
	<cftry>
		<cfinvoke webservice="#servicePath#" method="getSenceMetricsJSON" wsversion="1" returnvariable="Result">
		</cfinvoke>
		<cfcatch><cfset Result = cfcatch.message></cfcatch>
	</cftry>
    <cfdump  var="#Result#">

<hr>
 --->
    

</cfoutput>

<cfexit>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<cfmodule template="tags/fulcrum/fulcrum_security_check.cfm" />


<cfset pagetitle = "This page">
<!-- Put queries in here -->


<html>
<head>
<title>FULCRUM - <cfoutput>#pagetitle#</cfoutput></title>
<cfinclude template="includes/common_head.cfm">
<script type="text/javascript">
function CheckForm(frm, btn)
{
	btn.disabled = true;
	document.body.style.cursor = "wait";
	frm.submit();
}
$(document).ready(function(){
	// Set form focus.
	document.getElementById('field').focus();
})
</script>
</head>

<body style="margin:5px;">

<!-- Put page content here -->
<cfmodule template="tags/controls/control_date.cfm" ID="EndDate" DateFormat="#REQUEST.fulcrum.user_dateformat#" Date="">

<cfinclude template="includes/footer.cfm">
</body>
</html>




<cfabort>

<!--- 
<cfmodule template="tags/controls/control_date.cfm" ID="EndDate" DateFormat="#REQUEST.fulcrum.user_dateformat#" Date="">
 --->

<!DOCTYPE html>
<meta charset="utf-8">
<style> /* set the CSS */

.axis { font: 14px sans-serif; }

.line {
  fill: none;
  stroke: steelblue;
  stroke-width: 2px;
}

</style>
<body>

<!--- 
<script src="https://d3js.org/d3.v4.min.js"></script>
<script>

var matrix = [
  [11975,  5871, 8916, 2868],
  [ 1951, 10048, 2060, 6171],
  [ 8010, 16145, 8090, 8045],
  [ 1013,   990,  940, 6907]
];

var tr = d3.select("body")
  .append("table")
  .selectAll("tr")
  .data(matrix)
  .enter().append("tr");

var td = tr.selectAll("td")
  .data(function(d) { return d; })
  .enter().append("td")
    .text(function(d) { return d; });

</script>
 --->
<!-- load the d3.js library -->
<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js"></script>
<script>



// set the dimensions and margins of the graph

var parseDateTime1 = d3.timeParse("%Y-%m-%d %H:%M");
var parseDateTime2 = d3.timeParse('%Y-%m-%dT%H:%M:%S');
var parseDateTime3 = d3.timeParse('%Y-%m-%dT%H:%M:%S%Z');

var aISOdate = '2018-01-09T13:00:00.000Z';
x = moment(aISOdate).format("YYYY-MM-DD HH:mm");
//console.log(x);
//console.log(parseDateTime1(x));

//var iso = d3.timeFormat.utc("%Y-%m-%dT%H:%M:%S.%LZ");
var strictIsoParse = d3.utcParse("%Y-%m-%dT%H:%M:%S.%LZ");
console.log(strictIsoParse(aISOdate));

var p = d3.precisionFixed(0.01),
	f = d3.format("." + p + "f");
console.log(f(12.365487));

var data = [
	{"date" : '2018-01-09 05:00', "close" : 99.00},
	{"date" : '2018-01-09 06:00', "close" : 130.28},
	{"date" : '2018-01-09 07:00', "close" : 166.70},
	{"date" : '2018-01-09 08:00', "close" : 234.98},
	{"date" : '2018-01-09 09:00', "close" : 345.44},
	{"date" : '2018-01-09 10:00', "close" : 443.34},
	{"date" : '2018-01-09 11:00', "close" : 543.70},
	{"date" : '2018-01-09 12:00', "close" : -50.13},
];

var moreDate = [
	{'a':,69.73},
    {'b':,25.80},
    {'c':,31.45},
    {'d':,72.94},
    {'e':,70.58},
    {'f':,36.65},
    {'g':,14.12},
    {'h':,18.06},
    {'i':,79.43},
    {'j':,11.37},
    {'k':,13.12},
    {'l':,24.46},
    {'m':,92.83},
    {'n':,43.85},
    {'o':,87.86},
    {'p':,79.93},
    {'q':,63.93},
    {'r':,61.18},
    {'s':,97.72},
    {'t':,92.80},
    {'u':,32.65},
    {'v':,32.64},
    {'w':,43.09},
    {'x':,56.32},
    {'y':,77.45},
    {'z':,69.32}
];
/* 
data.forEach(function(d){
	console.log(d.date + " and " + d.close);
});
 */
var data = [
	{"date" : "2018-01-01T05:00:00.000Z", "close" : 3006.361083984375},{"date" : "2018-01-01T06:00:00.000Z", "close" : 3006.30126953125},{"date" : "2018-01-01T07:00:00.000Z", "close" : 3006.2353515625},{"date" : "2018-01-01T08:00:00.000Z", "close" : 3006.189208984375},{"date" : "2018-01-01T09:00:00.000Z", "close" : 3006.237060546875},{"date" : "2018-01-01T10:00:00.000Z", "close" : 3006.228515625},{"date" : "2018-01-01T11:00:00.000Z", "close" : 3006.273681640625},{"date" : "2018-01-01T12:00:00.000Z", "close" : 3006.256591796875},{"date" : "2018-01-01T13:00:00.000Z", "close" : 3006.239990234375},{"date" : "2018-01-01T14:00:00.000Z", "close" : 3006.21240234375},{"date" : "2018-01-01T15:00:00.000Z", "close" : 3006.233642578125},{"date" : "2018-01-01T16:00:00.000Z", "close" : 3006.14404296875},{"date" : "2018-01-01T17:00:00.000Z", "close" : 3006.095947265625},{"date" : "2018-01-01T18:00:00.000Z", "close" : 3006.0341796875},{"date" : "2018-01-01T19:00:00.000Z", "close" : 3006.074951171875},{"date" : "2018-01-01T20:00:00.000Z", "close" : 3006.239013671875},{"date" : "2018-01-01T21:00:00.000Z", "close" : 3006.40185546875},{"date" : "2018-01-01T22:00:00.000Z", "close" : 3006.541259765625},{"date" : "2018-01-01T23:00:00.000Z", "close" : 3006.50341796875},{"date" : "2018-01-02T00:00:00.000Z", "close" : 3006.472900390625},{"date" : "2018-01-02T01:00:00.000Z", "close" : 3006.44140625},{"date" : "2018-01-02T02:00:00.000Z", "close" : 3006.362060546875},{"date" : "2018-01-02T03:00:00.000Z", "close" : 3006.292236328125},{"date" : "2018-01-02T04:00:00.000Z", "close" : 3006.2451171875},{"date" : "2018-01-02T05:00:00.000Z", "close" : 3006.16796875},{"date" : "2018-01-02T06:00:00.000Z", "close" : 3006.121826171875},{"date" : "2018-01-02T07:00:00.000Z", "close" : 3006.109375},{"date" : "2018-01-02T08:00:00.000Z", "close" : 3006.106201171875},{"date" : "2018-01-02T09:00:00.000Z", "close" : 3006.121826171875},{"date" : "2018-01-02T10:00:00.000Z", "close" : 3006.130126953125},{"date" : "2018-01-02T11:00:00.000Z", "close" : 3006.15478515625},{"date" : "2018-01-02T12:00:00.000Z", "close" : 3006.22509765625},{"date" : "2018-01-02T13:00:00.000Z", "close" : 3006.1982421875},{"date" : "2018-01-02T14:00:00.000Z", "close" : 3006.083251953125},{"date" : "2018-01-02T15:00:00.000Z", "close" : 3006.0732421875},{"date" : "2018-01-02T16:00:00.000Z", "close" : 3006.05810546875},{"date" : "2018-01-02T17:00:00.000Z", "close" : 3006.02197265625},{"date" : "2018-01-02T18:00:00.000Z", "close" : 3006.03662109375},{"date" : "2018-01-02T19:00:00.000Z", "close" : 3006.19384765625},{"date" : "2018-01-02T20:00:00.000Z", "close" : 3006.36572265625},{"date" : "2018-01-02T21:00:00.000Z", "close" : 3006.49267578125},{"date" : "2018-01-02T22:00:00.000Z", "close" : 3006.5849609375},{"date" : "2018-01-02T23:00:00.000Z", "close" : 3006.601806640625},{"date" : "2018-01-03T00:00:00.000Z", "close" : 3006.581298828125},{"date" : "2018-01-03T01:00:00.000Z", "close" : 3006.58203125},{"date" : "2018-01-03T02:00:00.000Z", "close" : 3006.54052734375},{"date" : "2018-01-03T03:00:00.000Z", "close" : 3006.471435546875},{"date" : "2018-01-03T04:00:00.000Z", "close" : 3006.48828125},{"date" : "2018-01-03T05:00:00.000Z", "close" : 3006.46923828125},{"date" : "2018-01-03T06:00:00.000Z", "close" : 3006.42236328125},{"date" : "2018-01-03T07:00:00.000Z", "close" : 3006.406494140625},{"date" : "2018-01-03T08:00:00.000Z", "close" : 3006.456298828125},{"date" : "2018-01-03T09:00:00.000Z", "close" : 3006.510009765625},{"date" : "2018-01-03T10:00:00.000Z", "close" : 3006.48046875},{"date" : "2018-01-03T11:00:00.000Z", "close" : 3006.5087890625},{"date" : "2018-01-03T12:00:00.000Z", "close" : 3006.514892578125},{"date" : "2018-01-03T13:00:00.000Z", "close" : 3006.544921875},{"date" : "2018-01-03T14:00:00.000Z", "close" : 3006.534423828125},{"date" : "2018-01-03T15:00:00.000Z", "close" : 3006.506591796875},{"date" : "2018-01-03T16:00:00.000Z", "close" : 3006.459716796875},{"date" : "2018-01-03T17:00:00.000Z", "close" : 3006.424072265625},{"date" : "2018-01-03T18:00:00.000Z", "close" : 3006.395751953125},{"date" : "2018-01-03T19:00:00.000Z", "close" : 3006.47998046875},{"date" : "2018-01-03T20:00:00.000Z", "close" : 3006.575927734375},{"date" : "2018-01-03T21:00:00.000Z", "close" : 3006.68505859375},{"date" : "2018-01-03T22:00:00.000Z", "close" : 3006.74072265625},{"date" : "2018-01-03T23:00:00.000Z", "close" : 3006.775634765625},{"date" : "2018-01-04T00:00:00.000Z", "close" : 3006.767822265625},{"date" : "2018-01-04T01:00:00.000Z", "close" : 3006.736572265625},{"date" : "2018-01-04T02:00:00.000Z", "close" : 3006.66015625},{"date" : "2018-01-04T03:00:00.000Z", "close" : 3006.56884765625},{"date" : "2018-01-04T04:00:00.000Z", "close" : 3006.547607421875},{"date" : "2018-01-04T05:00:00.000Z", "close" : 3006.55126953125},{"date" : "2018-01-04T06:00:00.000Z", "close" : 3006.4560546875},{"date" : "2018-01-04T07:00:00.000Z", "close" : 3006.427734375},{"date" : "2018-01-04T08:00:00.000Z", "close" : 3006.42529296875},{"date" : "2018-01-04T09:00:00.000Z", "close" : 3006.437744140625},{"date" : "2018-01-04T10:00:00.000Z", "close" : 3006.3994140625},{"date" : "2018-01-04T11:00:00.000Z", "close" : 3006.398681640625},{"date" : "2018-01-04T12:00:00.000Z", "close" : 3006.4091796875},{"date" : "2018-01-04T13:00:00.000Z", "close" : 3006.4306640625},{"date" : "2018-01-04T15:00:00.000Z", "close" : 3006.249755859375},{"date" : "2018-01-04T16:00:00.000Z", "close" : 3006.174072265625},{"date" : "2018-01-04T17:00:00.000Z", "close" : 3006.1103515625},{"date" : "2018-01-04T18:00:00.000Z", "close" : 3006.058837890625},{"date" : "2018-01-04T19:00:00.000Z", "close" : 3006.1318359375},{"date" : "2018-01-04T20:00:00.000Z", "close" : 3006.27880859375},{"date" : "2018-01-04T21:00:00.000Z", "close" : 3006.420654296875},{"date" : "2018-01-04T22:00:00.000Z", "close" : 3006.48974609375},{"date" : "2018-01-04T23:00:00.000Z", "close" : 3006.534423828125},{"date" : "2018-01-05T00:00:00.000Z", "close" : 3006.4951171875},{"date" : "2018-01-05T01:00:00.000Z", "close" : 3006.457763671875},{"date" : "2018-01-05T02:00:00.000Z", "close" : 3006.35546875},{"date" : "2018-01-05T03:00:00.000Z", "close" : 3006.304443359375},{"date" : "2018-01-05T04:00:00.000Z", "close" : 3006.2841796875},{"date" : "2018-01-05T05:00:00.000Z", "close" : 3006.1494140625},{"date" : "2018-01-05T06:00:00.000Z", "close" : 3006.0537109375},{"date" : "2018-01-05T07:00:00.000Z", "close" : 3006.025390625},{"date" : "2018-01-05T08:00:00.000Z", "close" : 3006.00927734375},{"date" : "2018-01-05T09:00:00.000Z", "close" : 3005.973876953125},{"date" : "2018-01-05T10:00:00.000Z", "close" : 3005.9267578125},{"date" : "2018-01-05T11:00:00.000Z", "close" : 3005.99853515625},{"date" : "2018-01-05T12:00:00.000Z", "close" : 3006.06103515625},{"date" : "2018-01-05T13:00:00.000Z", "close" : 3006.1572265625},{"date" : "2018-01-05T14:00:00.000Z", "close" : 3006.09814453125},{"date" : "2018-01-05T15:00:00.000Z", "close" : 3006.068115234375},{"date" : "2018-01-05T16:00:00.000Z", "close" : 3005.9453125},{"date" : "2018-01-05T17:00:00.000Z", "close" : 3005.849609375},{"date" : "2018-01-05T18:00:00.000Z", "close" : 3005.841796875},{"date" : "2018-01-05T19:00:00.000Z", "close" : 3005.892333984375},{"date" : "2018-01-05T20:00:00.000Z", "close" : 3006.010009765625},{"date" : "2018-01-05T21:00:00.000Z", "close" : 3006.190185546875},{"date" : "2018-01-05T22:00:00.000Z", "close" : 3006.24853515625},{"date" : "2018-01-05T23:00:00.000Z", "close" : 3006.27978515625},{"date" : "2018-01-06T00:00:00.000Z", "close" : 3006.260498046875},{"date" : "2018-01-06T01:00:00.000Z", "close" : 3006.234619140625},{"date" : "2018-01-06T02:00:00.000Z", "close" : 3006.08203125},{"date" : "2018-01-06T03:00:00.000Z", "close" : 3006.059814453125},{"date" : "2018-01-06T04:00:00.000Z", "close" : 3006.04833984375},{"date" : "2018-01-06T05:00:00.000Z", "close" : 3006.031494140625},{"date" : "2018-01-06T06:00:00.000Z", "close" : 3005.95458984375},{"date" : "2018-01-06T07:00:00.000Z", "close" : 3005.991943359375},{"date" : "2018-01-06T08:00:00.000Z", "close" : 3006.026123046875},{"date" : "2018-01-06T09:00:00.000Z", "close" : 3006.185546875},{"date" : "2018-01-06T10:00:00.000Z", "close" : 3006.19873046875},{"date" : "2018-01-06T11:00:00.000Z", "close" : 3006.308837890625},{"date" : "2018-01-06T12:00:00.000Z", "close" : 3006.27978515625},{"date" : "2018-01-06T13:00:00.000Z", "close" : 3006.2919921875},{"date" : "2018-01-06T14:00:00.000Z", "close" : 3006.262939453125},{"date" : "2018-01-06T15:00:00.000Z", "close" : 3006.1708984375},{"date" : "2018-01-06T16:00:00.000Z", "close" : 3006.040283203125},{"date" : "2018-01-06T17:00:00.000Z", "close" : 3006.08740234375},{"date" : "2018-01-06T18:00:00.000Z", "close" : 3006.060546875},{"date" : "2018-01-06T19:00:00.000Z", "close" : 3006.130859375},{"date" : "2018-01-06T20:00:00.000Z", "close" : 3006.231201171875},{"date" : "2018-01-06T21:00:00.000Z", "close" : 3006.427001953125},{"date" : "2018-01-06T22:00:00.000Z", "close" : 3006.48779296875},{"date" : "2018-01-06T23:00:00.000Z", "close" : 3006.506591796875},{"date" : "2018-01-07T00:00:00.000Z", "close" : 3006.4873046875},{"date" : "2018-01-07T01:00:00.000Z", "close" : 3006.45703125},{"date" : "2018-01-07T02:00:00.000Z", "close" : 3006.3994140625},{"date" : "2018-01-07T03:00:00.000Z", "close" : 3006.370361328125},{"date" : "2018-01-07T04:00:00.000Z", "close" : 3006.359619140625},{"date" : "2018-01-07T05:00:00.000Z", "close" : 3006.36865234375},{"date" : "2018-01-07T06:00:00.000Z", "close" : 3006.364990234375},{"date" : "2018-01-07T07:00:00.000Z", "close" : 3006.4169921875},{"date" : "2018-01-07T08:00:00.000Z", "close" : 3006.45166015625},{"date" : "2018-01-07T09:00:00.000Z", "close" : 3006.49609375},{"date" : "2018-01-07T10:00:00.000Z", "close" : 3006.4951171875},{"date" : "2018-01-07T11:00:00.000Z", "close" : 3006.437744140625},{"date" : "2018-01-07T12:00:00.000Z", "close" : 3006.431396484375},{"date" : "2018-01-07T13:00:00.000Z", "close" : 3006.48583984375},{"date" : "2018-01-07T14:00:00.000Z", "close" : 3006.40478515625},{"date" : "2018-01-07T15:00:00.000Z", "close" : 3006.393310546875},{"date" : "2018-01-07T16:00:00.000Z", "close" : 3006.335693359375},{"date" : "2018-01-07T17:00:00.000Z", "close" : 3006.284423828125},{"date" : "2018-01-07T18:00:00.000Z", "close" : 3006.342529296875},{"date" : "2018-01-07T19:00:00.000Z", "close" : 3006.442138671875},{"date" : "2018-01-07T20:00:00.000Z", "close" : 3006.567138671875},{"date" : "2018-01-07T21:00:00.000Z", "close" : 3006.702880859375},{"date" : "2018-01-07T22:00:00.000Z", "close" : 3006.80859375},{"date" : "2018-01-07T23:00:00.000Z", "close" : 3006.862548828125},{"date" : "2018-01-08T00:00:00.000Z", "close" : 3006.864501953125},{"date" : "2018-01-08T01:00:00.000Z", "close" : 3006.864013671875},{"date" : "2018-01-08T02:00:00.000Z", "close" : 3006.803955078125},{"date" : "2018-01-08T03:00:00.000Z", "close" : 3006.752197265625},{"date" : "2018-01-08T04:00:00.000Z", "close" : 3006.71533203125},{"date" : "2018-01-08T05:00:00.000Z", "close" : 3006.721435546875},{"date" : "2018-01-08T06:00:00.000Z", "close" : 3006.7099609375},{"date" : "2018-01-08T07:00:00.000Z", "close" : 3006.8369140625},{"date" : "2018-01-08T08:00:00.000Z", "close" : 3006.846435546875},{"date" : "2018-01-08T09:00:00.000Z", "close" : 3006.939697265625},{"date" : "2018-01-08T10:00:00.000Z", "close" : 3006.9111328125},{"date" : "2018-01-08T11:00:00.000Z", "close" : 3007.017822265625},{"date" : "2018-01-08T12:00:00.000Z", "close" : 3007.07373046875},{"date" : "2018-01-08T13:00:00.000Z", "close" : 3007.074462890625},{"date" : "2018-01-08T14:00:00.000Z", "close" : 3007.0654296875},{"date" : "2018-01-08T15:00:00.000Z", "close" : 3007.01318359375},{"date" : "2018-01-08T16:00:00.000Z", "close" : 3006.973388671875},{"date" : "2018-01-08T17:00:00.000Z", "close" : 3006.923583984375},{"date" : "2018-01-08T18:00:00.000Z", "close" : 3006.984130859375},{"date" : "2018-01-08T19:00:00.000Z", "close" : 3007.1123046875},{"date" : "2018-01-08T20:00:00.000Z", "close" : 3007.22900390625},{"date" : "2018-01-08T21:00:00.000Z", "close" : 3007.3017578125},{"date" : "2018-01-08T22:00:00.000Z", "close" : 3007.3251953125},{"date" : "2018-01-08T23:00:00.000Z", "close" : 3007.22412109375},{"date" : "2018-01-09T00:00:00.000Z", "close" : 3007.217529296875},{"date" : "2018-01-09T01:00:00.000Z", "close" : 3007.25439453125},{"date" : "2018-01-09T02:00:00.000Z", "close" : 3007.212646484375},{"date" : "2018-01-09T03:00:00.000Z", "close" : 3007.3515625},{"date" : "2018-01-09T04:00:00.000Z", "close" : 3007.412353515625},{"date" : "2018-01-09T05:00:00.000Z", "close" : 3007.5693359375},{"date" : "2018-01-09T06:00:00.000Z", "close" : 3007.524169921875},{"date" : "2018-01-09T07:00:00.000Z", "close" : 3007.635009765625},{"date" : "2018-01-09T08:00:00.000Z", "close" : 3007.713623046875},{"date" : "2018-01-09T09:00:00.000Z", "close" : 3007.879150390625},{"date" : "2018-01-09T10:00:00.000Z", "close" : 3007.9404296875},{"date" : "2018-01-09T11:00:00.000Z", "close" : 3008.196044921875},{"date" : "2018-01-09T12:00:00.000Z", "close" : 3008.280517578125},{"date" : "2018-01-09T13:00:00.000Z", "close" : 3008.402587890625},{"date" : "2018-01-09T14:00:00.000Z", "close" : 3008.5078125},{"date" : "2018-01-09T15:00:00.000Z", "close" : 3008.433349609375},{"date" : "2018-01-09T16:00:00.000Z", "close" : 3008.135986328125},{"date" : "2018-01-09T17:00:00.000Z", "close" : 3007.904296875},{"date" : "2018-01-09T18:00:00.000Z", "close" : 3007.796630859375},{"date" : "2018-01-09T19:00:00.000Z", "close" : 3007.8056640625},{"date" : "2018-01-09T20:00:00.000Z", "close" : 3007.915771484375},{"date" : "2018-01-09T21:00:00.000Z", "close" : 3008.042236328125},{"date" : "2018-01-09T22:00:00.000Z", "close" : 3008.143798828125}
];

var data4 = [
	{"date" : " 2017-12-31 21:00 ", "close" : -1.0267488554199176},{"date" : " 2017-12-31 22:00 ", "close" : -1.0285251204985073},{"date" : " 2017-12-31 23:00 ", "close" : -1.0264019190146811},{"date" : " 2018-01-01 00:00 ", "close" : -1.0262385052107943},
	{"date" : " 2018-01-01 01:00 ", "close" : -1.0374939899077091},{"date" : " 2018-01-01 02:00 ", "close" : -1.012033641888685},{"date" : " 2018-01-01 03:00 ", "close" : -1.020895663933139},{"date" : " 2018-01-01 04:00 ", "close" : -1.0199748458893154},
	{"date" : " 2018-01-01 05:00 ", "close" : -1.0193661129378384},{"date" : " 2018-01-01 06:00 ", "close" : -1.021059286129197},{"date" : " 2018-01-01 07:00 ", "close" : -1.0153098487662433},{"date" : " 2018-01-01 08:00 ", "close" : -1.0180550685077279},
	{"date" : " 2018-01-01 09:00 ", "close" : -1.0373223068769093},{"date" : " 2018-01-01 10:00 ", "close" : -1.037854077544587},{"date" : " 2018-01-01 11:00 ", "close" : -1.033906134461951},{"date" : " 2018-01-01 12:00 ", "close" : -1.0087420717172435},
	{"date" : " 2018-01-01 13:00 ", "close" : -1.002803853799243},{"date" : " 2018-01-01 14:00 ", "close" : -0.9918928773529458},{"date" : " 2018-01-01 15:00 ", "close" : -1.0077089179654095},{"date" : " 2018-01-01 16:00 ", "close" : -0.9982059551126028},
	{"date" : " 2018-01-01 17:00 ", "close" : -1.0087569611416747},{"date" : " 2018-01-01 18:00 ", "close" : -1.0073729229488961},{"date" : " 2018-01-01 19:00 ", "close" : -1.012074881737159},{"date" : " 2018-01-01 20:00 ", "close" : -1.0026423327988923},
	{"date" : " 2018-01-01 21:00 ", "close" : -1.013343637534156},{"date" : " 2018-01-01 22:00 ", "close" : -1.0038586532456648},{"date" : " 2018-01-01 23:00 ", "close" : -1.0165803163326679},{"date" : " 2018-01-02 00:00 ", "close" : -1.003874426438223},
	{"date" : " 2018-01-02 01:00 ", "close" : -1.0038586532456648},{"date" : " 2018-01-02 02:00 ", "close" : -0.9991627956520901},{"date" : " 2018-01-02 03:00 ", "close" : -1.004919308361771},{"date" : " 2018-01-02 04:00 ", "close" : -0.9898495071928082},
	{"date" : " 2018-01-02 05:00 ", "close" : -0.9926885385815254},{"date" : " 2018-01-02 06:00 ", "close" : -0.9892101909977455},{"date" : " 2018-01-02 07:00 ", "close" : -1.0028141247098077},{"date" : " 2018-01-02 08:00 ", "close" : -0.9931420664709734},
	{"date" : " 2018-01-02 09:00 ", "close" : -1.0100541318648553},{"date" : " 2018-01-02 10:00 ", "close" : -1.0094140706266685},{"date" : " 2018-01-02 11:00 ", "close" : -0.9998803952350883},{"date" : " 2018-01-02 12:00 ", "close" : -0.989713178058075},{"date" : " 2018-01-02 13:00 ", "close" : -1.0008438515999742},{"date" : " 2018-01-02 14:00 ", "close" : -0.9798218430317647},{"date" : " 2018-01-02 15:00 ", "close" : -1.000587869725429},{"date" : " 2018-01-02 16:00 ", "close" : -1.006803667395583},{"date" : " 2018-01-02 17:00 ", "close" : -1.007949496956364},{"date" : " 2018-01-02 18:00 ", "close" : -1.0014247977204676},{"date" : " 2018-01-02 19:00 ", "close" : -1.0172698180653654},{"date" : " 2018-01-02 20:00 ", "close" : -0.9980354226998216},{"date" : " 2018-01-02 21:00 ", "close" : -1.0158656133823527},{"date" : " 2018-01-02 22:00 ", "close" : -0.995909500639037},{"date" : " 2018-01-02 23:00 ", "close" : -1.0157682181758148},{"date" : " 2018-01-03 00:00 ", "close" : -1.0175964296398305},{"date" : " 2018-01-03 01:00 ", "close" : -1.0119215849343064},{"date" : " 2018-01-03 02:00 ", "close" : -1.003042670734139},{"date" : " 2018-01-03 03:00 ", "close" : -1.021141460698054},{"date" : " 2018-01-03 04:00 ", "close" : -0.9950420851679596},{"date" : " 2018-01-03 05:00 ", "close" : -1.0142332772914173},{"date" : " 2018-01-03 06:00 ", "close" : -0.9975241387202303},{"date" : " 2018-01-03 07:00 ", "close" : -1.009737237901426},{"date" : " 2018-01-03 08:00 ", "close" : -1.0197807387352995},{"date" : " 2018-01-03 09:00 ", "close" : -1.0170016420654306},{"date" : " 2018-01-03 10:00 ", "close" : -1.0189033815910378},{"date" : " 2018-01-03 11:00 ", "close" : -1.0234084723684767},{"date" : " 2018-01-03 12:00 ", "close" : -1.0040487820499422},{"date" : " 2018-01-03 13:00 ", "close" : -1.003794805266061},{"date" : " 2018-01-03 14:00 ", "close" : -0.9893709702838649},{"date" : " 2018-01-03 15:00 ", "close" : -1.0016844402687113},{"date" : " 2018-01-03 16:00 ", "close" : -0.9960134495157389},{"date" : " 2018-01-03 17:00 ", "close" : -1.0060405945580397},{"date" : " 2018-01-03 18:00 ", "close" : -1.007879373884812},{"date" : " 2018-01-03 19:00 ", "close" : -1.0295239630583168},{"date" : " 2018-01-03 20:00 ", "close" : -1.0059495724605156},{"date" : " 2018-01-03 21:00 ", "close" : -1.0182899775292285},{"date" : " 2018-01-03 22:00 ", "close" : -1.017440407660125},{"date" : " 2018-01-03 23:00 ", "close" : -1.019341947292311},{"date" : " 2018-01-04 00:00 ", "close" : -1.0277817434788332},{"date" : " 2018-01-04 01:00 ", "close" : -1.0150610533424453},{"date" : " 2018-01-04 02:00 ", "close" : -1.011243663929342},{"date" : " 2018-01-04 03:00 ", "close" : -1.030775607225003},{"date" : " 2018-01-04 04:00 ", "close" : -1.007484431301215},{"date" : " 2018-01-04 05:00 ", "close" : -1.0212141936047843},{"date" : " 2018-01-04 07:00 ", "close" : -1.0356065367193352},{"date" : " 2018-01-04 08:00 ", "close" : -1.027243802918541},{"date" : " 2018-01-04 09:00 ", "close" : -1.046526481428792},{"date" : " 2018-01-04 10:00 ", "close" : -1.03428791630974},{"date" : " 2018-01-04 11:00 ", "close" : -1.04025482685865},{"date" : " 2018-01-04 12:00 ", "close" : -1.0141719219151994},{"date" : " 2018-01-04 13:00 ", "close" : -1.0041396165194767},{"date" : " 2018-01-04 14:00 ", "close" : -0.9989715651929956},{"date" : " 2018-01-04 15:00 ", "close" : -1.0075241387202354},{"date" : " 2018-01-04 16:00 ", "close" : -1.012404091719695},{"date" : " 2018-01-04 17:00 ", "close" : -1.0185325617936414},{"date" : " 2018-01-04 18:00 ", "close" : -1.0131604712115845},{"date" : " 2018-01-04 19:00 ", "close" : -1.0205532988412003},{"date" : " 2018-01-04 20:00 ", "close" : -1.0076041984041737},{"date" : " 2018-01-04 21:00 ", "close" : -1.0421650334362518},{"date" : " 2018-01-04 22:00 ", "close" : -1.0203340590337362},{"date" : " 2018-01-04 23:00 ", "close" : -1.0222381133402152},{"date" : " 2018-01-05 00:00 ", "close" : -1.0219422232426112},{"date" : " 2018-01-05 01:00 ", "close" : -1.029322665920425},{"date" : " 2018-01-05 02:00 ", "close" : -1.0285379408502662},{"date" : " 2018-01-05 03:00 ", "close" : -1.025078328343973},{"date" : " 2018-01-05 04:00 ", "close" : -1.0050140737967652},{"date" : " 2018-01-05 05:00 ", "close" : -1.0164793664256635},{"date" : " 2018-01-05 06:00 ", "close" : -1.0087263305439862},{"date" : " 2018-01-05 07:00 ", "close" : -1.008860355982999},{"date" : " 2018-01-05 08:00 ", "close" : -1.021071224729134},{"date" : " 2018-01-05 09:00 ", "close" : -1.0399224092834558},{"date" : " 2018-01-05 10:00 ", "close" : -1.0149307584843896},{"date" : " 2018-01-05 11:00 ", "close" : -1.0265429945061966},{"date" : " 2018-01-05 12:00 ", "close" : -1.0124102170039961},{"date" : " 2018-01-05 13:00 ", "close" : -0.9975402790354266},{"date" : " 2018-01-05 14:00 ", "close" : -0.994826482595677},{"date" : " 2018-01-05 15:00 ", "close" : -1.0047959717124328},{"date" : " 2018-01-05 16:00 ", "close" : -0.993148875372956},{"date" : " 2018-01-05 17:00 ", "close" : -0.995933888829164},{"date" : " 2018-01-05 18:00 ", "close" : -1.0184301817299186},{"date" : " 2018-01-05 19:00 ", "close" : -1.024234070513991},{"date" : " 2018-01-05 20:00 ", "close" : -0.9969020557318302},{"date" : " 2018-01-05 21:00 ", "close" : -1.02613808667342},{"date" : " 2018-01-05 22:00 ", "close" : -1.0069990234914243},{"date" : " 2018-01-05 23:00 ", "close" : -1.0208664054461067},{"date" : " 2018-01-06 00:00 ", "close" : -1.0027061097061747},{"date" : " 2018-01-06 01:00 ", "close" : -1.0038983927603011},{"date" : " 2018-01-06 02:00 ", "close" : -0.9930005547720171},{"date" : " 2018-01-06 03:00 ", "close" : -1.0033615494475399},{"date" : " 2018-01-06 04:00 ", "close" : -0.9947959717124419},{"date" : " 2018-01-06 05:00 ", "close" : -1.0025966119351821},{"date" : " 2018-01-06 06:00 ", "close" : -0.9840311422098509},{"date" : " 2018-01-06 07:00 ", "close" : -1.0052157158925255},{"date" : " 2018-01-06 08:00 ", "close" : -1.0017540627164507},{"date" : " 2018-01-06 09:00 ", "close" : -1.0018622249678444},{"date" : " 2018-01-06 10:00 ", "close" : -1.0047020724442248},{"date" : " 2018-01-06 11:00 ", "close" : -0.99963080894738},{"date" : " 2018-01-06 12:00 ", "close" : -0.9944275977144379},{"date" : " 2018-01-06 13:00 ", "close" : -0.9888738860101469},{"date" : " 2018-01-06 14:00 ", "close" : -0.9770456319695269},{"date" : " 2018-01-06 15:00 ", "close" : -1.0004150860863383},{"date" : " 2018-01-06 16:00 ", "close" : -0.9767335846295238},{"date" : " 2018-01-06 17:00 ", "close" : -0.9980644956576228},{"date" : " 2018-01-06 18:00 ", "close" : -0.991243663929346},{"date" : " 2018-01-06 19:00 ", "close" : -1.002677505444474},{"date" : " 2018-01-06 20:00 ", "close" : -0.9951350111829056},{"date" : " 2018-01-06 21:00 ", "close" : -1.0015853842759341},{"date" : " 2018-01-06 22:00 ", "close" : -0.9885673834613398},{"date" : " 2018-01-06 23:00 ", "close" : -1.0024770603526818},{"date" : " 2018-01-07 00:00 ", "close" : -0.9946320142768812},{"date" : " 2018-01-07 01:00 ", "close" : -0.9830281881356981},{"date" : " 2018-01-07 02:00 ", "close" : -0.9724040917196888},{"date" : " 2018-01-07 03:00 ", "close" : -0.975738796680325},{"date" : " 2018-01-07 04:00 ", "close" : -0.9716822554788038},{"date" : " 2018-01-07 05:00 ", "close" : -0.9757974429255638},{"date" : " 2018-01-07 06:00 ", "close" : -0.9746760833795136},{"date" : " 2018-01-07 07:00 ", "close" : -0.9873431950098635},{"date" : " 2018-01-07 08:00 ", "close" : -0.9898454301986517},{"date" : " 2018-01-07 09:00 ", "close" : -1.0084380593078528},{"date" : " 2018-01-07 10:00 ", "close" : -1.0048916123551166},{"date" : " 2018-01-07 11:00 ", "close" : -0.9985471765673495},{"date" : " 2018-01-07 12:00 ", "close" : -0.9884317670280254},{"date" : " 2018-01-07 13:00 ", "close" : -1.0045076017446588},{"date" : " 2018-01-07 14:00 ", "close" : -0.9927498510849873},{"date" : " 2018-01-07 15:00 ", "close" : -0.9865574829270924},{"date" : " 2018-01-07 16:00 ", "close" : -0.9878058343495111},{"date" : " 2018-01-07 17:00 ", "close" : -0.9981714897528988},{"date" : " 2018-01-07 18:00 ", "close" : -0.9897850750663437},{"date" : " 2018-01-07 19:00 ", "close" : -0.996704738434353},{"date" : " 2018-01-07 20:00 ", "close" : -1.003143161069623},{"date" : " 2018-01-07 21:00 ", "close" : -1.0070440637558917},{"date" : " 2018-01-07 22:00 ", "close" : -0.999710373506467},{"date" : " 2018-01-07 23:00 ", "close" : -1.0008506918824835},{"date" : " 2018-01-08 00:00 ", "close" : -0.9869363591519047},{"date" : " 2018-01-08 01:00 ", "close" : -0.9965457476121244},{"date" : " 2018-01-08 02:00 ", "close" : -1.007610474560475},{"date" : " 2018-01-08 03:00 ", "close" : -0.9964817913861097},{"date" : " 2018-01-08 04:00 ", "close" : -0.9922180996189027},{"date" : " 2018-01-08 05:00 ", "close" : -1.0026862654399835},{"date" : " 2018-01-08 06:00 ", "close" : -0.99691222858808},{"date" : " 2018-01-08 07:00 ", "close" : -1.0028390578335644},{"date" : " 2018-01-08 08:00 ", "close" : -0.9880805012938723},{"date" : " 2018-01-08 09:00 ", "close" : -1.0255688628093464},{"date" : " 2018-01-08 10:00 ", "close" : -1.0149467073128946},{"date" : " 2018-01-08 11:00 ", "close" : -0.9868749939397574},{"date" : " 2018-01-08 12:00 ", "close" : -0.9814719016410933},{"date" : " 2018-01-08 13:00 ", "close" : -0.987979444600235},{"date" : " 2018-01-08 14:00 ", "close" : -0.9829619891016748},{"date" : " 2018-01-08 15:00 ", "close" : -1.0083506318652198},{"date" : " 2018-01-08 16:00 ", "close" : -0.9934591826765127},{"date" : " 2018-01-08 17:00 ", "close" : -0.9977025892975959},{"date" : " 2018-01-08 18:00 ", "close" : -1.0110156686041378},{"date" : " 2018-01-08 19:00 ", "close" : -0.9898174965790005},{"date" : " 2018-01-08 20:00 ", "close" : -0.9886793901699278},{"date" : " 2018-01-08 21:00 ", "close" : -0.9790373698345647},{"date" : " 2018-01-08 22:00 ", "close" : -1.0001624326869276},{"date" : " 2018-01-08 23:00 ", "close" : -0.971023892532834},{"date" : " 2018-01-09 00:00 ", "close" : -1.0212841044945336},{"date" : " 2018-01-09 01:00 ", "close" : -0.9971159668621326},{"date" : " 2018-01-09 02:00 ", "close" : -0.9756193995267024},{"date" : " 2018-01-09 03:00 ", "close" : -0.9890653554981936},{"date" : " 2018-01-09 04:00 ", "close" : -1.0030821845548372},{"date" : " 2018-01-09 05:00 ", "close" : -0.9911439684184797},{"date" : " 2018-01-09 06:00 ", "close" : -0.9791136088025425},{"date" : " 2018-01-09 07:00 ", "close" : -0.9814938001084457},{"date" : " 2018-01-09 08:00 ", "close" : -0.991339027994961},{"date" : " 2018-01-09 09:00 ", "close" : -1.0131941977824894},{"date" : " 2018-01-09 10:00 ", "close" : -1.044355373983315},{"date" : " 2018-01-09 11:00 ", "close" : -1.000130868589018},{"date" : " 2018-01-09 12:00 ", "close" : -1.0105309126321558},{"date" : " 2018-01-09 13:00 ", "close" : -1.0107150580085245},{"date" : " 2018-01-09 14:00 ", "close" : -0.9863346344431889}
];

var data3 = [
	{"date" : '2018-01-09T13:00:00.000Z', "close" : 58.13},
	{"date" : '2018-01-09T14:00:00.000Z', "close" : 53.98},
	{"date" : '2018-01-09T15:00:00.000Z', "close" : 67.00},
	{"date" : '2018-01-09T16:00:00.000Z', "close" : 89.70},
	{"date" : '2018-01-09T17:00:00.000Z', "close" : 99.00},
	{"date" : '2018-01-09T18:00:00.000Z', "close" : 130.28},
	{"date" : '2018-01-09T19:00:00.000Z', "close" : 166.70}
];
/*
	'2018-01-09T13:00:00.000Z'
	'2018-01-09T14:00:00.000Z'
	'2018-01-09T15:00:00.000Z'
	'2018-01-09T16:00:00.000Z'
	'2018-01-09T17:00:00.000Z'
	'2018-01-09T18:00:00.000Z'
	'2018-01-09T19:00:00.000Z'
 */
var data2= [
	{"date" : '1-May-12', "close" : 58.13},
	{"date" : '30-Apr-12', "close" : 53.98},
	{"date" : '27-Apr-12', "close" : 67.00},
	{"date" : '26-Apr-12', "close" : 89.70},
	{"date" : '25-Apr-12', "close" : 99.00},
	{"date" : '24-Apr-12', "close" : 130.28},
	{"date" : '23-Apr-12', "close" : 166.70},
	{"date" : '20-Apr-12', "close" : 234.98},
	{"date" : '19-Apr-12', "close" : 345.44},
	{"date" : '18-Apr-12', "close" : 443.34},
	{"date" : '17-Apr-12', "close" : 543.70},
	{"date" : '16-Apr-12', "close" : 580.13},
	{"date" : '13-Apr-12', "close" : 605.23},
	{"date" : '12-Apr-12', "close" : 622.77},
	{"date" : '11-Apr-12', "close" : 626.20},
	{"date" : '10-Apr-12', "close" : 628.44},
	{"date" : '9-Apr-12', "close" : 636.24},
	{"date" : '5-Apr-12', "close" : 633.68},
	{"date" : '4-Apr-12', "close" : 624.31},
	{"date" : '3-Apr-12', "close" : 629.32},
	{"date" : '2-Apr-12', "close" : 618.63},
	{"date" : '30-Mar-12', "close" : 599.55},
	{"date" : '30-Mar-12', "close" : 599.55},
	{"date" : '30-Mar-12', "close" : 599.55},
	{"date" : '29-Mar-12', "close" : 609.86},
	{"date" : '28-Mar-12', "close" : 617.62},
	{"date" : '27-Mar-12', "close" : 614.48},
	{"date" : '26-Mar-12', "close" : 606.98}
];

/*
console.log(data[1].date);
for(var obj in data) {

	console.log(data[obj].date);
	console.log(data[obj].close);
}
 */

var margin = {top: 20, right: 20, bottom: 100, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

// parse the date / time
//var parseTime = d3.timeParse("%Y-%m-%d %H:%M");
var parseTime = d3.utcParse("%Y-%m-%dT%H:%M:%S.%LZ");

// fix the dates
data.forEach(function(d){
	//console.log("from data source : " + d.date);
//	d.date = moment(d.date).format("YYYY-MM-DD HH:mm");// from ISO8601 --> 2018-01-09 05:00
	//console.log("conver from : " + d.date);
//	d.date = parseTime(d.date.trim());	 // from 2018-01-09 05:00 --> Tue Jan 09 2018 05:00:00 GMT-0800 (Pacific Standard Time)
	//console.log("parsed with d3 : " + d.date);

	d.date = parseTime(d.date);// from ISO8601 --> Tue Jan 09 2018 05:00:00 GMT-0800 (Pacific Standard Time)
});

// set the ranges
var x = d3.scaleTime().range([0, width]);
var y = d3.scaleLinear().range([height, 0]);

// define the line
var valueline = d3.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.close); });

// append the svg obgect to the body of the page
// appends a 'group' element to 'svg'
// moves the 'group' element to the top left margin
var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
	.on('mousemove', function() {
    	console.log( d3.event.clientX, d3.event.clientY ) // log the mouse x,y position
	})
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

 // Scale the range of the data
 x.domain(d3.extent(data, function(d) { return d.date; }));
 y.domain([d3.min(data, function(d) { return d.close; }), d3.max(data, function(d) { return d.close; }) ]);

 // Add the valueline path.
svg.append("path")
	.data([data])
	.attr("class", "line")
	.attr("d", valueline);

  // Add the X Axis
svg.append("g")
	.attr("class", "axis")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x)
    	.tickFormat(d3.timeFormat("%Y-%m-%d %H"))
	)
    .selectAll("text")
    .style("text-anchor", "end")
    .attr("dx", "-.8em")
    .attr("dy", ".15em")
    .attr("transform", "rotate(-65)");

  // Add the Y Axis
svg.append("g")
	.attr("class", "axis")
	.call(d3.axisLeft(y));



</script>
</body>

<!---
<!DOCTYPE html>
<meta charset="utf-8">
<style>

.chart rect {
  fill: steelblue;
}

.chart text {
  fill: white;
  font: 10px sans-serif;
  text-anchor: end;
}

</style>
<svg class="chart"></svg>
<script src="//d3js.org/d3.v3.min.js"></script>
<script>

var data = [4, 8, 15, 16, 23, 42];

var width = 420,
    barHeight = 20;

var x = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, width]);

var chart = d3.select(".chart")
    .attr("width", width)
    .attr("height", barHeight * data.length);

var bar = chart.selectAll("g")
    .data(data)
  	.enter().append("g")
    .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

bar.append("rect")
    .attr("width", x)
    .attr("height", barHeight - 1);

bar.append("text")
    .attr("x", function(d) { return x(d) - 3; })
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d) { return d; });


//The data for our line
 var lineData = [ { "x": 1,   "value": 5},  { "x": 20,  "value": 20},
                  { "x": 40,  "value": 10}, { "x": 60,  "value": 40},
                  { "x": 80,  "value": 5},  { "x": 100, "value": 60}];


/* var lineData = [
	{'date': Sun Dec 31 2017 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.285251204985073},
	{'date': Sun Dec 31 2017 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.264019190146813},
	{'date': Mon Jan 01 2018 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.262385052107943},
	{'date': Mon Jan 01 2018 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.374939899077091},
	{'date': Mon Jan 01 2018 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.120336418886849},
	{'date': Mon Jan 01 2018 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.208956639331392},
	{'date': Mon Jan 01 2018 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.199748458893154},
	{'date': Mon Jan 01 2018 00:00:00 GMT-0800 (Pacific Standard Time), 'value': -10.193661129378382}
];				 */


var lineData = [ { "x": '2017-12-31',   "y": 5},  { "x": '2017-12-31',  "y": 20},
                 { "x": '2017-12-31',  "y": 10}, { "x": '2018-01-01',  "y": 40},
                 { "x": '2018-01-01',  "y": 5},  { "x": '2018-01-01', "y": 60}];


 //This is the accessor function we talked about above
 var lineFunction = d3.svg.line()
                          .x(function(d) { return d.x; })
                          .y(function(d) { return d.y; })
                         .interpolate("linear");

//The SVG Container
var svgContainer = d3.select("body").append("svg")
                                    .attr("width", 200)
                                    .attr("height", 200);

//The line SVG Path we draw
var lineGraph = svgContainer.append("path")
                            .attr("d", lineFunction(lineData))
                            .attr("stroke", "blue")
                            .attr("stroke-width", 2)
                            .attr("fill", "none");



</script>
<cfabort>
--->
<!---

<!DOCTYPE html>
<html>
	<head>
<style>

.chart div {
  font: 10px sans-serif;
  background-color: steelblue;
  text-align: right;
  padding: 3px;
  margin: 1px;
  color: white;
}

</style>
		<script src="https://d3js.org/d3.v3.min.js"></script>
		<script type="text/javascript">

			var data = [4, 8, 15, 16, 23, 42];

var x = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, 420]);

			d3.select(".chart")
				.selectAll("div")
			    .data(data)
			  	.enter().append("div")
			    .style("width", function(d) { return d * 10 + "px"; })
			    .text(function(d) { return d; });

		</script>
 	</head>
 <body>


	<div class="chart"></div>
--->
<!---
<svg width="50" height="50">
  <circle cx="25" cy="25" r="25" fill="purple" />
</svg>
<svg width="50" height="50">
  <rect x="0" y="0" width="50" height="50" fill="green" />
</svg>
<svg width="50" height="50">
  <circle cx="25" cy="25" r="25" fill="purple" />
</svg>
<svg width="50" height="50">
  <ellipse cx="25" cy="25" rx="15" ry="10" fill="red" />
</svg>
<svg width="50" height="50">
  <line x1="5" y1="5" x2="40" y2="40" stroke="gray" stroke-width="5"  />
</svg>
<svg width="50" height="50">
  <polyline fill="none" stroke="blue" stroke-width="2"
            points="05,30
                    15,30
                    15,20
                    25,20
                    25,10
                    35,10" />
</svg>
<svg width="50" height="50">
  <polygon fill="yellow" stroke="blue" stroke-width="2"
           points="05,30
                   15,10
                   25,30" />
</svg>
 --->
 <!---
 </body>
 </html>
  --->
  end
 <cfabort>


<!DOCTYPE html>
<html>
	<head>
		<cfinclude template="includes/common_head.cfm">
		<meta charset="utf-8">
		<title></title>
		<!--- <cfinclude template="includes/dashboard_common_head.cfm"> --->
		<script type="text/javascript">

			var socket, connected, authenticating, tm;
			var nextId = 0;
			var host = "app.sensemetrics.com";
			var port = 4201;
			var apiKey = "5888F4DC6CD3EB06AC2990B4";

			var gEntitySelection = 0;

			// Open a new socket connection
			socket = new WebSocket("wss://" + host + ":" + port + "/");
			// Listen for socket open events
			socket.onopen = function(event) {
			    //console.log("Socket opened with " + host + ":" + port);
			    writeToScreen("Socket opened with " + host + ":" + port, "black", 1);
			    // Perform socket authentication
			    authenticating = true;
			    sendRequest("authenticate", {
			        "code": apiKey
			    }, function(result) {
			        console.log("Authentication successful");
			        // Save the next request id
			        nextId = result.nextId;
			        // Set connection flags
			        connected = true;
			        authenticating = false;
			    });
			};

			// Listen for socket close events
			socket.onclose = function() {
			    //console.log("Socket closed");
			    writeToScreen("Socket closed", "red", 1);
			    // Set connection flags
			    connected = authenticating = false;
			    // Clear the socket object and reset request id
			    socket = undefined;
			    nextId = 0;
			};

			// Listen for socket messages
			socket.onmessage = function(event) {
			    onMessage(event.data);
			};

			var callbacks = {}

			function sendRequest(request, params, callback) {
			    // Get the request id to use
			    var requestId = nextId;
			    // Send the request message
			    socket.send(JSON.stringify({
			        "jsonrpc": "2.0",
			        "method": request,
			        "id": requestId,
			        "params": params
			    }));

			    // Save the response callback for later
			    callbacks[requestId] = callback;
			    // Increment the id for future requests
			    nextId++;

			    return requestId;
			};

			function onMessage(message) {

			    // Parse the JSON message body
			    var response = JSON.parse(message);

			    if ("result" in response) {
			        // Request succeeded without errors
			        callbacks[response.id](response.result);
			    } else if ("error" in response) {
			        // Request resulted in an error
			        if ("id" in response) {
			            // Send error information to original callback for handling
			            callbacks[response.id](response.error);
			        } else {
			            // Log all other socket errors
			            console.error("Received API error message: ", response.error);
			        }
			    }

			    if(response.result.time !== undefined) {
					writeToScreen(response.result.time,'blue', 1);
			    }
			};

			////keep socket open///////////////////////////////////////////////////
			setInterval(function() {
			    // Check if a connection host has been set
			    if (host !== undefined) {
			        // Check if a connection is already open
			        if (socket === undefined) {
			            // If no connection, establish a new one
			        } else {
			            // Make sure we are no actively authenticating
			            if (!authenticating) {
			                // Refresh the connection by sending a "time" request
			                sendRequest("time", {}, function() {
			                    connected = true;
			                });
			            }
			        }
			    } else {
			        // Set connection flags
			        connected = authenticating = false;
			    }
			}, 5000);

			function getHelp() {
				sendRequest("help", {}, function(result) {
    				console.log("Available API requests:", result);
				});
			}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			function getSelectedEntityCount() {
				var userMethod = $("#entities").val();
				var color = "black";

				$("#reportOutput").html("");

				switch(userMethod) {
					case "getNodes" :
						color = "darkgreen";
					break;
					case "getDevices" :
						color = "Indigo";
					break;
					case "getSensors" :
						color = "darkblue";
					break;
				}

				sendRequest(userMethod, {}, function(result) {
				   if (result.length > 0) {
						$("#msgBox").html($("#entities").val() +" selected " + result.length + " entities found.");

						getSelectedEntity(userMethod, color);
				    } else {
				        // Node could not be retrieved
				        console.error("Error retrieving Entities ("+userMethod+")", ":", result);
				    }
				});
			}

			function getSelectedEntity(userMethod, color) {
				sendRequest(userMethod, {}, function(result) {
				   if (result.length > 0) {
						for (var i = 0; i < result.length; i++) {
							//writeToScreen("Entity ID " + result[i].id + " Entity Type " + result[i].type, color, 2);
							writeToScreen(result[i].id, color, 2);
				        }
				    } else {
				        // Node could not be retrieved
				        console.error("Error retrieving Entities", ":", result);
				    }
				});
			}

			function getEntityDetails() {
				var userMethod = $("#entities").val();

				switch(userMethod) {
					case "getNodes" :
						getNodeDetail();
					break;
					case "getDevices" :
						getDeviceDetail();
					break;
					case "getSensors" :
						getSensorDetail();
					break;
				}
			}

			function getNodeDetail() {
				var sensor, subscriptionId, err, myJSON;
				var nodeId = $("#entityDetail").val();

				if(nodeId != "") {
				// Retrieve node from the server
					sendRequest("getNodes", {
						"nodes": [nodeId]
					}, function(result) {
						if (result.length > 0 && result[0].id === nodeId) {

							$("#entityDetailsTab").html("");
							tbl = makeTable(result, "CSSTableGenerator");
console.log(tbl);
							$(tbl).appendTo("#entityDetailsTab");

console.log("Logging getNodeDetail");
							myJSON = JSON.stringify(result);
							$("#entityDetailOutput").html(myJSON);
//							console.log(result);
//							console.log("got the result");
							// Sensor retrieved, subscribe to its updates
							node = result[0];
console.log("ID : " + node.id);
console.log("Type : " + node.type);
console.log("Props : " + node.props);
						} else {
							// Sensor could not be retrieved
							err = getKeys(result);
							$("#entityDetailOutput").html("Error retrieving node ! " + nodeId + " " + err);
							console.error("Error retrieving node !", nodeId, ":", result);
						}
					});
				} else {
					alert("Select a node ID");
				}
			}

			function getDeviceDetail() {
				var device, subscriptionId, err, myJSON;
				var deviceId = $("#entityDetail").val();

				if(deviceId != "") {
				// Retrieve device from the server
					sendRequest("getDevices", {
						"devices": [deviceId]
						}, function(result) {
						if (result.length > 0 && result[0].id === deviceId) {

							$("#entityDetailsTab").html("");
							tbl = makeTable(result, "CSSTableGenerator");
console.log(tbl);
							$(tbl).appendTo("#entityDetailsTab");

console.log("Logging getDeviceDetail");
							myJSON = JSON.stringify(result);
							$("#entityDetailOutput").html(myJSON);
//							console.log(result);
//							console.log("got the result");
							// Sensor retrieved, subscribe to its updates
							device = result[0];
console.log("ID : " + device.id);
console.log("Type : " + device.type);
console.log("Props : " + device.props);
						} else {
							// Device could not be retrieved
							err = getKeys(result);
							$("#entityDetailOutput").html("Error retrieving device ! " + deviceId + " " + err);
							console.error("Error retrieving device !", deviceId, ":", result);
						}
					});
				} else {
					alert("Select a device ID");
				}
			}

			function getSensorDetail() {
				var sensor, subscriptionId, err, myJSON, tbl;
				var sensorId = $("#entityDetail").val();

				if(sensorId != "") {
				// Retrieve sensor from the server
					sendRequest("getSensors", {
						"sensors": [sensorId]
						}, function(result) {
						if (result.length > 0 && result[0].id === sensorId) {

							$("#entityDetailsTab").html("");
							tbl = makeTable(result, "CSSTableGenerator");
console.log(tbl);
							$(tbl).appendTo("#entityDetailsTab");

						//if (result.length > 0 ) {
console.log("Logging getSensorDetail");
							myJSON = JSON.stringify(result);
							$("#entityDetailOutput").html(myJSON);
							// Sensor retrieved, subscribe to its updates
							sensor = result[0];
console.log("ID : " + sensor.id);
console.log("Type : " + sensor.type);
console.log("Device : " + sensor.device);
console.log("Props : " + sensor.props);
						} else {
							// Sensor could not be retrieved
							err = getKeys(result);
							$("#entityDetailOutput").html("Error retrieving sensor ! " + sensorId + " " + err);
							console.error("Error retrieving sensor !", sensorId, ":", result);
						}
					});
				} else {
					alert("Select a sensor ID");
				}
			}

			function getMetrics() {
				var allMetrics = [],  allUnits = {}, tbl;
				   // sensorId = "/fn/6C4F6D/node/dgsimlogger/032432/device/tilt4/sensor";
			   var sensorId = $("#entityDetail").val();

				// Retrieve metrics for this sensor
				sendRequest("getMetrics", {
				    "sensors": [sensorId]
				}, function(result) {
				    if (!("code" in result) && sensorId in result) {

				        // Save all metrics
				        allMetrics = result[sensorId];
				        var firstMetric = allMetrics[0].id;
//console.log("first Metric : "  + firstMetric);
				        $("#dump").html(firstMetric);
console.log("Metric ID : " + firstMetric);
						//console.log(allMetrics);

						$("#metricsTab").html("");
						tbl = makeTable(allMetrics, "CSSTableGenerator");
						$(tbl).appendTo("#metricsTab");


				        // Retrieve units for first available metric
				        sendRequest("getUnits", {
				            "metrics": [firstMetric]
				        }, function(result) {

				            // Save the retrieved units
				            allUnits[firstMetric] = result[firstMetric];

       				        $("#dump").html(allUnits);
							console.log(allUnits);

							$("#unitsTab").html("");
							tbl = makeTable(result, "CSSTableGenerator");
							$(tbl).appendTo("#unitsTab");
1111111
				        });

				    } else {
				        console.warn('Error retrieving metrics:', result);
				    }
				});
			}


			function getSeriesData() {

				var sensorId = $("#entityDetail").val(),
				    metricId = $("#usrMetric").val(),
				    unitId = $("#usrUnit").val();

console.log("series requested");
				// Create a local data object
				var series = {
				    id: sensorId,
				    metric: metricId,
				    data: {}
				};


console.log(series);
				// Create a set of parameters for data retrieval
				var retrievalParams = {
				    "sensor": series.id,
				    "metric": series.metric,
				    "unit": unitId,
				    "params": {
				        "ZERO_DATE": {
				            "value": "2017-03-01T22:00:00.000Z"
				        }
				    },
				    "startDate":"2017-01-07T04:00:49.000Z",
				    "endDate":"2017-01-09T22:00:47.000Z"
				    <!--- "startDate": "2017-01-01T23:17:10.305Z" --->
				};

				// Retrieve data from the server
				sendRequest("getData", retrievalParams, function(result) {

//console.log("Attemp to getdata()");
					//console.log(result);

				    if ("requestStatus" in result && result.requestStatus === "finished") {
				    // Data retrieval finished
console.log("got the data");


<!---  --->
	var html = "";
	var keys = Object.keys(series.data),
  	i, len = keys.length;

	keys.sort();

	for (i = 0; i < len; i++) {
  		k = keys[i];
  		console.log(k + ':' + series.data[k]);

  		html += '<span>' + k +   ':' + series.data[k] + '</span><br>';
}

if (html != "") {
	$("#dump").html("");
	$("#dump").html(html);
}

<!---  --->


//loop over retruned series
for(var key in series.data) {
		//console.log(key + " " + series.data[key]);
}

//console.log(result.data);//result from server has series all in order


	    	} else if ("data" in result) {
console.log("Saving all the data...");

				        // Save each data point locally
				        for (var date in result.data) {
				            if (result.data.hasOwnProperty(date)) {
				                series.data[date] = result.data[date];
//console.log(series.data[date]);
				            }
				        }

//console.log(series.data[date]);

				    } else if ("code" in result) {
				        console.error("Error retrieving data with params", params, ":", result);
				    }
				});
			}

			function subscrbeSensor() {
				//var sensor,
				//  sensorId = "/fn/6C4F6D/node/dgsimlogger/032432/device/tilt4/sensor",
				//  subscriptionId;
				var sensor, subscriptionId;
				var sensorId = $("#entityDetail").val();

				// Retrieve sensor from the server
				sendRequest("getSensors", {
				    "sensors": [sensorId]
					}, function(result) {

				    if (result.length > 0 && result[0].id === sensorId) {

				        // Sensor retrieved, subscribe to its updates
				        sensor = result[0];
				        subscriptionId = sendRequest("subscribeSensors", {
				            "sensors": [sensorId]
				        }, function(updates) {

				            if ("data" in updates) {

				                // Update the local sensor object
				                sensor = updates.data;
				            }
				        });

				    } else {

				        // Sensor could not be retrieved
				        console.error("Error retrieving sensor", sensorId, ":", result);
				    }
				});
			}

			function writeToScreen(message, color, wnd) 	{
				var pre = document.createElement("p");
				var sp =  document.createElement("span");

				sp.className = "clickable";
				sp.onclick = function(){$("#entityDetail").val(message) };
				sp.style.color = color;
				sp.appendChild( document.createTextNode(message) );

				pre.style.wordWrap = "break-word";
				pre.appendChild(sp);

				switch(wnd) {
					case 1 :
						statusOutput.appendChild(pre);
					break;
					case 2 :
						reportOutput.appendChild(pre);
					break;
					case 3 :
						entityDetailOutput.appendChild(pre);
					break;
				}
				//console.log("Logging WriteToScreen");
				if (wnd != 1) {
					console.log(message);
				}
			}

			var getKeys = function(obj){
			   var keys = [];
			   for(var key in obj){
			      keys.push(key);
			   }
			   return keys;
			}

			function closeConnection() {
			   // Close the connection, if open.
			   if (socket.readyState === WebSocket.OPEN) {
			      socket.close();

			      $("#statusOutput").html("");
			      writeToScreen("GoodBye!...", "green", 1);
			   }
			}


			// generate HTML code for an object
			function makeTable(json, css_class = 'tbl_calss', tabs = 1) {
			    // helper to tabulate the HTML tags. will return '\t\t\t' for num_of_tabs=3
			    var tab = function(num_of_tabs) {
			        var s = '';
//			        for (var i = 0; i < num_of_tabs; i++) {
//			            s += '\t';
//			        }
			        //console.log('tabbing done. tabs=' + tabs)
			        return s;
			    }
			    // recursive function that returns a fixed block of <td>......</td>.
			    var generate_td = function(json) {
			        if (!(typeof(json) == 'object')) {
			            // for primitive data - direct wrap in <td>...</td>
			            return tab(tabs) + '<td>'+json+'</td>';
			        } else {
			            // recursive call for objects to open a new sub-table inside the <td>...</td>
			            // (object[key] may be also an object)
			            var s = tab(++tabs)+'<td>';
			            s += tab(++tabs)+'<table class="'+css_class+'">';
			            for (var k in json){
			                s += tab(++tabs)+'<tr>';
			                s += tab(++tabs)+'<td>' + k + '</td>';
			                s += generate_td(json[k]);
			                s += tab(--tabs)+'</tr>' + tab(--tabs) + '';
			            }
			            // close the <td>...</td> external block
			            s +=	tab(tabs--)+'</table>';
			            s +=	tab(tabs--)+'</td>';
			            return s;
			        }
			    }
			    // construct the complete HTML code
			    var html_code = '' ;
			    html_code += tab(++tabs)+'<table class="'+css_class+'">';
			    html_code += tab(++tabs)+'<tr>';
			    html_code += generate_td(json);
			    html_code += tab(tabs--)+'</tr>';
			    html_code += tab(tabs--)+'</table>';
			    return html_code;
			}

			function clearUI() {
				$("#tableDataOutput").html("");
				$("#entityDetailOutput").html("");
				$("#metricsOutput").html("");
			}

			$(document).ready(function(){
				console.info("The document is ready...");

				$( "#tabs" ).tabs({selected:0});


			});


if (!Date.prototype.toISOString) {
  (function() {

    function pad(number) {
      if (number < 10) {
        return '0' + number;
      }
      return number;
    }

    Date.prototype.toISOString = function() {
      return this.getUTCFullYear() +
        '-' + pad(this.getUTCMonth() + 1) +
        '-' + pad(this.getUTCDate()) +
        'T' + pad(this.getUTCHours()) +
        ':' + pad(this.getUTCMinutes()) +
        ':' + pad(this.getUTCSeconds()) +
        '.' + (this.getUTCMilliseconds() / 1000).toFixed(3).slice(2, 5) +
        'Z';
    };

  }());
}

var today = new Date('05 October 2011 14:48 UTC');

console.log(today.toISOString()); // Returns 2011-10-05T14:48:00.000Z


		</script>

		<style type="text/css">
			*{
				/*border: 1px dotted blue;*/
			}

			#tabs .ui-tabs-panel {
				width: 620px;
    			height: 540px;
    			overflow: auto;
				padding: 0 15px;
			}

			.viewStyleSmall {
				padding: 3px;
				border: 1px solid gray;
				width: 300px;
				margin-right:20px;
				height:200px;
				overflow:scroll;
				font-size: small;
			}
			.viewStyleMed {
				padding: 3px;
				border: 1px solid gray;
				width: 500px;
				margin-right:20px;
				height:200px;
				overflow:scroll;
				font-size: small;
			}
			.viewStyle {
				padding: 3px;
				border: 1px solid gray;
				width: 830px;
				margin-right:20px;
				height:180px;
				overflow:scroll;
				font-size: small;
			}
			.messagePane {
				padding: 3px;
				border: 1px solid rgb(175,175,0);
				width: 830px;
				margin-left:50px;
				height:35px;
				font-size: small;
				background-color: rgb(255,255,180);
			}
			input {
				margin-right:10px;
			}



			.CSSTableGenerator {
				margin:0px;padding:0px;
				width:100%;
				border:1px solid #ffffff;

				-moz-border-radius-bottomleft:0px;
				-webkit-border-bottom-left-radius:0px;
				border-bottom-left-radius:0px;

				-moz-border-radius-bottomright:0px;
				-webkit-border-bottom-right-radius:0px;
				border-bottom-right-radius:0px;

				-moz-border-radius-topright:0px;
				-webkit-border-top-right-radius:0px;
				border-top-right-radius:0px;

				-moz-border-radius-topleft:0px;
				-webkit-border-top-left-radius:0px;
				border-top-left-radius:0px;
			}.CSSTableGenerator table{
				width:100%;
				height:100%;
				margin:0px;padding:0px;
			}.CSSTableGenerator tr:last-child td:last-child {
				-moz-border-radius-bottomright:0px;
				-webkit-border-bottom-right-radius:0px;
				border-bottom-right-radius:0px;
			}
			.CSSTableGenerator table tr:first-child td:first-child {
				-moz-border-radius-topleft:0px;
				-webkit-border-top-left-radius:0px;
				border-top-left-radius:0px;
			}
			.CSSTableGenerator table tr:first-child td:last-child {
				-moz-border-radius-topright:0px;
				-webkit-border-top-right-radius:0px;
				border-top-right-radius:0px;
			}.CSSTableGenerator tr:last-child td:first-child{
				-moz-border-radius-bottomleft:0px;
				-webkit-border-bottom-left-radius:0px;
				border-bottom-left-radius:0px;
			}.CSSTableGenerator tr:hover td{
				background-color:#2c6fb7;


			}
			.CSSTableGenerator td{
				vertical-align:middle;

				background-color:#80b3e5;

				border:1px solid #ffffff;
				border-width:0px 1px 1px 0px;
				text-align:left;
				padding:7px;
				font-size:10px;
				font-family:Arial;
				font-weight:normal;
				color:#fffcfc;
			}.CSSTableGenerator tr:last-child td{
				border-width:0px 1px 0px 0px;
			}.CSSTableGenerator tr td:last-child{
				border-width:0px 0px 1px 0px;
			}.CSSTableGenerator tr:last-child td:last-child{
				border-width:0px 0px 0px 0px;
			}

			.CSSTableGenerator tr:first-child td{
/*green
				background:-o-linear-gradient(bottom, #085E03 5%, #002B00 100%);
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #085E03), color-stop(1, #002B00) );
				background:-moz-linear-gradient( center top, #085E03 5%, #002B00 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#085E03", endColorstr="#002B00");
				background: -o-linear-gradient(top,#085E03,002B00);
	* /
			/*
				background:-o-linear-gradient(bottom, #033970 5%, #0764c1 100%);
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #033970), color-stop(1, #0764c1) );
				background:-moz-linear-gradient( center top, #033970 5%, #0764c1 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#033970", endColorstr="#0764c1");
				background: -o-linear-gradient(top,#033970,0764c1);
			*/
			background-color:#033970;
			border:0px solid #ffffff;
			/*text-align:center;*/
				border-width:0px 0px 1px 1px;
				font-size:14px;
				font-family:Arial;
				font-weight:normal;
				color:#ffffaa;
			}

			.CSSTableGenerator tr:first-child:hover td{
/*green
				background:-o-linear-gradient(bottom, #002B00 5%, #085E03 100%);
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #002B00), color-stop(1, #085E03) );
				background:-moz-linear-gradient( center top, #002B00 5%, #085E03 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#002B00", endColorstr="#085E03");
				background: -o-linear-gradient(top,#002B00,085E03);
*/
				/*
				background:-o-linear-gradient(bottom, #033970 5%, #0764c1 100%);
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #033970), color-stop(1, #0764c1) );
				background:-moz-linear-gradient( center top, #033970 5%, #0764c1 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#033970", endColorstr="#0764c1");
				background: -o-linear-gradient(top,#033970,0764c1);
			*/
				background-color:#033970;
			}
			.CSSTableGenerator tr:first-child td:first-child{
				border-width:0px 0px 1px 0px;
			}


		</style>
	</head>
	<body>
		<br/>

		<form id="mainForm">
			<div style="margin-left:50px;margin-bottom:5px;">

				<select id="entities" name="entities" onchange="getSelectedEntityCount();">
					<option value="0">..:: Select Item ::..</option>
					<option value="getNodes">getNodes</option>
					<option value="getDevices">getDevices </option>
					<option value="getSensors">getSensors</option>
				</select>

				<!--- <input type="button" value="Go" onclick="getSelectedEntityCount();"> --->
				<input type="button" value="Close" onclick="closeConnection();">
				<input type="button" value="Help" onclick="getHelp();">
				<input type="button" value="Clear UI" onclick="clearUI();">

				<input type="submit" value="Reset">
			</div>

			<div class="messagePane" id="msgBox">
				Select Entity Type to begin.
			</div>

			<div style="display: flex;border: 0px solid blue;">

				<div style="border: 0px solid red"><!--- left panel --->
			 		<div style="display: flex;margin-left:50px;margin-bottom:5px;margin-top:5px;">
						<div class="viewStyleSmall" id="statusOutput"></div>
						<div class="viewStyleMed" id="reportOutput"></div>
					</div>
					<div style="margin-left:50px;margin-bottom:5px;">
						<input type="text" id="entityDetail" name="entityDetail" value="" size="80" style="background-color:rgb(255,255,180);">
						<input type="button" value="Get Detail" onclick="getEntityDetails();">
						<input type="button" value="Get Metrics" onclick="getMetrics();">
						<input tye="text" id="usrMetric" name="usrMetric">
						<input tye="text" id="usrUnit" name="usrUnit">
						<input type="button" value="Get Series Data" onclick="getSeriesData();">
						<!--- <input type="button" value="Get Entity Detail" onclick="getSensorDetail();"> --->
						<div class="viewStyle" id="entityDetailOutput">entityDetailOutput</div>
						<div class="viewStyle" id="dump">dump</div>

						<!--- <div class="" id="metricsOutput">metricsOutput</div> --->
					</div>
				</div>

				<div style="border: 0px solid green"><!--- right panel --->
					<div id="tabs">
					 	<ul>
					    	<li><a href="#entityDetailsTab">Entity Details</a></li>
					    	<li><a href="#metricsTab">Metrics</a></li>
					    	<li><a href="#unitsTab">Units</a></li>
					  	</ul>

					  	<div id="entityDetailsTab"></div>
					  	<div id="metricsTab"></div>
					  	<div id="unitsTab"></div>
					</div>

					<!--- <div id="tableDataOutput">tableDataOutput</div> --->
				</div>

			</div>
		</form>
	</body>
</html>

<cfabort>

<!---


		// generate HTML code for an object
			function makeTable(json, css_class='tbl_calss', tabs=1) {
			    // helper to tabulate the HTML tags. will return '\t\t\t' for num_of_tabs=3
			    var tab = function(num_of_tabs) {
			        var s = '';
			        for (var i = 0; i < num_of_tabs; i++) {
			            s += '\t';
			        }
			        //console.log('tabbing done. tabs=' + tabs)
			        return s;
			    }
			    // recursive function that returns a fixed block of <td>......</td>.
			    var generate_td = function(json) {
			        if (!(typeof(json) == 'object')) {
			            // for primitive data - direct wrap in <td>...</td>
			            return tab(tabs) + '<td>'+json+'</td>\n';
			        } else {
			            // recursive call for objects to open a new sub-table inside the <td>...</td>
			            // (object[key] may be also an object)
			            var s = tab(++tabs)+'<td>\n';
			            s += tab(++tabs)+'<table class="'+css_class+'">\n';
			            for (var k in json){
			                s += tab(++tabs)+'<tr>\n';
			                s += tab(++tabs)+'<td>' + k + '</td>\n';
			                s += generate_td(json[k]);
			                s += tab(--tabs)+'</tr>' + tab(--tabs) + '\n';
			            }
			            // close the <td>...</td> external block
			            s +=	tab(tabs--)+'</table>\n';
			            s +=	tab(tabs--)+'</td>\n';
			            return s;
			        }
			    }
			    // construct the complete HTML code
			    var html_code = '' ;
			    html_code += tab(++tabs)+'<table class="'+css_class+'">\n';
			    html_code += tab(++tabs)+'<tr>\n';
			    html_code += generate_td(json);
			    html_code += tab(tabs--)+'</tr>\n';
			    html_code += tab(tabs--)+'</table>\n';
			    return html_code;
			}







 <!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>WebSocket Test</title>
		<script language="javascript" type="text/javascript">

			var wsUri = "wss://echo.websocket.org/";
			var statusOutput;

			function init() {
				statusOutput = document.getElementById("output");
				testWebSocket();
			}

			function testWebSocket() {
				websocket = new WebSocket(wsUri);
				websocket.onopen = function(evt) { onOpen(evt) };
				websocket.onclose = function(evt) { onClose(evt) };
				websocket.onmessage = function(evt) { onMessage(evt) };
				websocket.onerror = function(evt) { onError(evt) };
			}

			function onOpen(evt) {
				writeToScreen("CONNECTED");
				doSend("WebSocket rocks");
			}

			function onClose(evt) {
				writeToScreen("DISCONNECTED");
			}

			function onMessage(evt) {
				writeToScreen('<span style="color: blue;">RESPONSE: ' + evt.data+'</span>');
				websocket.close();
			}

			function onError(evt) {
				writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
			}

			function doSend(message) {
				writeToScreen("SENT: " + message);
				websocket.send(message);
			}

			function writeToScreen(message) 	{
				var pre = document.createElement("p");
				pre.style.wordWrap = "break-word";
				pre.innerHTML = message;
				statusOutput.appendChild(pre);
			}

			window.addEventListener("load", init, false);

		</script>
	</head>
	<body>
		<h2>WebSocket Test</h2>

		<div id="output"></div>
	</body>
</html>

 --->
<cfabort>
<!--- *********************************	*********************************	****************************** --->

<cfset cfcInstrumentation = CreateObject("component", "#APPLICATION.cfcs#Instrumentation")>
<cfset cfcParameter = CreateObject("component", "#APPLICATION.cfcs#Parameter")>
<cfset cfcFormula = CreateObject("component", "#APPLICATION.cfcs#Formula")>
<cfset cfcGeneral = CreateObject("Component", "#APPLICATION.cfcs#General")>
<cfset cfcGeotech = CreateObject("Component", "#APPLICATION.cfcs#Geotech")>
<cfset cfcSiteVisitDetail = CreateObject("Component", "#APPLICATION.cfcs#SiteVisitDetail")>

<cfoutput>

<!---  --->

	<cffunction name="getInstalledSites" access="remote" returnFormat="json" returntype="string"
		hint="TODO:CFC method description???">
		<cfargument name="visitDate" required="true" type="string">
		<cfargument name="subTypeID" required="true" type="numeric">

		<cfset var Sites = "">

		<cfif IsDate(ARGUMENTS.visitDate)>
			<cfquery datasource="#APPLICATION.fulcrumdatasource#" name="Sites">
				SELECT gsi.SiteID
				FROM GeotechSiteInstrumentation AS gsi
					INNER JOIN Site AS s ON gsi.SiteID = s.ID
				WHERE  (s.ProjectID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#SESSION.fulcrum.project#">)
					AND (gsi.InstrumentSubTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.subTypeID#">)
					AND (gsi.Installed <= CONVERT(DATETIME, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#DateFormat(ARGUMENTS.visitDate, "yyyy-mm-dd")# 00:00:00">, 102))
				ORDER BY gsi.SiteID
			</cfquery>

			<cfreturn ValueList(Sites.SiteID) />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

<!---  --->

<cfparam name="URL.visitID" default="556711">

<cfquery datasource="#APPLICATION.fulcrumdatasource#" name="Visits">
	SELECT ID, VisitDate
	FROM GeotechSitesVisit
	WHERE (ProjectID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#SESSION.fulcrum.project#">)
	ORDER BY VisitDate
</cfquery>

<cfset prevList = "">

<cfif Visits.RecordCount>
	<!--- Determine first, previous, next, and last visits --->
	<cfset firstVisit = val(Visits.ID[1])>
	<cfset lastVisit = Visits.ID[Visits.RecordCount]>
	<cfif URL.visitID>
		<cfset prevVisit = 0>
		<cfset prevDate = "">
	<cfelse>
		<cfset prevVisit = lastVisit>
		<cfset prevDate = Visits.VisitDate[Visits.RecordCount]>
	</cfif>
	<cfset nextVisit = 0>
	<cfset index = 0>
	<cfloop query="Visits">
		<cfif Visits.ID EQ URL.visitID>
			<cfset index = Visits.CurrentRow>
			<cfif Visits.CurrentRow GT 1>
				<cfset prevVisit = Visits.ID[Visits.CurrentRow-1]>
				<cfset prevDate = Visits.VisitDate[Visits.CurrentRow-1]>
			</cfif>
			<cfif Visits.CurrentRow NEQ Visits.RecordCount>
				<cfset nextVisit = Visits.ID[Visits.CurrentRow+1]>
			</cfif>
			<cfbreak>
		</cfif>
	</cfloop>

	<cfdump var="#firstVisit#"><br/>
	<cfdump var="#prevVisit#"><br/>
	<cfdump var="#URL.visitID#">...<br/>
	<cfdump var="#nextVisit#"><br/>
	<cfdump var="#lastVisit#"><br/>

	<cfloop index="i" from="1" to="5">
		<cfif index-i GT 0>
			<cfset prevList = ListAppend(prevList, Visits.ID[index-i])>
		</cfif>
	</cfloop>
<cfelse>
	<cfset firstVisit = 0>
	<cfset prevVisit = 0>
	<cfset nextVisit = 0>
	<cfset lastVisit = 0>
	<cfset prevDate = "">
</cfif>


<cfdump var="#prevList#">

<cfquery datasource="#APPLICATION.fulcrumdatasource#" name="Formulas">
	SELECT s.ID AS SiteID, f.ID, f.Name, f.Formula
	FROM Site AS s
		INNER JOIN GeotechSiteInstrumentation AS gsi ON s.ID = gsi.SiteID
		INNER JOIN Instrument AS i ON gsi.InstrumentID = i.ID
		INNER JOIN InstrumentModel AS im ON i.ModelID = im.ID
		INNER JOIN InstrumentModelFormula AS imf ON im.ID = imf.InstrumentModelID
		INNER JOIN Formula AS f ON imf.FormulaID = f.ID
	WHERE (s.ProjectID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#SESSION.fulcrum.project#">)
		AND (gsi.InstrumentSubTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="2">)
	ORDER BY s.ID, f.Name
</cfquery>

<cfquery dbtype="query" name="FormalaIDs">
	SELECT DISTINCT ID
	FROM Formulas
</cfquery>

<cfquery datasource="#APPLICATION.fulcrumdatasource#" name="Params">
	SELECT a.ID,dbo.fnGetTableContent('Analytes', 'Name', a.ID, <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#SESSION.fulcrum.user_preferredLanguage#">, a.Name) AS [Name], MAX(CAST(fa.IsCopied AS Int)) AS IsCopied
	FROM FormulaAnalyte AS fa
		INNER JOIN FormulaAnalyteUnit AS fau ON fa.ID = fau.FormulaAnalyteID
		INNER JOIN Analyte AS a ON fa.AnalyteID = a.ID
	WHERE (fa.FormulaID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ListAppend(ValueList(FormalaIDs.ID), 0)#" list="true">))
		AND (fa.TypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#APPLICATION.formula_tables.gt_sites_visit#">)
		AND (fau.IsDefault = 1)
	GROUP BY a.ID, Name
	ORDER BY MAX(fa.Sequence), Name
</cfquery>


<cfquery datasource="#APPLICATION.fulcrumdatasource#" name="VisitDate">
	SELECT VisitDate
	FROM GeotechSitesVisit
	WHERE ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.visitID#">
</cfquery>
<hr>

<cfset prevSiteIDs = cfcGeotech.getInstalledSites(prevVisit, 2)>
<cfset siteIDs = cfcGeotech.getInstalledSites(VisitDate.VisitDate, 2)>
<!---
<cfset arr1 = ListToArray(siteIDs)>
<cfset ArraySort(arr1, "numeric", "asc")>
<cfdump var="#ArrayToList(arr1)#">
--->
<cfdump var="#prevSiteIDs#"><br />
SiteID list len : [<cfdump var="#ListLen(siteIDs)#">]<br/>
<cfdump var="#siteIDs#">

<cfquery datasource="#APPLICATION.fulcrumdatasource#" result="InstSites">
	SELECT s.ID, s.Name
	FROM Site AS s
		INNER JOIN GeotechSiteInstrumentation AS gsi ON s.ID = gsi.SiteID
	WHERE (gsi.InstrumentSubTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="2">)
		AND (s.ProjectID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#SESSION.fulcrum.project#">)
</cfquery>

Run time : #InstSites.EXECUTIONTIME#<br/>
<!--- InstSites Records : [#InstSites.RecordCount#]<br /> --->


<cfquery datasource="#APPLICATION.fulcrumdatasource#" result="Sites">
	SELECT s.ID, s.Name, gsi.InstrumentID, gsi.Installed, ISNULL(gsvrc.ID, 0) AS ReadingID, LTRIM(STR(s.ID)) +'_'+ LTRIM(STR(ISNULL(gsvrc.ID, 0))) AS SudoID,
		(CASE WHEN frc.FormulaID IS NULL THEN (CASE WHEN frp.FormulaID IS NULL THEN gsi.FormulaID ELSE frp.FormulaID END) ELSE frc.FormulaID END) AS FormulaID,
		frc.[Value] AS Curr,

		(CASE WHEN frc.[Value] IS NULL
		THEN NULL
		ELSE (
			SELECT TOP (1) TriggerID
			FROM GeotechTriggerSite
			WHERE (SiteID = s.ID)
				AND ([Value] <= frc.[Value])
			ORDER BY [Value] DESC)
		END) AS CurrTrigger,

		gsvrc.TakenTime,
		fc.Unit AS CurrUnit,
		(CASE WHEN <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.visitID#"> = 0 AND (gsvrp.IssueID = 1 OR gsvrp.IssueID = 3 OR gsvrp.IssueID = 5) THEN gsvrp.IssueID ELSE gsvrc.IssueID END) AS CurIssue
		<cfloop query="Params">
			, MAX(CASE WHEN fac.AnalyteID = #Params.ID# THEN fic.Value ELSE NULL END) AS CAttr#Params.ID#
			, MAX(CASE WHEN fac.AnalyteID = #Params.ID# THEN fic.Unit ELSE NULL END) AS CUnit#Params.ID#
			, MAX(CASE WHEN fap.AnalyteID = #Params.ID# THEN fip.Unit ELSE NULL END) AS PUnit#Params.ID#
		</cfloop>

	FROM Site AS s
		INNER JOIN GeotechSiteInstrumentation AS gsi ON s.ID = gsi.SiteID
		LEFT OUTER JOIN GeotechSitesVisitSiteSequence AS ssp ON s.ID = ssp.SiteID
			AND ssp.VisitID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#prevVisit#">
		LEFT OUTER JOIN GeotechSitesVisitSiteSequence AS ssc ON s.ID = ssc.SiteID
			AND ssc.VisitID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.visitID#">
		LEFT OUTER JOIN GeotechSitesVisitReading gsvrp ON s.ID = gsvrp.SiteID
			AND gsvrp.VisitID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#prevVisit#">
		LEFT OUTER JOIN GeotechSitesVisitReading gsvrc ON s.ID = gsvrc.SiteID
			AND gsvrc.VisitID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.visitID#">
		LEFT OUTER JOIN FormulaInput AS fip ON fip.TableID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#APPLICATION.formula_tables.gt_sites_visit#">
			AND fip.ParentID = gsvrp.ID
		LEFT OUTER JOIN FormulaAnalyte AS fap ON fip.FormulaAnalyteID = fap.ID
		LEFT OUTER JOIN FormulaInput AS fic ON fic.TableID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#APPLICATION.formula_tables.gt_sites_visit#">
			AND fic.ParentID = gsvrc.ID
		LEFT OUTER JOIN FormulaAnalyte AS fac ON fic.FormulaAnalyteID = fac.ID
		LEFT OUTER JOIN FormulaResult AS frp ON frp.TableID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#APPLICATION.formula_tables.gt_sites_visit#">
			AND frp.ParentID = gsvrp.ID
		LEFT OUTER JOIN Formula AS fp ON frp.FormulaID = fp.ID
		LEFT OUTER JOIN FormulaResult AS frc ON frc.TableID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#APPLICATION.formula_tables.gt_sites_visit#">
			AND frc.ParentID = gsvrc.ID
		LEFT OUTER JOIN Formula AS fc ON frc.FormulaID = fc.ID
	WHERE (gsi.InstrumentSubTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="2">)
		AND (s.ProjectID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#SESSION.fulcrum.project#">)
	GROUP BY s.ID, s.Name, (CASE WHEN ISNULL(ssc.Sequence, ssp.Sequence) IS NULL THEN 0 ELSE 1 END), ISNULL(ssc.Sequence, ssp.Sequence),
		gsi.InstrumentID, gsi.Installed, frc.[Value], gsvrc.TakenTime, fc.Unit, gsvrp.IssueID, gsvrc.IssueID, gsvrc.ID,
		(CASE WHEN frc.FormulaID IS NULL THEN (CASE WHEN frp.FormulaID IS NULL THEN gsi.FormulaID ELSE frp.FormulaID END) ELSE frc.FormulaID END)
	ORDER BY (CASE WHEN ISNULL(ssc.Sequence, ssp.Sequence) IS NULL THEN 0 ELSE 1 END), ISNULL(ssc.Sequence, ssp.Sequence), s.Name, gsvrc.TakenTime
</cfquery>

Run time : #Sites.EXECUTIONTIME#<br/>
<!--- New Records : [#Sites.RecordCount#] <br/> --->

</cfoutput>
<hr>

<cfset arr1 = ListToArray(ValueList(Sites.ID))>
<cfset ArraySort(arr1, "numeric", "asc")>
<cfdump var="#ArrayToList(arr1)#"><br/>
<cfdump var="#Sites.RecordCount#"><br/>
<cfdump var="#ValueList(Sites.ID)#">

<cfabort>

<cfset datasource = createObject( "java", "com.microsoft.sqlserver.jdbc.SQLServerDataSource" )>
<cfset datasource.setUser( "cf_fulcrum_user" )>
<cfset datasource.setPassword( "SWa7rATuNe" )>
<cfset datasource.setServerName( "localhost" )>
<cfset datasource.setDatabaseName( "aqdata" )>
<cfset datasource.setPortNumber( 1433 )>
<cfset connection = datasource.getConnection()>
<cfset statement = connection.createStatement(1004,1007)><!--- so we can use rs.next(), last() etc.. --->

<!---
<cfset rs = statement.executeQuery( "SELECT table_name FROM information_schema.tables ORDER BY table_name" )>
 --->
<cfset qryString = "SELECT DateStamp AS Timestamp_,Value AS Value_,  1 AS YearGroup, 1 AS MonthGroup FROM TimeSeriesData_11862 WHERE Corrected = 1 AND DateStamp >= '2015-03-08 01:00:00' AND DateStamp <= '2015-03-08 05:00:00' AND value IS NOT NULL  ORDER BY Timestamp_">
<cfset rs = statement.executeQuery( qryString )>
<cfset query = createObject( "java", "coldfusion.sql.QueryTable" ).init( rs )>


<cfloop condition="rs.next()">
	x<br /><!--- this should work ??? --->
</cfloop>

<cfdump var="#rs.getMetaData().getColumnName(1)#">
<cfdump var="#rs.getMetaData().getColumnName(2)#">
<cfdump var="#rs.getMetaData().getColumnName(3)#">
<cfdump var="#rs.getMetaData().getColumnName(4)#">

<cfscript>

	rs.last();
	size = rs.getRow();
	rs.beforeFirst();
	WriteDump("cols = " & size);
	WriteOutput('<br>');

	cols = rs.getMetaData().getColumnCount();
	WriteOutput(cols);

	x = 0;
	while (rs.next()) {
		x = x + 1;
		//WriteOUtput("row : " & x & "  ");

		col0 = rs.getString("Timestamp_");
		col1 = rs.getDate("Timestamp_");
		col2 = rs.getTime("Timestamp_");
		WriteOutput(col0);
		WriteOutput(" ");
		WriteOutput(col1);
		WriteOutput(" ");
		WriteOutput(col2);
		WriteOutput('<br>');

	}

</cfscript>
<!---
<cfdump var="#rs#">
<cfdump var="#rs.getMetaData()#">
 --->
<cfset rs.close()>
<cfset connection.close()>
<!--- <cfdump var="#query#"> --->

<cfabort>








<br /> <br />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Plupload - Drag &amp; drop example</title>

<cfinclude template="includes/common_head.cfm">
	<script type="text/javascript">


		function changePlaceHolder() {

			$("#js-example-placeholder-single").attr("data-placeholder","bar").select2();
//			$("#js-example-placeholder-single").select2();
		}

		function ChangeType(v, f) {
			console.log(v);
			console.log(f);

		}

		$(document).ready(function(){
			optPlaceHolder = "Select Type OF File";

/*
			$("#js-example-placeholder-single").select2({
				placeholder: "Select a state",
				allowClear: true
			});
*/

			applySelect2("js-example-placeholder-single", "Select a state");

			applySelect2("type", optPlaceHolder);
		});
	</script>
<head>

<body>


<input type="button" onclick="changePlaceHolder();" value="Update Place Holder">

<select id="js-example-placeholder-single" tabindex="-1" aria-hidden="true">
          <option value=""></option>

  <optgroup label="Alaskan/Hawaiian Time Zone">
    <option value="AK">Alaska</option>
    <option value="HI">Hawaii</option>
  </optgroup>
  <optgroup label="Pacific Time Zone">
    <option value="CA">California</option>
    <option value="NV">Nevada</option>
    <option value="OR">Oregon</option>
    <option value="WA">Washington</option>
  </optgroup>
  <optgroup label="Mountain Time Zone">
    <option value="AZ">Arizona</option>
    <option value="CO">Colorado</option>
    <option value="ID">Idaho</option>
    <option value="MT">Montana</option>
    <option value="NE">Nebraska</option>
    <option value="NM">New Mexico</option>
    <option value="ND">North Dakota</option>
    <option value="UT">Utah</option>
    <option value="WY">Wyoming</option>
  </optgroup>
  <optgroup label="Central Time Zone">
    <option value="AL">Alabama</option>
    <option value="AR">Arkansas</option>
    <option value="IL">Illinois</option>
    <option value="IA">Iowa</option>
    <option value="KS">Kansas</option>
    <option value="KY">Kentucky</option>
    <option value="LA">Louisiana</option>
    <option value="MN">Minnesota</option>
    <option value="MS">Mississippi</option>
    <option value="MO">Missouri</option>
    <option value="OK">Oklahoma</option>
    <option value="SD">South Dakota</option>
    <option value="TX">Texas</option>
    <option value="TN">Tennessee</option>
    <option value="WI">Wisconsin</option>
  </optgroup>
  <optgroup label="Eastern Time Zone">
    <option value="CT">Connecticut</option>
    <option value="DE">Delaware</option>
    <option value="FL">Florida</option>
    <option value="GA">Georgia</option>
    <option value="IN">Indiana</option>
    <option value="ME">Maine</option>
    <option value="MD">Maryland</option>
    <option value="MA">Massachusetts</option>
    <option value="MI">Michigan</option>
    <option value="NH">New Hampshire</option>
    <option value="NJ">New Jersey</option>
    <option value="NY">New York</option>
    <option value="NC">North Carolina</option>
    <option value="OH">Ohio</option>
    <option value="PA">Pennsylvania</option>
    <option value="RI">Rhode Island</option>
    <option value="SC">South Carolina</option>
    <option value="VT">Vermont</option>
    <option value="VA">Virginia</option>
    <option value="WV">West Virginia</option>
  </optgroup>
</select>

<br /><br />
<select name="type" style="width: 480px;"  id="type"  onchange="javascript:ChangeType(this.value, this.form);" >
 	<option value="">..:: Select Type ::..</option>
    <option value="1">Environmental Analyses - Certificate of Analysis (*.pdf)</option>
    <option value="9">Environmental Analyses - Chain of Custody Form (*.pdf)</option>
    <option value="162">Environmental Analyses - Data Modeling (*.csv)</option>
    <option value="64">Environmental Analyses - EDD Lab Data (*.edd, *.txt, *.csv)</option>
    <option value="2">Environmental Analyses - Excel Lab Data (*.xls, *.xlsx)</option>
    <option value="3">Environmental Analyses - Import File (*.csv)</option>
    <option value="153">Environmental Analyses - Processed or Tabulated Field Data (*.xls, *.xlsx, *.pdf, *.doc, *.docx)</option>
    <option value="8">Environmental Analyses - Sample Receipt Confirmation (*.pdf)</option>
    <option value="90186">Environmental Analyses - Scanned Calibration Notes and Records (*.pdf)</option>
    <option value="26">Environmental Analyses - Scanned Field Sheet (*.pdf)</option>
    <option value="30">Movie</option>
    <option value="14">Photo</option>
    <option value="73">Sketch</option>
</select>
</body>
</html>

<cfabort>

<cfset cfcGeoTech = CreateObject("Component", "#APPLICATION.cfcs#Geotech")>
	<cfset Params = cfcGeotech.getImportParams(4)>
	<cfdump var="#Params#">
<cfabort>

<cftry>
	<cfset cfcFormula = CreateObject("component", "#APPLICATION.cfcs#Formula")>
	<cfset cfcFormula.recalcFormulaResult()>

	<cfcatch>
		<cfoutput>
			#cfcatch.message#
		</cfoutput>
	</cfcatch>
</cftry>

Start here
<cfabort>

<cfset cfcAnalyte = CreateObject("Component", "#APPLICATION.cfcs#Analyte")>

<cfoutput>

	<cfif SESSION.fulcrum.user_id EQ 189>
		<cftry>

			<cfquery datasource="#APPLICATION.fulcrumdatasource#" name="Fractions">
				SELECT ID, Name
				FROM Fraction
			</cfquery>

			<cffunction name="getFractionName" access="private" output="false" returntype="string">
				<cfargument name="FractionQry" type="query" required="true">
				<cfargument name="id" type="numeric" required="true">

				<cfquery dbtype="query" name="Fraction">
					SELECT Name
					FROM ARGUMENTS.FractionQry
					WHERE ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.id#">
				</cfquery>

				<cfreturn Fraction.Name />

			</cffunction>

			<cffunction name="storeLines" access="private" output="true" returntype="struct">
				<cfargument name="SourceQry" type="query" required="true">
				<cfargument name="arrFileLines" type="array" required="true">
				<cfargument name="rsCount" type="numeric" required="true">

					<cfset var dup = "">
					<cfset var time = "10:00">
					<cfset var result = StructNew()>

					<cfloop query="ARGUMENTS.SourceQry" group="KPLabID">
						<cfif ARGUMENTS.SourceQry.Dup>
							<cfset dup = " Dup">
							<cfset time = "00:00">
						</cfif>

						<cfset ArrayAppend(ARGUMENTS.arrFileLines, "RS,""#ARGUMENTS.SourceQry.KPLabID#"",""#ARGUMENTS.SourceQry.KPSiteName##dup#"","& "#APPLICATION.cfcShowContent.dateConversion(ARGUMENTS.SourceQry.SampleDate, "yyyymmdd")#,#time#," & """#ARGUMENTS.SourceQry.Matrix#""")>
						<cfset ARGUMENTS.rsCount++>

						<cfloop>
							<cfset ArrayAppend(ARGUMENTS.arrFileLines, "RR,""#ARGUMENTS.SourceQry.Fraction#"",""#ARGUMENTS.SourceQry.Analyte#"",""#ARGUMENTS.SourceQry.Unit#"",#ARGUMENTS.SourceQry.MDL#,""#ARGUMENTS.SourceQry.Result#""")>
						</cfloop>

				</cfloop>

				<cfset result.data = ARGUMENTS.arrFileLines>
				<cfset result.rsCount = ARGUMENTS.rsCount>

				<cfreturn result />

			</cffunction>

			<cfif IsDefined("FORM.submitted")>

				<cfset currentRow = 0>
				<cfset arrFileLines = ArrayNew(1)>
				<cfset sResult = "">
				<cfset rsCount = 0>
				<cfset FileRecords = QueryNew("WO,DateReceived,Customer,COC,Matrix,SampleDate,Labid,CustSampRef,Analyte,Result,Unit,MDL,Method,Fraction,Dup,KPSiteName,KPSiteNumber,KPLabID")>

				<cfloop index="row" list="#FORM.content#" delimiters="#chr(10)#">
					<cfif Len(row)>

						<cfset currentRow++>
						<cfset aData =  MyCSVSplit(row, ",")>
						<cfset QueryAddRow(FileRecords)>

						<cfset unit = cfcAnalyte.fixUnitSymbols(Trim(aData[11]))>
						<cfif NOT Len(unit)>
							<span style="color:red;">Missing Unit near line : #currentRow#</span><br />
						</cfif>

						<cfif NOT IsNumeric(Trim(aData[14])) >
							<span style="color:red;">Missing Fraction Number at row : #currentRow#</span><br />
						</cfif>
						<cfset fractionName = getFractionName(Fractions, Trim(aData[14]))>

						<cfloop from="1" to="#ArrayLen(aData)#" index="i">
							<cfset QuerySetCell(FileRecords, "WO", aData[1], currentRow)>
							<cfset QuerySetCell(FileRecords, "DateReceived", aData[2], currentRow)>
							<cfset QuerySetCell(FileRecords, "Customer", aData[3], currentRow)>
							<cfset QuerySetCell(FileRecords, "COC", aData[4], currentRow)>
							<cfset QuerySetCell(FileRecords, "Matrix", Trim(aData[5]), currentRow)>
							<cfset QuerySetCell(FileRecords, "SampleDate", Trim(aData[6]), currentRow)>
							<cfset QuerySetCell(FileRecords, "Labid", aData[7], currentRow)>
							<cfset QuerySetCell(FileRecords, "CustSampRef", aData[8], currentRow)>
							<cfset QuerySetCell(FileRecords, "Analyte", Trim(aData[9]), currentRow)>
							<cfset QuerySetCell(FileRecords, "Result", Trim(aData[10]), currentRow)>
							<cfset QuerySetCell(FileRecords, "Unit", unit, currentRow)>
							<cfset QuerySetCell(FileRecords, "MDL", Trim(aData[12]), currentRow)>
							<cfset QuerySetCell(FileRecords, "Method", aData[13], currentRow)>
							<cfset QuerySetCell(FileRecords, "Fraction", fractionName, currentRow)>
							<cfset QuerySetCell(FileRecords, "Dup", Trim(aData[15]), currentRow)>
							<cfset QuerySetCell(FileRecords, "KPSiteName", Trim(aData[16]), currentRow)>
							<cfset QuerySetCell(FileRecords, "KPSiteNumber", Val(Trim(aData[17])), currentRow)>
							<cfset QuerySetCell(FileRecords, "KPLabID", Trim(aData[18]), currentRow)>

						</cfloop>

					</cfif>
				</cfloop>

				<!--- Header --->
				<cfset ArrayAppend(arrFileLines, "HR,""#kplabid#"",""#custProject#"",""#samplePerson#"",#dateReceived#,#created#")>

				<!--- Regular samples --->
				<cfquery dbtype="query" name="ControlQry">
					SELECT WO,DateReceived,Customer,COC,Matrix,SampleDate,Labid,CustSampRef,Analyte,Result,Unit,MDL,Method,Fraction,Dup,KPSiteName,KPSiteNumber,KPLabID
					FROM FileRecords
					WHERE Dup = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="0">
					ORDER BY KPLabID
				</cfquery>

				<cfset sResult = storeLines(ControlQry, arrFileLines, rsCount)>
				<cfset arrfilelines = sResult.data>
				<cfset rsCount = sResult.rsCount>

				<!--- Duplicate samples --->
				<cfquery dbtype="query" name="DupQry">
					SELECT WO,DateReceived,Customer,COC,Matrix,SampleDate,Labid,CustSampRef,Analyte,Result,Unit,MDL,Method,Fraction,Dup,KPSiteName,KPSiteNumber,KPLabID
					FROM FileRecords
					WHERE Dup = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1">
					ORDER BY KPLabID
				</cfquery>

				<cfset sResult = storeLines(DupQry, arrFileLines, rsCount)>
				<cfset arrfilelines = sResult.data>
				<cfset rsCount = sResult.rsCount>

				<!--- Trailer --->
				<cfset ArrayAppend(arrFileLines, "TR")>

				<!--- Write File --->
				<cfif ArrayLen(arrFileLines) AND IsDefined("FORM.writeFile")>
					<cfset filepath = "#APPLICATION.webRoot#temp\#kplabid#.edd">
					File Written : #filepath# EA Samples : #sResult.rsCount#

					<cfset eddFile = FileOpen(filepath, "write")>

					<cfloop from="1" to="#ArrayLen(arrFileLines)#" index="i">
						<cfset FileWriteLine(eddFile, arrFileLines[i])>
					</cfloop>

					<cfset FileClose(eddFile)>

				</cfif>

			</cfif>
<!---

1010590,13/05/2010,Baffinland Iron Mines Corporation,733323,Water,20100510,796868,D-Lake-04 - Total,Mg-total,8.55,mg/L,0.1,ALS - ALKALIS - TOTAL,1,0,D-Lake-04,4,733323 - 4
1010590,13/05/2010,Baffinland Iron Mines Corporation,733323,Water,20100510,796868,D-Lake-04 - Total,Na-total,0.984,mg/L,0.05,ALS - ALKALIS - TOTAL,1,0,D-Lake-04,4,733323 - 4
1010590,13/05/2010,Baffinland Iron Mines Corporation,733323,Water,20100510,796868,D-Lake-04 - Total,K-total,0.971,mg/L,0.05,ALS - ALKALIS - TOTAL,1,0,D-Lake-04,4,733323 - 4
1010590,13/05/2010,Baffinland Iron Mines Corporation,733323,Water,20100510,796868,D-Lake-04 - Total,Hardness as CaCO3-total,67.2,mg/L,0.5,ALS - ALKALIS - TOTAL,3,0,D-Lake-04,4,733323 - 4
1010590,13/05/2010,Baffinland Iron Mines Corporation,733323,Water,20100510,796868,D-Lake-04 - Total,Ca-total,12.8,mg/L,0.05,ALS - ALKALIS - TOTAL,1,0,D-Lake-04,4,733323 - 4
1010590,13/05/2010,Baffinland Iron Mines Corporation,733323,Water,20100510,796868,D-Lake-04 - Total,Li-total,     <5.0,ug/L,5,ALS Low Level ICP-MS TOTAL Met,1,0,D-Lake-04,4,733323 - 4
 --->

			<cfform name="EDDwriter" action="test_jeff.cfm" method="POST" preservedata="Yes">
<!--- 			<cfform name="EDDwriter" action="dat_SYS_EDD_Writer.cfm" method="POST" preservedata="Yes">				 --->
				<cfinput type="hidden" name="project" value="#SESSION.fulcrum.project#">
				<table width="60%">
					<tr>
						<td>Base LabID : <cfinput type="Text" name="kplabid" value="" required="yes" message="Please enter base KP lab id."></td>
						<td>Project : <cfinput type="Text" name="custProject" value="Baffinland Iron Mines" required="yes" message="Please enter Project Name."></td>
						<td>Sampler : <cfinput type="Text" name="samplePerson" value="Historical" required="yes" message="Please enter who collected samples."></td>
						<td>Date Received [yyyy mm dd]: <cfinput type="Text" name="dateReceived" value="" required="yes" message="Please enter date received by lab."></td>
						<td>Created [yyyy mm dd]: <cfinput type="Text" name="created" value="2014 10 04" required="yes" message="Please enter created date ( Today )."></td>
					</tr>
					<tr>
						<td><input type="submit" name="import" value="Write File"></td>
						<td><label for="writeFile">Write File <input type="checkbox" name="writeFile" id="writeFile" <cfif IsDefined("FORM.writeFile")>checked</cfif>></label></td>
						<td><label for="outputFile">Output File <input type="checkbox" name="outputFile" id="outputFile" <cfif IsDefined("FORM.outputFile")>checked</cfif>></label></td>
						<td><cfinput type="Hidden" name="submitted" value="1"></td>
					</tr>
				</table>

				<table width="1230">
					<tr>
						<th>WO</th>
						<th>RECEIVED</th>
						<th>CUSTOMER</th>
						<th>COC</th>
						<th>MATRIX</th>
						<th>SAMPLE DATE</th>
						<th>LAB ID</th>
						<th>SAMP REF</th>
						<th>ANALYTE</th>
						<th>RESULT</th>
						<th>UNIT</th>
						<th>MDL</th>
						<th>METHOD</th>
						<th>Fraction</th>
						<th>Dup</th>
						<th>KP Site Name</th>
						<th>KP Site Number</th>
						<th>KP Lab ID</th>
					</tr>
				</table>

				<table>
					<tr>
						<td>
							<cftextarea name="content" required="Yes" message="Please enter valid content." rows="40" cols="240"></cftextarea>
						</td>
					</tr>
					<tr><td></td></tr>
					<cfif IsDefined("arrFileLines") AND IsDefined("FORM.outputFile")>
						<tr>
							<td>
								<cftextarea name="fileContent" required="No" rows="20" cols="100">
									<cfloop from="1" to="#ArrayLen(arrFileLines)#" index="i">
										#arrFileLines[i]##Chr(13)#
									</cfloop>
								</cftextarea>
							</td>
						</tr>
					</cfif>

				</table>
			</cfform>
			<cfcatch><cfoutput><b>#cfcatch.message# </b></cfoutput></cfcatch>
		</cftry>
	</cfif>
</cfoutput>
<cfabort>
