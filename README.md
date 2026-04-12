# Bridge_Sim_Engine
Interactive Bridge Simulation for an ideal truss bridge, with complete force analysis, cost estimation, and GUI

To Run the GUI, run 'gui_rename' in a matlab envirment.

(will change to better name when we refactor)
```mermaid
---
title: Flowchart
---
flowchart TD
manualIn@{ shape: manual-input, label: "User Inputed Bridge Dimensions"}
display@{ shape: stadium, label: "Display Bridge"}
GUI@{ shape: rect, label: "GUI"}
FDIMS@{ shape: lean-r, label: "Formated Dimensions"}
IV@{ shape: rect, label: "Input Vectorizer"}
M@{ shape: lean-r, label: "Matrices: C,Sx,Sy,..."}
FE@{ shape: rect, label: "Force Estimation"}
CE@{ shape: rect, label: "Cost Estimation"}
FORCE@{ shape: stadium, label: "Displayed Forces: likely heatmap"}

manualIn --> GUI
GUI --> display
GUI --> FDIMS
FDIMS --> IV
IV --> M
M --> FE
M --> CE
FE --> GUI
CE --> GUI
display --> FORCE
```

