var opHigh = 100; // highest opacity level
var opLow  = 20;  // lowest opacity level (should be the same as initial opacity in the CSS)
 
// register onLoad event with anonymous function
function init_menu(){
    
    var helper, menuElement = document.getElementById('menu')
    helper = document.createElement('helper')
    helper.innerHTML = '        <div><a href="/index.html">CPU&nbsp;load&nbsp;by&nbsp;cores</a></div> '+
                       '        <div><a href="#">CPU&nbsp;load&nbsp;total</a></div> '+
                       '        <div><a href="/cgi-bin/graph.pl?trend=hddtemp">HDD&nbsp;temperature</a></div> '+
                       '        <div><a href="/cgi-bin/graph.pl?trend=traffic">Trafic&nbsp;in/out</a></div> '

    menuElement.appendChild(helper)
    
    while (helper.firstChild) {
         //Also removes child nodes from 'foo'
        menuElement.insertBefore(helper.firstChild, helper)
    }
    // Remove 'foo' element from target element
    menuElement .removeChild(helper)    

    //  collect menu items and attach onMouseOver and onMouseOut events
    var mi = document.getElementById('menu').getElementsByTagName('a');
    for (var i=0; i<mi.length; i++){
        mi[i].onmouseover = function(e) {fade(this, opLow,  10)} // fade in  - positive step
        mi[i].onmouseout  = function(e) {fade(this, opHigh,-10)} // fade out - negative step
    }
}
 
// fade in / fade out function (event handler)
function fade(mi, opacity, step){
    mi.parentNode.style.opacity = opacity / 100;                // set opacity for FF
    mi.parentNode.style.filter  = "alpha(opacity="+opacity+")"; // set opacity for IE
    opacity += step;                                            // update opacity level
    // recursive call if opacity is between 'low' and 'high' values (15ms pause between calls)
    if (opLow <= opacity && opacity <= opHigh) setTimeout(function(){fade(mi,opacity,step)}, 15);
}

addLoadEvent(init_menu);