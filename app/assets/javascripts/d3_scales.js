var blueColor = d3.scale.linear()
    .domain([0, 10])
    .range(["hsl(208, 58%, 72%)", "hsl(208, 58%, 28%)"])
    .interpolate(d3.interpolateHcl);

var greyscale = d3.scale.linear()
    .domain([0, 10])
    .range(["hsl(0, 0%, 90%)", "hsl(0, 0%, 28%)"])
    .interpolate(d3.interpolateHcl);

// Thank you, colorbrewer.
var redToGreen = ["#d73027", "#fc8d59", "#fee08b", "#d9ef8b", "#91cf60", "#1a9850"]
