setwd('C:/Users/poria/OneDrive/Desktop/paper_scVAG/Heliyon/Materials/Clustering analysis/Robustness/')

#load  packages
library(tidyr)
library(ggplot2)
library(viridis)


# Your ARI data
# Your ARI data
ARI_data <- read.table(text = "Method	'Klein' 'Romanov' 'Chung' 'PBMC' 'Björklund' 'Petropolus' 'Brain_Mouse' 'Neuron' 'Biase' 'Adult_Mouse_Heart_5k' 'Human_TBNK_Antibody' 'AVG_Result'
scVAG	0.862 0.618 0.363 0.676 0.821 0.565 0.815 0.464 1 0.675 0.766 0.693
SCEA	0.843 0.608 0.317 0.663 0.78 0.595 0.785 0.407 1 0.664 0.692 0.669
SC3	0.832 0.553 0.025 0.642 0.72 0.536 0.755 0.328 0.948 0.616 0.504 0.587
scGAC	0.836 0.567 0.303 0.613 0.782 0.437 0.744 0.383 1 0.651 0.634 0.632
scGNN	0.6 0.281 0.296 0.562 0.438 0.279 0.307 0.236 0.33 0.485 0.316 0.375
Seurat	0.835 0.425 0.206 0.623 0.585 0.324 0.41 0.247 1 0.609 0.735 0.545
DESC	0.803 0.403 0.214 0.686 0.414 0.315 0.535 0.237 0.594 0.622 0.538 0.487
scASGC	0.802 0.455 0.303 0.664 0.335 0.129 0.663 0.36 1 0.587 0.644 0.54", header = TRUE)

NMI_data <- read.table(text = "Method	'Klein' 'Romanov' 'Chung' 'PBMC' 'Björklund' 'Petropolus' 'Brain_Mouse' 'Neuron' 'Biase' 'Adult_Mouse_Heart_5k' 'Human_TBNK_Antibody' 'AVG_Result'
scVAG	0.894 0.566 0.493 0.779 0.794 0.655 0.81 0.49 1 0.82 0.759 0.733
SCEA	0.865 0.534 0.494 0.785 0.776 0.656 0.745 0.461 1 0.761 0.711 0.708
SC3	0.857 0.533 0.319 0.736 0.717 0.626 0.697 0.317 0.929 0.703 0.651 0.644
scGAC	0.855 0.555 0.447 0.761 0.741 0.584 0.706 0.425 1 0.781 0.734 0.69
scGNN	0.68 0.332 0.466 0.683 0.546 0.384 0.485 0.425 0.443 0.634 0.508 0.508
Seurat	0.855 0.643 0.471 0.745 0.61 0.525 0.579 0.323 1 0.737 0.77 0.66
DESC	0.785 0.588 0.493 0.756 0.499 0.554 0.587 0.345 0.641 0.734 0.661 0.604
scASGC	0.822 0.515 0.426 0.763 0.459 0.34 0.63 0.606 1 0.655 0.673 0.626", header = TRUE)


#For ARI_DOT
plot_data <- tidyr::gather(ARI_data, key = "Datasets", value = "ARI", -Method)
desired_order_datasets <- c ("Chung", "Neuron" ,"Petropolus", "Romanov", "PBMC", "Adult_Mouse_Heart_5k", "Human_TBNK_Antibody", "Björklund","Brain_Mouse", "Klein", "Biase" ,"AVG_Result")
plot_data$Datasets <- factor(plot_data$Datasets, levels = desired_order_datasets)
desired_order_method <- c( "scGNN", "DESC","Seurat", "SC3", "scASGC","scGAC", "SCEA","scVAG")
plot_data$Method <- factor(plot_data$Method, levels = desired_order_method)
plot1 <- ggplot(plot_data, aes(x = Datasets, y = Method, col = ARI, size = ARI)) +
  geom_point(shape = 15) +  # Use shape = 15 for squares
  scale_color_gradientn("ARI", breaks = seq(0, 1, 0.1), colors = viridis::viridis(100000)) +  # Adjust the color scale
  scale_size_continuous(range = c(0, 5),
                        labels = formatC(seq(0, 1, 0.25), 2, format = "f")) +
  guides(
    color = guide_colorbar(order = 1),
    size = guide_legend("% cells with expr. above\n global marker median")
  ) +
  coord_equal() +
  theme_linedraw() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", fill = NA),  # Add border to the panel
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
ggsave(filename = "ARI_Dot.svg", plot = plot1, device = "svg", dpi = 500)


#for NMI_DOT
plot_data <- tidyr::gather(NMI_data, key = "Datasets", value = "NMI", -Method)
desired_order_datasets <- c ("Chung", "Neuron","Petropolus", "Romanov", "PBMC", "Adult_Mouse_Heart_5k", "Human_TBNK_Antibody", "Björklund","Brain_Mouse", "Klein", "Biase" ,"AVG_Result")
plot_data$Datasets <- factor(plot_data$Datasets, levels = desired_order_datasets)
desired_order_method <- c( "scGNN", "DESC","Seurat", "SC3", "scASGC","scGAC", "SCEA", "scVAG")
plot_data$Method <- factor(plot_data$Method, levels = desired_order_method)
plot1 <- ggplot(plot_data, aes(x = Datasets, y = Method, col = NMI, size = NMI)) +
  geom_point(shape = 15) +
  scale_color_gradientn("NMI", breaks = seq(0, 1, 0.1), colors = viridis::viridis(100000)) +
  scale_size_continuous(range = c(0, 5),
                        breaks = seq(0, 1, 0.1),
                        labels = formatC(seq(0, 1, 0.1), digits = 2, format = "f")) +
  guides(
    color = guide_colorbar(order = 1),
    size = guide_legend("% cells with expr. above\n global marker median")
  ) +
  coord_equal() +
  theme_linedraw() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", fill = NA),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
ggsave(filename = "NMI_Dot.svg", plot = plot1, device = "svg", dpi = 500)

#for ARI_HIT
plot_data <- tidyr::gather(ARI_data, key = "Datasets", value = "ARI", -Method)
plot_data$Method <- factor(plot_data$Method, levels = c("SC3", "scGNN", "DESC", "scASGC", "Seurat", "scGAC", "SCEA","scVAG"))
desired_order <- c("Chung", "Neuron" ,"Petropolus", "Romanov", "PBMC", "Adult_Mouse_Heart_5k", "Human_TBNK_Antibody", "Björklund","Brain_Mouse", "Klein", "Biase" ,"AVG_Result")
plot_data$Datasets <- factor(plot_data$Datasets, levels = desired_order)
plot3 <- ggplot(plot_data, aes(x = Method, y = Datasets, fill = ARI)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(name = "ARI", breaks = seq(0, 1, 0.1),
                       low = "blue", mid = "white", high = "red",
                       midpoint = 0.5, guide = "colorbar") +
  geom_text(aes(label = sprintf("%.2f", ARI)), vjust = 1) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank(),
    legend.position = "right",
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5)
  )
ggsave(filename = "ARI_hit.svg", plot = plot3, device = "svg", dpi = 500)

#for NMI_HIT
library(tidyr)
plot_data <- tidyr::gather(NMI_data, key = "Datasets", value = "NMI", -Method)
plot_data$Method <- factor(plot_data$Method, levels = c("SC3", "scGNN", "DESC", "scASGC", "Seurat", "scGAC", "SCEA","scVAG"))
desired_order <- c("Chung", "Neuron" ,"Petropolus", "Romanov", "PBMC", "Adult_Mouse_Heart_5k", "Human_TBNK_Antibody", "Björklund","Brain_Mouse", "Klein", "Biase" ,"AVG_Result")
plot_data$Datasets <- factor(plot_data$Datasets, levels = desired_order)
plot3 <- ggplot(plot_data, aes(x = Method, y = Datasets, fill = NMI)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(name = "NMI", breaks = seq(0, 1, 0.1),
                       low = "blue", mid = "white", high = "red",
                       midpoint = 0.5, guide = "colorbar") +
  geom_text(aes(label = sprintf("%.2f", NMI)), vjust = 1) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank(),
    legend.position = "right",
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5)
  )
ggsave(filename = "NMI_hit.svg", plot = plot3, device = "svg", dpi = 500)
