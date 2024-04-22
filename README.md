# Identification-of-DEGs-using-DESeq2
For my masters project I utilizes the DESeq2 package to perform differential gene expression analysis on RNA-seq data. It reads count data and metadata from
CSV files, creates a DESeqDataSet object, and then uses DESeq2 functions to identify significant genes based on log2 fold change and p-values. The code further
subsets the significant genes into upregulated and downregulated categories, counts the number of genes in each category, and writes the results to CSV files.
Finally, it generates a volcano plot to visually represent the significant genes based on their fold changes and p-values. The purpose of this code is to analyze
RNA-seq data and identify differentially expressed genes for further biological interpretation.
