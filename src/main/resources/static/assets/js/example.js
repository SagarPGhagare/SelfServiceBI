$(document).ready(function () {
  /*$('#execute').click(function () {
    var showData = $('#show-data');

    $.getJSON('main.json', function (data) {
      console.log(data);
	 var txt = "";
	 var header="";
	 var chartLink="";
	 
	 var arr=[];
	  var sessionstore=[]; 
	  for(var key in data)
	   {
		   for(var key in data[key][0])
		   {
		  // console.log("Keys:"+key);
		   arr.push(key);
		    sessionstore.push(key); 
		   }
	   }
	 
	 localStorage.setItem("linkName", JSON.stringify(sessionstore)); 
	
	 console.log("array :"+arr);
	 header="<tr>";
	 for(j=0;j<arr.length;j++)
	 {
		  header += "<th>"+arr[j]+"</th>";
			 
		chartLink+= "<li>"+arr[j]+"</li>";
		 
	 }
		 
	  header+="</tr>";
	  
	  
	    for(var key1 in data)
		{
			for(i=0;i<data[key1].length;i++)
			{
				txt+="<tr>"
					for(var key in data[key1][i])
					{
						var value=data[key1][i][key]
						console.log("valye:"+value);
						 txt += "<td>"+value+"</td>";
					}
					txt+="</tr>";
			}
		}
	   
	 for(i=0;i<data.USER.length;i++)
	{
		  txt += "<tr><td>"+data.USER[i].Login_Name+"</td><td>"+data.USER[i].CIF+"</td><td>"+data.USER[i].Login_Pwd+"</td></tr>";
	} 
	
     if(txt != ""){
		 $("#product_table").append(header).removeClass("hidden");
         $("#product_table").append(txt).removeClass("hidden");
                    }
					
	if(chartLink !="")
	{
		$("#menu").append(chartLink);
	}
    });

   
  });
  */
	
	
	

$("#barHBtn").click(function(){ 
	Highcharts.chart('barContainer', {
    chart: {
        type: 'bar'
    },
    title: {
        text: 'Stacked bar chart'
    },
    xAxis: {
        categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Total fruit consumption'
        }
    },
    legend: {
        reversed: true
    },
    plotOptions: {
        series: {
            stacking: 'normal'
        }
    },
    series: [{
        name: 'John',
        data: [5, 3, 4, 7, 2]
    }, {
        name: 'Jane',
        data: [2, 2, 3, 2, 1]
    }, {
        name: 'Joe',
        data: [3, 4, 4, 2, 5]
    }]
});
});



$(".barVBtn").click(function(){
	 Highcharts.chart('barContainer', {
	        chart: {
	            type: 'column'
	        },
	        title: {
	            text: 'Monthly Average Rainfall'
	        },
	        subtitle: {
	            text: 'Source: WorldClimate.com'
	        },
	        xAxis: {
	            categories: [
	                'Jan',
	                'Feb',
	                'Mar',
	                'Apr',
	                'May',
	                'Jun',
	                'Jul',
	                'Aug',
	                'Sep',
	                'Oct',
	                'Nov',
	                'Dec'
	            ],
	            crosshair: true
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: 'Rainfall (mm)'
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: [{
	            name: 'Tokyo',
	            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]

	        }, {
	            name: 'New York',
	            data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]

	        }, {
	            name: 'London',
	            data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]

	        }, {
	            name: 'Berlin',
	            data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]

	        }]
	    });
});

$("#lineChart").click(function(){
	  Highcharts.chart('lineContainer', {
	        title: {
	            text: 'Monthly Average Temperature',
	            x: -20 //center
	        },
	        subtitle: {
	            text: 'Source: WorldClimate.com',
	            x: -20
	        },
	        xAxis: {
	            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
	                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	        },
	        yAxis: {
	            title: {
	                text: 'Temperature (°C)'
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: '°C'
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0
	        },
	        series: [{
	            name: 'Tokyo',
	            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
	        }, {
	            name: 'New York',
	            data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
	        }, {
	            name: 'Berlin',
	            data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
	        }, {
	            name: 'London',
	            data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
	        }]
	    });
});


$("#pieChart").click(function(){
    Highcharts.chart('pieContainer', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
				 events: {
                    click: function (event) {
                        alert("Sub pie open");
                    }
                },
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: 'Microsoft Internet Explorer',
                y: 56.33
            }, {
                name: 'Chrome',
                y: 24.03,
                sliced: true,
                selected: true
            }, {
                name: 'Firefox',
                y: 10.38
            }, {
                name: 'Safari',
                y: 4.77
            }, {
                name: 'Opera',
                y: 0.91
            }, {
                name: 'Proprietary or Undetectable',
                y: 0.2
            }]
        }]
    });
});

});