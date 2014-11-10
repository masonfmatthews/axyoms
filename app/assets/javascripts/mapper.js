function generateGraph(graphJSON) {
  var height = Math.max(window.innerHeight/2, 400)
      width = window.innerWidth,
      center = {x: width/2, y: height/2},
      meshBuffer = {x: width/2, y: height/2},
      radius = 80,
      zoomMargin = 20,
      zoomRatio = 1,
      focus = null;

  var color = d3.scale.linear()
      .domain([0, 10])
      .range(["hsl(221, 37%, 72%)", "hsl(221, 37%, 28%)"])
      .interpolate(d3.interpolateHcl);

  var pack = d3.layout.pack()
      .padding(2)
      .size([radius * 2, radius * 2])
      .value(function(d) { return 1; });
      //TODO: There must be a better way to make all the leaf nodes the same size.

  var svg = d3.select("#graph")
      .style("height", height + "px")
      .style("width", width + "px");

  svg.append("path")
      .attr("class", "mesh")
      .attr("transform", "translate(-" + meshBuffer.x + ",-" + meshBuffer.y + ")")
      .attr("d", d3.hexbin()
          .size([width+meshBuffer.x*2, height+meshBuffer.y*2])
          .radius(radius/2)
          .mesh);

  /*TODO: I hate having a JS loop here... but when doubly-nesting data joins, I couldn't get access to the outer
        join's xOffset, etc.  Needed something like "function(d, parent) {return d.x + parent.xOffset;}"
  */
  graphJSON.forEach( function (graphNode) {

    var innerNodes = pack.nodes(graphNode);

    svg.selectAll(".node")
        .data(innerNodes, function(d) {return d.id;})
      .enter().append("circle")
        .style("fill", function(d) {return color(d.depth);})
        .attr("class", "node")
        .attr("cx",  function(d) {return (d.x = d.x + graphNode.xOffset);}) //TODO: Overwriting d.x here hurts.
        .attr("cy",  function(d) {return (d.y = d.y + graphNode.yOffset);})
        .attr("r",   function(d) {return d.r;})
        .on("click", function(d) {zoom(d);});

    svg.selectAll(".node-label")
        .data(innerNodes, function(d) {return d.id})
      .enter().append("text")
        .attr("class", "node-label")
        .style("fill-opacity", function(d) { return !d.parent ? 1 : 0; })
        .attr("x",  function(d) {return d.x;})
        .attr("y",  function(d) {return d.y;})
        .text(function(d) { return d.name; });
  });

  function zoom(target) {

      var zoomTime = 1000,
          ratio;

      if (target === focus) {
        ratio = 1;
        focus = null;
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

      //TODO: Can I chain all 3 of these animations off of the same transition?
  }
}