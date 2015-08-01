var blueColor = d3.scale.linear()
    .domain([0, 10])
    .range(["hsl(208, 58%, 72%)", "hsl(208, 58%, 28%)"])
    .interpolate(d3.interpolateHcl);

var greyscale = d3.scale.linear()
    .domain([0, 10])
    .range(["hsl(0, 0%, 90%)", "hsl(0, 0%, 28%)"])
    .interpolate(d3.interpolateHcl);

// var paleColor = d3.scale.linear()
//     .domain([0, 3])
//     .range(["hsl(20, 100%, 75%)", "hsl(140, 100%, 75%)"])
//     .interpolate(d3.interpolateHcl);

// var darkColor = d3.scale.linear()
//     .domain([0, 3])
//     .range(["hsl(20, 70%, 50%)", "hsl(140, 70%, 50%)"])
//     .interpolate(d3.interpolateHcl);

function paleColor(value) {
  if (value > 2.5) {
    return "hsl(150, 50%, 70%)";
  } else if (value > 1.5) {
    return "hsl(150, 50%, 80%)";
  } else if (value > 0.5) {
    return "hsl(0, 50%, 90%)";
  } else {
    return "hsl(0, 50%, 80%)";
  }
}

function darkColor(value) {
  if (value > 2.5) {
    return "hsl(150, 50%, 50%)";
  } else if (value > 1.5) {
    return "hsl(150, 50%, 70%)";
  } else if (value > 0.5) {
    return "hsl(0, 50%, 80%)";
  } else {
    return "hsl(0, 50%, 70%)";
  }
}

function colorBadges() {
  var badges = $(".score-badge-color");
  badges.css("background-color", function() {
    return paleColor(parseFloat($(this).data("score")));
  });
  badges.css("color", function() {
    return darkColor(parseFloat($(this).data("score")));
  });
}

$(colorBadges);
