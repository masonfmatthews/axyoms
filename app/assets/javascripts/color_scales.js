var blueColor = d3.scale.linear()
    .domain([0, 10])
    .range(["hsl(208, 58%, 72%)", "hsl(208, 58%, 28%)"])
    .interpolate(d3.interpolateHcl);

var greyscale = d3.scale.linear()
    .domain([0, 10])
    .range(["hsl(0, 0%, 90%)", "hsl(0, 0%, 28%)"])
    .interpolate(d3.interpolateHcl);

var redToGreen = d3.scale.linear()
    .domain([1, 6])
    .range(["hsl(20, 100%, 75%)", "hsl(140, 100%, 75%)"])
    .interpolate(d3.interpolateHcl);

var darkRedToGreen = d3.scale.linear()
    .domain([1, 6])
    .range(["hsl(20, 70%, 50%)", "hsl(140, 70%, 50%)"])
    .interpolate(d3.interpolateHcl);

function colorBadges() {
  var badges = $(".score-badge-color");
  badges.css("background-color", function() {
    return redToGreen(parseFloat($(this).data("score")));
  });
  badges.css("color", function() {
    return darkRedToGreen(parseFloat($(this).data("score")));
  });
}

$(colorBadges);
