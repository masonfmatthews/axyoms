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
    .range(["hsl(0, 80%, 80%)", "hsl(110, 80%, 80%)"])
    .interpolate(d3.interpolateHcl);
