if (typeof getURL == 'undefined') {
  getURL = function(url, callback) {
    if (!url)
      throw 'No URL for getURL';

    try {
      if (typeof callback.operationComplete == 'function')
        callback = callback.operationComplete;
    } catch (e) {}
    if (typeof callback != 'function')
      throw 'No callback function for getURL';

    var http_request = null;
    if (typeof XMLHttpRequest != 'undefined') {
      http_request = new XMLHttpRequest();
    }
    else if (typeof ActiveXObject != 'undefined') {
      try {
        http_request = new ActiveXObject('Msxml2.XMLHTTP');
      } catch (e) {
        try {
          http_request = new ActiveXObject('Microsoft.XMLHTTP');
        } catch (e) {}
      }
    }
    if (!http_request)
      throw 'Both getURL and XMLHttpRequest are undefined';

    http_request.onreadystatechange = function() {
      if (http_request.readyState == 4) {
        callback( { success : true,
                    content : http_request.responseText,
                    contentType : http_request.getResponseHeader("Content-Type") } );
      }
    }
    http_request.open('GET', url, true);
    http_request.send(null);
  }
}

var SVGDocs = null;
var last_cpu_total = 0;
var last_cpu_sys = 0;
var last_cpu_idle = 0;
var cpus_data = new Array();
var cpus_data_sys = new Array();
var intTimer= null;
var max_num_points = 120;  // maximum number of plot data points
var step = 264 / max_num_points;  // plot X division size
var fetch_interval=1000;
var fetch_url='/cgi-bin/cpu.cgi';
var fields = null;

function add_grid(SVGDoc){
    var grid_step = 12;
    var grid_path = "";
    for(var i = grid_step*2; i < 300; i+= grid_step){
        grid_path += "M 2 " + i + " L 264 " + i +" ";
    }
    for(var i = grid_step; i < 265; i+= grid_step){
        grid_path += "M " + i + " " + grid_step*2 + " L " + i + " 300 ";
    }
    
    SVGDoc.getElementById('grid').setAttributeNS(null, 'd', grid_path);
}
function fill_svg_docs(num) {
    if(SVGDocs) return;
    SVGDocs = new Array();
    for(var i=0;i < num; ++i){
        var embed = document.getElementById('cpu' + (i+1));
        try {
            SVGDocs[i] = embed.getSVGDocument();
            add_grid(SVGDocs[i]);
        }
        catch(exception) {
            alert('The GetSVGDocument interface is not supported');
        }
    }        
}

function fill_data_fields(data){
    if(fields) return;
    fields = {};
    var fldx_txt = data[0].split(/\s+/);
    for (var i = 0; i < fldx_txt.length; ++i){
        fields[fldx_txt[i]] = i+1;
    }
}

function init_data_arrays(num){
    if(cpus_data.length != 0 & cpus_data_sys.length != 0) return;
    
    for(var i = 0; i < num; ++i){
        cpus_data[i] = new Array();
        cpus_data_sys[i] = new Array();
    }
}

function init() {

	fetch_data();
	intTimer = setInterval('fetch_data()', fetch_interval);
	//setInterval('onLocationChange()', 500);
}

function onLocationChange()
{
 	fetch_interval2=location.href.split('#');
	fetch_interval2=fetch_interval2[1]*1000+10;
	if (fetch_interval2!=fetch_interval)
	{
	  fetch_interval=fetch_interval2;
	  clearInterval(intTimer);
  	intTimer = setInterval('fetch_data()', fetch_interval);
	
	}
}

function fetch_data() {
	if (fetch_url) {
		getURL(fetch_url, plot_cpu_data);
	} else {
		handle_error();
	}
}

function draw_graph(data){
    var cpu_idx = parseInt(data[fields.CPU]);
    var cpu=parseInt(data[fields.usr]);
	var cpu_sys=parseInt(data[fields.sys]);
    if (!isNumber(cpu)) return handle_error();
    
    var SVGDoc = SVGDocs[cpu_idx];
    var cpu_data = cpus_data[cpu_idx];
    var cpu_data_sys = cpus_data_sys[cpu_idx];

	switch (cpu_data.length) {
	case 0:
		SVGDoc.getElementById('collect_initial').setAttributeNS(null, 'visibility', 'visible');
		cpu_data[0] = cpu;
		cpu_data_sys[0] = cpu_sys;
		fetch_data;
		return;
	case 1:
		SVGDoc.getElementById('collect_initial').setAttributeNS(null, 'visibility', 'hidden');
		break;
	case max_num_points:
		// shift plot to left if the maximum number of plot points has been reached
		var i = 0;
		while (i < max_num_points) {
			cpu_data[i] = cpu_data[i+1];
			cpu_data_sys[i] = cpu_data_sys[++i];
		}
		--cpu_data.length;
		--cpu_data_sys.length;
	}

	cpu_data[cpu_data.length] = cpu;
	cpu_data_sys[cpu_data_sys.length] = cpu_sys;

	var path_data = "M 2 " + (298 - cpu_data[0]);
	var path_data_sys = "M 2 " + (298 - cpu_data_sys[0]); 
	var avg_total=0;
	var avg_sys=0;

	for (var i = 1; i < cpu_data.length; ++i) {
		var x = step * i;
		var y_cpu = 298 - 2.7*cpu_data[i];
		path_data += " L" + x + " " + y_cpu;

		var y_cpu = 298 - 2.7*cpu_data_sys[i];
		path_data_sys += " L" + x + " " + y_cpu;
		avg_total=avg_total+cpu_data[i];
		avg_sys=avg_sys+cpu_data_sys[i];
	}
	avg_total=Math.round(avg_total/cpu_data.length);
	avg_sys=Math.round(avg_sys/cpu_data.length);

//	SVGDoc.getElementById('avg_total_txt').firstChild.data = formatSpeed(avg_in, unit);
//	SVGDoc.getElementById('avg_sys_txt').firstChild.data = formatSpeed(avg_out, unit);
	
	y_cpu = 298 - (avg_total * 2.7);
	var path_avg_total = " M 0 " + y_cpu + " L 264 " + y_cpu;
	y_cpu = 298 - (avg_sys * 2.7);
	var path_avg_sys = " M 0 " + y_cpu + " L 264 " + y_cpu;

	SVGDoc.getElementById('avg_total').setAttributeNS(null, 'd', path_avg_total);
	SVGDoc.getElementById('avg_sys').setAttributeNS(null, 'd', path_avg_sys);

	path_data_sys += " L "+ x + " 298 L 2 298 ";
	path_data += " L "+ x + " 298 L 2 298";

	SVGDoc.getElementById("error").setAttributeNS(null, 'visibility', 'hidden');
	SVGDoc.getElementById('graph_cpu').setAttributeNS(null, 'd', path_data);
	SVGDoc.getElementById('graph_cpu_sys').setAttributeNS(null, 'd', path_data_sys);
	SVGDoc.getElementById('graph_txt').firstChild.data = 'ñur usr: '+Math.round(cpu*10)/10 + '%  sys: '+Math.round(cpu_sys*10)/10 + '%';
	SVGDoc.getElementById('graph_txt_avg').firstChild.data = 'avg usr: '+Math.round(avg_total*10)/10 + '%  sys: '+Math.round(avg_sys*10)/10 + '%';
}

function plot_cpu_data(obj) {
	if (!obj.success || ''==obj.content) {
		return handle_error();  // getURL failed to get current CPU load data
	}

	try {
        var counter_data = obj.content.split(/\n/);
        var number_of_cores = (counter_data.length - 1 ) / 2 - 1;
        
        fill_svg_docs( number_of_cores );
        fill_data_fields( counter_data );
        init_data_arrays( number_of_cores );

        var data_idx = (counter_data.length - 1 ) / 2 + 1;
        
        for (var i = data_idx; i < counter_data.length - 1; ++i) {
            draw_graph(counter_data[i].split(/\s+/));
        }
        
	} catch (e) {
        console.log(e)
		return;
	}
}

function handle_error() {
  //SVGDoc.getElementById("error").setAttributeNS(null, 'visibility', 'visible');
  console.log("error!!!");
  fetch_data();
}

function isNumber(a) {
  return typeof a == 'number' && isFinite(a);
}
