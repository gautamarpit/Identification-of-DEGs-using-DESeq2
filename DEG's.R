library("DESeq2")


count <- read.csv("Count_vit.csv")
meta <- read.csv("metadata.csv")

count
meta

dds <- DESeqDataSetFromMatrix(countData = count, colData = meta, design = ~Condition, tidy = TRUE)

dds <- DESeq(dds)

res <- results(dds)

res<- na.omit(res)
res1 <- subset(res)
#write.csv(res, "NS1.csv")
# Filter results based on logfold change
# Filter results based on p-value
significant_genes <- res[res$pvalue < 0.05, ]

# Subset upregulated and downregulated genes
upregulated_genes <- significant_genes[significant_genes$log2FoldChange > 1.5, ]
downregulated_genes <- significant_genes[significant_genes$log2FoldChange < -1.5, ]

# Count the number of upregulated and downregulated genes
num_upregulated <- nrow(upregulated_genes)
num_downregulated <- nrow(downregulated_genes)
cat("Number of upregulated genes:", num_upregulated, "\n")
cat("Number of downregulated genes:", num_downregulated, "\n")

# Write filtered results to CSV
write.csv(upregulated_genes, "NS_up.csv")
write.csv(downregulated_genes, "NS_down.csv")
# Generate volcano plot
volcano_plot <- ggplot(res1, aes(x = log2FoldChange, y = -log10(padj), color = ifelse(log2FoldChange > 0, "red", "blue"))) +
  geom_point() +
  scale_color_identity() +
  theme_minimal() +
  labs(x = "log2 Fold Change", y = "-log10(p-value)", title = "Volcano Plot") +
  geom_vline(xintercept = c(-1.5, 1.5), linetype = "dashed", color = "gray") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "gray") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0))
# Save the volcano plot
ggsave("Volcano_Plot.png", plot = volcano_plot, width = 8, height = 6)

# Print the plot
print(volcano_plot)