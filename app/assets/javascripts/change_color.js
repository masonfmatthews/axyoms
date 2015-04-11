function changeColor() {

  var color = d3.scale.linear()
      .domain([0, 10])
      .range(["hsl(120, 60%, 80%)", "hsl(120, 60%, 28%)"])
      .interpolate(d3.interpolateHcl);

  var greyscale = d3.scale.linear()
      .domain([0, 10])
      .range(["hsl(0, 0%, 90%)", "hsl(0, 0%, 28%)"])
      .interpolate(d3.interpolateHcl);

  d3.selectAll(".node")
      .filter(function(d) {
        return d.unit_ids.length > 0;
      })
      .transition()
      .duration(500)
      .style("fill", function(d) {return color(d.depth);})
      .style("stroke", function(d) {return color(d.depth);});

  d3.selectAll(".node")
      .filter(function(d) {return d.unit_ids.length === 0;})
      .transition()
      .duration(500)
      .style("fill", function(d) {return greyscale(d.depth);})
      .style("stroke", function(d) {return "hsl(0, 0%, 72%)";});

  d3.selectAll(".link")
      .transition()
      .duration(500)
      .style("stroke", "hsl(0, 0%, 72%)");
}
