
# Load required libraries
library(CellChat)
library(patchwork)
library(reticulate)

# Set up Python environment
reticulate::use_python('/home/kwy7605/.rminiconda/my_python/bin/python3.12', required = TRUE)

# Load CellChat object
CellChat <- readRDS("~/Virus/RDS/CellChat.RDS")

# Heatmap visualization
plot_heatmap <- function(cellchat, signaling_pathways, color_scheme = "Reds") {
  par(mfrow = c(1, 1))
  netVisual_heatmap(cellchat, signaling = signaling_pathways, color.heatmap = color_scheme)
}

# Chord diagram visualization
plot_chord <- function(cellchat, sources, targets, signaling_pathways) {
  par(mfrow = c(1, 2), xpd = TRUE)
  netVisual_chord_gene(cellchat, 
                       sources.use = sources, 
                       targets.use = targets, 
                       legend.pos.x = 15, 
                       lab.cex = 1, 
                       thresh = 0.005, 
                       slot.name = "netP", 
                       signaling = signaling_pathways)
}

# Bubble plot visualization
plot_bubble <- function(cellchat, sources, targets, signaling_pathways) {
  pairLR.use <- extractEnrichedLR(cellchat, signaling = signaling_pathways)
  netVisual_bubble(cellchat, 
                   sources.use = sources, 
                   targets.use = targets, 
                   pairLR.use = pairLR.use, 
                   remove.isolate = TRUE, 
                   angle.x = 45, 
                   font.size = 8)
}

# Gene expression visualization
plot_violin <- function(cellchat, signaling_pathway) {
  plotGeneExpression(cellchat, 
                     signaling = signaling_pathway, 
                     enriched.only = TRUE, 
                     type = "violin") + NoLegend()
}

# Analysis
ptm <- Sys.time()
signaling_pathways <- c("CEACAM", "EPHA", "EGF", "LAMININ")
plot_heatmap(CellChat, signaling_pathways)
plot_chord(CellChat, 
           sources = c("Goblet_Infected", "Basal_Infected"), 
           targets = c("Basal_Normal", "Goblet_Normal"), 
           signaling_pathways = signaling_pathways)
plot_bubble(CellChat, 
            sources = c("Goblet_Infected", "Basal_Infected"), 
            targets = c("Basal_Normal", "Goblet_Normal"), 
            signaling_pathways = signaling_pathways)
plot_violin(CellChat, signaling_pathway = "EGF")

print(paste("Analysis completed in", Sys.time() - ptm))
