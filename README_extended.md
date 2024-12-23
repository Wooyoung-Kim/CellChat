
# Virus Infection Analysis with CellChat

This repository contains an extended analysis script using the **CellChat** R package to study intercellular communication in virus-infected and control samples.

## Prerequisites

Ensure the following are installed before running the script:
- R (version ≥ 4.0)
- Required R packages: reticulate, future, dplyr, CellChat, Seurat, patchwork, NMF, ggalluvial, MAST
- Python 3.12 (configured with reticulate)

## Dataset

The analysis uses the `Virus_infection_Final.RDS` dataset, which contains metadata and RNA-seq data for infected and control conditions.

## Script Overview

The script:
1. Loads required libraries.
2. Defines a reusable `chat` function for CellChat analysis.
3. Processes the main dataset and subsets it for specific conditions.
4. Saves the analyzed datasets as RDS files.

## Outputs

The following RDS files are generated:
- `CellChat.RDS`: Complete dataset analysis.
- `CellChat_CTRL.RDS`: Analysis of the control condition.
- `CellChat_SARS2.RDS`: Analysis of SARS-CoV-2 condition.
- `CellChat_SARS1.RDS`: Analysis of SARS-CoV condition.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/virus-cellchat-analysis.git
   cd virus-cellchat-analysis
   ```

2. Modify the input file paths in the script to match your environment:
   ```R
   Virus <- readRDS("~/path_to_your_data/Virus_infection_Final.RDS")
   ```

3. Run the script in RStudio or your preferred R IDE.

## Contributing

Feel free to fork and submit pull requests to enhance the analysis pipeline.
