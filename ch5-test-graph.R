
library(DiagrammeR)

mermaid("
graph LR
  A>code]-->B>selective>
  B-->D(summary)
")

ch5_graph


grViz("digraph {
  
  graph [layout = dot, rankdir = LR]
  
  node [style = filled]
  
  ## Add node statements
  node [shape = oval, fillcolor = MintCream]
  I1[label = code]
  I2[label = y]
  I3[label = story]
  {rank = same; I1; I2; I3} 
  
  node [shape = diamond, fillcolor = purple3, fontcolor = GhostWhite]
  R1[label = 'selected()']
  R2[label = 'summary()']
  
  node [shape = square, fillcolor = gold, fontcolor = black]
  O1[label = diag]
  O2[label = body_part]
  O3[label = location]
  O4[label = age_sex]
  O5[label = narrative]
  {rank = same; O1; O2; O3; O4; O5}
  
  ## Add edge statements
  edge [color = black]
  I1 -> R1 -> {O1 O2 O3 O5}
  R1 -> R2 -> O4
  I2 -> O4
  I3 -> O5
  
  
  }",
)

ch5_graph
