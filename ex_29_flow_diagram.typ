#import "@preview/fletcher:0.5.4" as fletcher: diagram, node, edge
#import fletcher.shapes: house, hexagon, parallelogram, rect, diamond
#set page(width: auto, height: auto, margin: 5mm, fill: white)
#set text(font: "New Computer Modern")

#let blob(pos, label, tint: white, ..args) = node(
	pos, align(center, label),
	width: 28mm,
	//fill: tint.lighten(60%),
  fill: gradient.radial(tint.lighten(60%), tint.lighten(80%), center: (30%, 20%), radius: 80%),
	stroke: 1pt + tint.darken(20%),
	corner-radius: 5pt,
	..args,
)


//node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),

#let wider = 50mm
#let widest = 60mm

#let dx = 0.5

#diagram(
	spacing: 15pt,
	cell-size: (8mm, 10mm),
	edge-stroke: 1pt,
	edge-corner-radius: 5pt,
	mark-scale: 70%,

  // Preprocessor
  //node(enclose: ((0.5,0), (0,1), (0,2), (1.5,2), (1,1)), stroke: red.lighten(80%), fill: red.lighten(95%), corner-radius: 5pt),
  blob((0.5,0), text(fill: black, size: 14pt)[*Preprocessor*], tint: red, corner-radius: 5pt, width: wider, extrude: (-3, 0), inset: 10pt, shape: hexagon),
	blob((0,1), [Experimental parameters], tint: red, shape: parallelogram, width: wider),
  edge("-|>"),
	blob((0,2), [Parameter bounds & constraints], tint: red, shape: parallelogram),
  edge("-|>"),
	blob((1,2), [Spectrum image], tint: red, shape: parallelogram),
  edge("-|>"),
  blob((1,1), [Resample, truncate], tint: red, shape: rect),

  // GPR sampler
  blob((3,0), text(fill: black, size: 14pt)[*GPR sampler*], tint: yellow, corner-radius: 5pt, width: wider, extrude: (-3, 0), inset: 10pt, shape: hexagon),
  edge((1, 1), (3-dx,1), "-|>", layer: 100),
  blob((3-dx,1), [$i_1 = 1$], tint: yellow, shape: rect),
  edge("-|>"),
  blob((3-dx,2), [$i_1 = N_"run"$], tint: yellow, shape: diamond, name: <Nrun>),
  edge(<Nrun.east>, <i21.west>, "-|>", label: text(olive)[Yes], stroke: olive, bend: 30deg),

  blob((5-dx,2), [$i_2 = 1$], tint: yellow, shape: rect, name: <i21>),
  edge("-|>"),
  blob((5-dx,3), [Log run parameters], tint: yellow, shape: parallelogram),
  edge("-|>"),
  blob((5-dx,4), [$i_2<= N_"iter"$], tint: yellow, shape: diamond, name: <Niter>),

  edge(<Niter.east>, (6-dx, 5), "-|>", label: text(olive)[Yes], stroke: olive, bend: 45deg),
  blob((6-dx,5), [$i_2<= N_"init"$], tint: yellow, shape: diamond, name: <Ninit>),

  blob((3-dx,3), [$i_1 ++$], tint: yellow, shape: rect, name:<i1pp>),
  edge(<Niter.west>, (3-dx, 3), "-|>", label: text(maroon)[No], stroke: maroon, bend: 30deg),
  edge((3-dx, 3), (3-dx,2), "-|>"),

  blob((7, 6), [Sample $bold(x)$ from uniform distribution], tint: yellow, shape: rect, name: <samplex>),
  edge(<Ninit.east>, <samplex>, "-|>", label: text(olive)[Yes], stroke: olive, bend: 30deg),

  blob((6,6), [Update GPR], tint: yellow, shape: rect, name: <updateGPR>),
  edge("-|>"),
  
  edge(<Ninit.west>, <updateGPR.west>, "-|>", label: text(maroon)[No], stroke: maroon, bend: -45deg),


  blob((6,7), [Query GPR for $bold(x)$], tint: yellow, shape: rect, name: <QGPR>),

  blob((6,8), [Distance($bold(x)$)], tint: yellow, shape: rect, name: <distance>),
  edge("-|>"),
  blob((6,9), [Log result to disk], tint: yellow, shape: parallelogram),

  blob((4.5,7), [$i_2 ++$], tint: yellow, shape: rect, name: <i2pp>),

  edge(<distance.west>, <i2pp>, "-|>", bend: 30deg),

  edge((4.5,7), (4.5, 4), "-|>"),


  edge(<samplex>, (7,7.5), (6,7.5), <distance>, "-|>"),
  edge(<QGPR>, <distance>, "-|>"),


  // Greedy optimizer
  edge(<Nrun.west>, <select.east>, "-|>", label: text(maroon)[No], stroke: maroon, bend: 30deg),

  blob((1.4,5), text(fill: black, size: 14pt)[*Greedy optimizer*], tint: green, corner-radius: 5pt, width: wider, extrude: (-3, 0), inset: 10pt, shape: hexagon),



  blob((0,3.5), [Select $N_"greedy"$ points with smallest distances], tint: green, shape: rect, width: wider, name: <select>),
  edge("-|>"),
  blob((0,4.5), [Additional constraints as needed], tint: green, shape: parallelogram, width: wider),
  edge("-|>"),
  blob((0,5.5), [$i_3 = 1$], tint: green, shape: rect),
  edge("-|>"),

  blob((0,6.6), [$i_3 <= N_"greedy"$], tint: green, shape: diamond, name: <greedy>),

  edge(<greedy.east>, <pow.west>, "-|>", label: text(olive)[Yes], stroke: olive, bend: 45deg),

  blob((1.5,6.5), [$overline(bold(x))[i_3]$=Powell(distance, $bold(x)[i_3]$)], tint: green, shape: rect, width: 55mm, name: <pow>),
  edge("-|>"),
  blob((1.5,7.5), [$i_3++$], tint: green, shape: rect, name: <i3pp>),
  edge((), (0, 7.5), <greedy.south>, "-|>"),


  // Data analyzer
    blob((3,7.5), text(fill: black, size: 14pt)[*Data analyzer*], tint: blue, corner-radius: 5pt, width: wider, extrude: (-3, 0), inset: 10pt, shape: hexagon),



  blob((0, 8.5), [Threshold-based connectivity clustering], tint: blue, shape: rect, width: wider, name: <connectivity>),
  edge("-|>"),
  blob((1.5, 8.5), [Automatic annotation of best element in each cluster], tint: blue, shape: rect, width: widest),
  edge("-|>"),
  blob((3, 8.5), [RESULTS], tint: blue, shape: parallelogram),
  edge(<greedy.west>, <connectivity>, "-|>", label: text(maroon)[No], stroke: maroon, bend: -45deg),

)