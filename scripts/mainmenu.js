var opHigh = 100; // highest opacity level
var opLow  = 20;  // lowest opacity level (should be the same as initial opacity in the CSS)

var hosts = [{
              title:"Scorpion-OI",
              links:[{
                  href:"/index.html",
                  title:"CPU\xa0load\xa0by\xa0cores"},{
                  href:"/cgi-bin/rrd/graph.pl?trend=cpuload&host=scorpion-oi",
                  title:"CPU\xa0load"},{
                  href:"/cgi-bin/rrd/graph.pl?trend=cputemp&host=scorpion-oi",
                  title:"CPU\xa0temperature"},{
                  href:"/cgi-bin/rrd/graph.pl?trend=hddtemp&host=scorpion-oi",
                  title:"HDD\xa0temperature"},{
                  href:"/cgi-bin/rrd/graph.pl?trend=traffic&host=scorpion-oi",
                  title:"Trafic\xa0in/out"},{
                  href:"/cgi-bin/rrd/graph.pl?trend=network&host=scorpion-oi",
                  title:"Local\xa0network"
                }]
            },{
                title:"Scorpion-WS",
                links:[{
                  href:"/cgi-bin/rrd/graph.pl?trend=gputemp&host=scorpion-ws",
                  title:"GPU temperature"},{
                  href:"",
                  title:"GPU load"},{
                  href:"",
                  title:"GPU power"},{
                  href:"",
                  title:"Memory load"},{
                  href:"",
                  title:"GPU fan speed"
                }]
}];


function initHostsList(parent){
  var selectList = document.createElement("select");
  selectList.id = "hosts";
  selectList.onchange = function(){ changeHost(this.selectedIndex); };
  parent.appendChild(selectList);

  for (var i = 0; i < hosts.length; i++) {
    var option = document.createElement("option");
    option.text = hosts[i].title;
    selectList.appendChild(option);
  }
  selectList.selectedIndex = 0;
  selectList.dispatchEvent(new Event('change'));
}

function init_menu(){
  var helper, menuElement = document.getElementById('menu');
  initHostsList(menuElement);
}
 
// fade in / fade out function (event handler)
function fade(mi, opacity, step){
  mi.parentNode.style.opacity = opacity / 100;                // set opacity for FF
  mi.parentNode.style.filter  = "alpha(opacity="+opacity+")"; // set opacity for IE
  opacity += step;                                            // update opacity level
  // recursive call if opacity is between 'low' and 'high' values (15ms pause between calls)
  if (opLow <= opacity && opacity <= opHigh) setTimeout(function(){fade(mi,opacity,step)}, 15);
}

function changeHost(event){
  var links = hosts[event].links;
  var menuElement = document.getElementById('menu');
  var oldHostsLinks = document.getElementById('hostMenu');
  var rootSpan = document.createElement("span");
  rootSpan.id = "hostMenu";

  for (var i = 0; i < links.length; i++) {
    var div = document.createElement("div");
    var a = document.createElement("a");
    a.href = links[i].href;
    a.text = links[i].title;
    a.onmouseover = function() {fade(this, opLow,  10)}; // fade in  - positive step
    a.onmouseout  = function() {fade(this, opHigh,-10)}; // fade out - negative step
    div.appendChild(a);
    rootSpan.appendChild(div);
  }

  if(oldHostsLinks === null){
    menuElement.appendChild(rootSpan);
  }else{
    var parentMenuNode = oldHostsLinks.parentNode;
    parentMenuNode.replaceChild(rootSpan, oldHostsLinks);
  }
}

addLoadEvent(init_menu);