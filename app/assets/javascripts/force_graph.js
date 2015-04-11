function generateForceGraph(graph) {

  var height = Math.max(window.innerHeight/2, 400),
      width = window.innerWidth;

  var svg = d3.select("#graph")
      .style("height", height + "px")
      .style("width", width + "px")
      .style("display", "block");

  svg.append("path")
      .attr("class", "mesh")
      .attr("d", d3.hexbin()
          .size([width, height])
          .radius(40)
          .mesh);

  var color = d3.scale.category20();

  var force = d3.layout.force()
      .linkDistance(10)
      .linkStrength(2)
      .size([width, height]);

  var nodes = graph.nodes.slice(),
      links = [],
      bilinks = [];

  graph.links.forEach(function(link) {
    var s = nodes[link.source],
        t = nodes[link.target],
        i = {}; // intermediate node
    nodes.push(i);
    links.push({source: s, target: i}, {source: i, target: t});
    bilinks.push([s, i, t]);
  });

  force
      .nodes(nodes)
      .links(links)
      .start();

  var link = svg.selectAll(".link")
      .data(bilinks)
    .enter().append("path")
      .attr("class", "link")
      .style("stroke", blueColor(0));

  var node = svg.selectAll(".node")
      .data(graph.nodes)
    .enter().append("circle")
      .attr("class", "node")
      .attr("r", 5)
      .style("fill", function(d) { return color(d.depth); })
      .style("stroke-width", function(d) { return "0px"; })
      .on("click", function(d) {select(d);})
      .call(force.drag);

  node.append("title")
      .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("d", function(d) {
      return "M" + d[0].x + "," + d[0].y
          + "S" + d[1].x + "," + d[1].y
          + " " + d[2].x + "," + d[2].y;
    });
    node.attr("transform", function(d) {
      return "translate(" + d.x + "," + d.y + ")";
    });
  });

  function select(target) {
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

    window.setTimeout(getData, 500);
  }
}
