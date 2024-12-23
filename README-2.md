
# CellChat Analysis for Infected and Normal Cell Communication

This repository contains scripts to analyze inter-cellular communication between infected and normal cells using the **CellChat** R package. The analysis includes heatmaps, chord diagrams, bubble plots, and violin plots of gene expression.

## Requirements

Ensure the following are installed before running the script:
- R (version ≥ 4.0)
- CellChat (R package)
- reticulate (R package)
- Python 3.12 (configured with reticulate)

### R Environment Setup
Ensure the correct Python path is set for `reticulate` in the script. Replace with your Python path if needed.

```R
reticulate::use_python('/path/to/your/python3.12', required = TRUE)
```

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/cellchat-analysis.git
   cd cellchat-analysis
   ```

2. Open the `cellchat_analysis.R` script in RStudio or your preferred IDE.

3. Run the script step by step or execute all at once.

4. Modify the input RDS file path to match your dataset:
   ```R
   CellChat <- readRDS("~/path_to_your_data/CellChat.RDS")
   ```

## Visualizations

### Heatmap
A heatmap showcasing signaling pathway activity.

### Chord Diagram
A chord diagram illustrating communication between source and target cell groups.

### Bubble Plot
Bubble plots to display enriched ligand-receptor pairs.

### Violin Plot
Violin plots representing expression levels of specific genes.

## Outputs
- Heatmaps
- Chord diagrams
- Bubble plots
- Gene expression violin plots

## Contributing
Feel free to fork and submit pull requests to improve this repository.
