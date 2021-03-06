function generatePackedGraph(graphJSON) {

  var graphData = graphJSON.nodes,
      linkData = graphJSON.links,
      height = Math.max(window.innerHeight/2, 400),
      width = window.innerWidth,
      center = {x: width/2, y: height/2},
      meshBuffer = {x: width/2, y: height/2},
      graphBuffer = 2,
      radius = Math.min(width/graphJSON.x_count, height/graphJSON.y_count)/2 - graphBuffer,
      zoomMargin = height/5,
      zoomRatio = 1,
      focus = null;

  var pack = d3.layout.pack()
      .padding(2)
      .size([radius * 2, radius * 2])
      .value(one);

  var svg = d3.select("#graph")
      .style("height", height + "px")
      .style("width", width + "px")
      .style("display", "block");

  svg.append("path")
      .attr("class", "mesh")
      .attr("transform", "translate(-" + meshBuffer.x + ",-" + meshBuffer.y + ")")
      .attr("d", d3.hexbin()
          .size([width+meshBuffer.x*2, height+meshBuffer.y*2])
          .radius(radius/2)
          .mesh);

  link = d3.svg.diagonal()
      .source(function(d) { return {x: d.source.y, y: d.source.x}; })
      .target(function(d) { return {x: d.target.y, y: d.target.x}; })
      .projection(function(d) { return [d.y*width, d.x*height]; });

  svg.selectAll(".link")
      .data(linkData, function(d) {return d.source.uuid + d.target.uuid;})
    .enter().append("path")
      .attr("class", "link")
      .attr("d", link)
      .style("stroke", blueColor(0));

  enter = svg.selectAll(".node")
      .data(graphData)
    .enter().append("g").selectAll("circle")
      .data(function(d) {return pack.nodes(d);}, data_field("uuid"))
    .enter()

  // Creating circles has a side-effect: d.x and d.y are changed for each circle
  //   to take into account offsets given by the outer nodes.  I regret this,
  //   but I need it since the labels and the zoom effect rely on modified
  //   values, and since d3.pack() does not seem to take offset parameters.
  enter.append("circle")
      .style("fill", function(d) {return blueColor(d.depth);})
      .attr("class", "node")
      .attr("cx",  function(d, i, j) {return (d.x = d.x + graphData[j].x_center*width - radius);})
      .attr("cy",  function(d, i, j) {return (d.y = d.y + graphData[j].y_center*height - radius);})
      .attr("r", data_field("r"))
      .on("click", zoom);

  enter.append("text")
      .attr("class", "node-label")
      .attr("dy", ".5em")
      .style("fill-opacity", function(d) { return !d.parent ? 1 : 0; })
      .attr("x", data_field("x"))
      .attr("y", data_field("y"))
      .text(data_field("name"));

  function zoom(target) {
    $("#concept-summary").fadeOut();

    getData = function () {
      $.ajax({
        url: "/concepts/summary/" + target.uuid,

        type: "GET",

        success: function( html ) {
            $('#concept-summary').html(html);
            $("#concept-summary").fadeIn();
        },

        error: function( xhr, status, errorThrown ) {
            alert( "Sorry, there was a problem!" );
            console.log( "Error: " + errorThrown );
            console.log( "Status: " + status );
            console.dir( xhr );
        }
      });
    }

    var zoomTime = 1000,
        ratio;

    if (target === focus) {
      ratio = 1;
      focus = null;
      target = center;
    } else {
      ratio = (height/2 - zoomMargin)/target.r;
      focus = target;
    }

    var meshRatio = Math.sqrt(ratio);

    var transition = d3.selectAll(".node").transition()
        .duration(zoomTime)
        .attr("cx", function(d) { return (d.x - target.x) * ratio + center.x; })
        .attr("cy", function(d) { return (d.y - target.y) * ratio + center.y; })
        .attr("r",  function(d) { return ratio * d.r;});

    var linkX = center.x - target.x*ratio,
        linkY = center.y - target.y*ratio;

    var transition = d3.selectAll(".link").transition()
        .duration(zoomTime)
        .attr("transform", "translate(" + linkX + "," + linkY + "), scale(" + ratio  + ")")
        .style("stroke-width", 1/ratio + "px");

    d3.selectAll(".node-label").transition()
        .duration(zoomTime)
        .style("fill-opacity", function(d) { return (d.parent == focus || (d === focus && !d.children)) ? 1 : 0; }) // == allows two nulls to be equal
        .attr("x", function(d) { return (d.x - target.x) * ratio + center.x; })
        .attr("y", function(d) { return (d.y - target.y) * ratio + center.y; });

    var meshX = center.x - (meshBuffer.x + target.x)*meshRatio,
        meshY = center.y - (meshBuffer.y + target.y)*meshRatio;

    d3.select(".mesh").transition()
        .duration(zoomTime)
        .attr("transform", "translate(" + meshX + "," + meshY + "), scale(" + meshRatio  + ")");

    window.setTimeout(getData, zoomTime);
  }
}
