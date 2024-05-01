suppressPackageStartupMessages({
  library("splatter")
  library("scater")
  library("VariantAnnotation")
  library("ggplot2")
})
set.seed(42)
vcf <- mockVCF(n.sample = 20)
gff <- mockGFF(n.genes = 2000)


#Define cell clusters and the distribution of the clustering 
# below example is 16 clusters with unbalanced distribution
sim <- splatPopSimulate(vcf = vcf, gff = gff,  sparsify = FALSE, group.prob = c(0.0625, 0.0825, 0.0625, 0.0725, 
                                                                                0.0925, 0.0425, 0.0825, 0.1025, 
                                                                                0.0225, 0.1225, 0.0125, 0.0225,
                                                                                0.0725, 0.0025, 0.0625, 0.0825), method = "groups") 
sim
sim <- logNormCounts(sim)
count_matrix <- assay(sim, "logcounts")
write.csv(data.frame(count_matrix), "data8.csv")
label = sim$Group
write.csv(data.frame(label), "label8.csv")
