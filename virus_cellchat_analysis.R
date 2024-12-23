
# Load required libraries
library(reticulate)
library(future)
library(dplyr)
library(CellChat)
library(Seurat)
library(patchwork)
library(NMF)
library(ggalluvial)
library(MAST)

# Set options and Python environment
options(future.globals.maxSize = 100000 * 1024^2)  # Set max size for future to 100GB
reticulate::use_python('/home/kwy7605/.rminiconda/my_python/bin/python3.12', required = TRUE)

# Load Virus dataset
Virus <- readRDS("~/Virus/RDS/Virus_infection_Final.RDS")

# Define cellchat analysis function
chat <- function(x, y) {
  cellchat <- createCellChat(object = x, meta = y, group.by = "cell_type", assay = "RNA")
  CellChatDB <- CellChatDB.human
  CellChatDB.use <- subsetDB(CellChatDB)  # Use secreted signaling database
  cellchat@DB <- CellChatDB.use
  cellchat <- subsetData(cellchat)
  cellchat <- identifyOverExpressedGenes(cellchat)
  cellchat <- identifyOverExpressedInteractions(cellchat)
  cellchat <- projectData(cellchat, PPI.mouse)
  cellchat <- computeCommunProb(cellchat, raw.use = FALSE)
  cellchat <- filterCommunication(cellchat, min.cells = 2)
  cellchat <- computeCommunProbPathway(cellchat)
  cellchat <- aggregateNet(cellchat)
  cellchat <- netAnalysis_computeCentrality(cellchat, slot.name = "netP")
  cellchat <- computeNetSimilarity(cellchat, type = "functional")
  cellchat <- netEmbedding(cellchat, type = "functional")
  cellchat <- netClustering(cellchat, type = "functional", do.parallel = FALSE)
  cellchat <- computeNetSimilarity(cellchat, type = "structural")
  cellchat <- netEmbedding(cellchat, type = "structural")
  cellchat <- netClustering(cellchat, type = "structural", do.parallel = FALSE)
  return(cellchat)
}

# Process and analyze Virus dataset
Virus@meta.data$types <- paste0(Virus@meta.data$cell_type, "_", Virus@meta.data$Virus)
Virus <- SetIdent(Virus, value = "types")
meta <- Virus@meta.data
Virus <- chat(Virus, meta)
saveRDS(Virus, "~/Virus/RDS/CellChat.RDS")

# Subset datasets for analysis
CTRL <- subset(Virus, subset = Condition == "CTRL")
CTRL_meta <- CTRL@meta.data
SARS2 <- subset(Virus, subset = Condition == "SARS-CoV-2")
SARS2_meta <- SARS2@meta.data
SARS1 <- subset(Virus, subset = Condition == "SARS-CoV")
SARS1_meta <- SARS1@meta.data

# Analyze subsets
CTRL <- chat(CTRL, CTRL_meta)
SARS2 <- chat(SARS2, SARS2_meta)
SARS1 <- chat(SARS1, SARS1_meta)

# Save subset results
saveRDS(CTRL, "~/Virus/RDS/CellChat_CTRL.RDS")
saveRDS(SARS2, "~/Virus/RDS/CellChat_SARS2.RDS")
saveRDS(SARS1, "~/Virus/RDS/CellChat_SARS1.RDS")
