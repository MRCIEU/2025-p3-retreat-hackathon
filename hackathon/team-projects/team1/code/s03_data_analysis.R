# Install required libraries
install.packages(c("dplyr", "data.table", "tidyr", "stats"),repos = "http://cran.us.r-project.org")

# Load required libraries
library(dplyr)
library(data.table)
library(tidyr)
library(stats)

###############################
####### Define Functions ######
###############################

####### Data Cleaning and Preprocessing ####### 

# Function to convert to dataframe, clean duplicate samples and transpose data
process_protein_data <- function(protein_levels) {

  # Convert to dataframe
  protein_levels_df <- as.data.frame(protein_levels)
  
  # Remove duplicate samples
  names_prot <- names(protein_levels_df %>% dplyr::select(-1,-2,-3,-84,-85,-86)) %>% sub("\\..*", "", .)
  duplicates <- sort(names_prot)[which(duplicated(sort(names_prot)))]
  protein_levels_nondup <- protein_levels_df[, !grepl(paste(duplicates, collapse = "|"), colnames(protein_levels_df))]
  
  # Remove samples with missing values
  protein_levels_complete <- na.omit(protein_levels_nondup)

  # Get protein identifiers 
  protein_refseq_ac_nos <- protein_levels_complete[, 1]
  
  # Remove non-numerical columns
  protein_values_only <- protein_levels_complete[, c(-1, -2, -3)]
  
  # Remove healthy samples
  protein_levels_cc <- protein_values_only[, c(-81, -82, -83)]
  
  # Get sample names 
  sample_names <- colnames(protein_levels_cc)
  
  # Transpose to cluster samples rather than proteins
  protein_levels_cc.t <- t(protein_levels_cc)
  
  # Convert to numeric
  protein_levels_cc_numeric <- as.data.frame(apply(protein_levels_cc.t, 2, as.numeric))
  colnames(protein_levels_cc_numeric) <- protein_refseq_ac_nos
  rownames(protein_levels_cc_numeric) <- sample_names
  
  return(protein_levels_cc_numeric)
}

######## Hierarchical Clustering ########

# Function to perform hierarchical clustering
perform_clustering <- function(protein_levels_cc_numeric, num_clusters = 4) {
  # Perform hierarchical clustering by euclidean distance
  set.seed(123)
  hc <- hclust(dist(protein_levels_cc_numeric, method = "euclidean"), method = "ward.D2")
  
  # Cut the dendrogram to create clusters
  cluster_labels <- cutree(hc, k = num_clusters)
  cluster_labels <- as.data.frame(cluster_labels)
  
  # Merge cluster labels with the protein levels data
  protein_levels_cc_numeric_merged <- merge(protein_levels_cc_numeric, cluster_labels, by="row.names")
  colnames(protein_levels_cc_numeric_merged)[1] <- "Sample"
  
  return(protein_levels_cc_numeric_merged)
}

####### Sample Enrichment Analysis ########
# Determine which samples are in each cluster
assign_cluster_samples <- function(protein_levels_cc_numeric_merged, num_clusters){
  hc_sample_clusters = list()
  
  for(i in 1:num_clusters){
   hc_sample_clusters[[i]] = protein_levels_cc_numeric_merged[which(protein_levels_cc_numeric_merged$cluster_labels==i),1]
  }
  
  return(hc_sample_clusters)
}

####### Protein Enrichment Analysis ########
# Function to identify proteins enriched in each cluster

identify_enriched_proteins <- function(protein_levels_cc_numeric, hc_sample_clusters, num_clusters, num_top_proteins) {
  protein_enrich = matrix(NA, ncol = ncol(protein_levels_cc_numeric), nrow = num_clusters)
  
  for(i in 1:num_clusters) {
    c_df = protein_levels_cc_numeric[which(rownames(protein_levels_cc_numeric) %in% hc_sample_clusters[[i]]), ]^2
    protein_enrich[i,] = colSums(c_df) / nrow(c_df)
  }
  
  colnames(protein_enrich) = colnames(protein_levels_cc_numeric)
  
  # Normalize protein enrichment
  protein_enrich_norm = sweep(protein_enrich, 2, apply(protein_enrich, 2, mean), "/")
  max_valind = apply(protein_enrich_norm, 2, which.max)
  max_val = apply(protein_enrich_norm, 2, max)
  
  proteincluster = cbind.data.frame("protein" = colnames(protein_enrich_norm), "cluster" = max_valind, "enrichmentRatio" = max_val)
  
  # Generate a summary of the clusters with enrichment ratios and top proteins
  proteincluster_top_df <- proteincluster %>%
    group_by(cluster) %>%
    slice_max(order_by = enrichmentRatio, n = num_top_proteins) %>%
    summarise(
      cluster_labels = cluster,
      protein_list = toString(protein)
    )
  
  proteincluster_top_df <- unique(proteincluster_top_df)
  proteincluster_top_df <- proteincluster_top_df[,-1]
  
  return(proteincluster_top_df)
}

######## Cluster Summary Generation ######

# Function to generate the summary statistics for each cluster
generate_cluster_summary <- function(protein_levels_cc_numeric_merged, proteincluster_top_df, clinical_dat) {
  
  # Merge proteomics and clinical data using a standardised sample ID
  sample_clusters <- protein_levels_cc_numeric_merged[, c(1, ncol(protein_levels_cc_numeric_merged))]
  sample_clusters$standardized_id <- sub("\\..*", "", sample_clusters$Sample)
  clinical_dat$standardized_id <- sub("^TCGA-", "", clinical_dat$`Complete TCGA ID`)
  clustered_clinical_dat <- merge(sample_clusters, clinical_dat, by = "standardized_id")
  
  cluster_summary <- clustered_clinical_dat %>%
    group_by(cluster_labels) %>%
    summarise(
      count = n(),
      ER_positive_count = sum(`ER Status` == "Positive"),
      ER_negative_count = sum(`ER Status` == "Negative"),
      ER_positive_prop = ER_positive_count / count,
      ER_negative_prop = ER_negative_count / count,
      HER2_positive_count = sum(`HER2 Final Status` == "Positive"),
      HER2_negative_count = sum(`HER2 Final Status` == "Negative"),
      HER2_positive_prop = HER2_positive_count / count,
      HER2_negative_prop = HER2_negative_count / count,
      PR_positive_count = sum(`PR Status` == "Positive"),
      PR_negative_count = sum(`PR Status` == "Negative"),
      PR_positive_prop = PR_positive_count / count,
      PR_negative_prop = PR_negative_count / count,
      metastasis_positive_count = sum(`Metastasis-Coded` == "Positive"),
      metastasis_negative_count = sum(`Metastasis-Coded` == "Negative"),
      metastasis_positive_prop = metastasis_positive_count / count,
      metastasis_negative_prop = metastasis_negative_count / count,
      stage_I_count = sum(`AJCC Stage` == "Stage I"),
      stage_IA_count = sum(`AJCC Stage` == "Stage IA"),
      stage_IB_count = sum(`AJCC Stage` == "Stage IB"),
      stage_II_count = sum(`AJCC Stage` == "Stage II"),
      stage_IIA_count = sum(`AJCC Stage` == "Stage IIA"),
      stage_IIB_count = sum(`AJCC Stage` == "Stage IIB"),
      stage_III_count = sum(`AJCC Stage` == "Stage III"),
      stage_IIIA_count = sum(`AJCC Stage` == "Stage IIIA"),
      stage_IIIB_count = sum(`AJCC Stage` == "Stage IIIB"),
      stage_IIIC_count = sum(`AJCC Stage` == "Stage IIIC"),
      stage_IV_count = sum(`AJCC Stage` == "Stage IV"),
      stage_I_prop = stage_I_count / count,
      stage_IA_prop = stage_IA_count / count,
      stage_IB_prop = stage_IB_count / count,
      stage_II_prop = stage_II_count / count,
      stage_IIA_prop = stage_IIA_count / count,
      stage_IIB_prop = stage_IIB_count / count,
      stage_III_prop = stage_III_count / count,
      stage_IIIA_prop = stage_IIIA_count / count,
      stage_IIIB_prop = stage_IIIB_count / count,
      stage_IIIC_prop = stage_IIIC_count / count,
      stage_IV_prop = stage_IV_count / count,
      mean_age = mean(`Age at Initial Pathologic Diagnosis`, na.rm = TRUE),
      median_age = median(`Age at Initial Pathologic Diagnosis`, na.rm = TRUE)
    )
  
  cluster_summary_final <- merge(cluster_summary, proteincluster_top_df, by = "cluster_labels")
  
  return(cluster_summary_final)
}

###############################
######## Main Workflow ########
###############################

# Read in proteomics and clinical datasets 
protein_levels <- data.table::fread('./data/raw/77_cancer_proteomes_CPTAC_itraq.csv', header = T)
clinical_dat <- data.table::fread('./data/raw/clinical_data_breast_cancer.csv', header = T)

# Load protein levels and perform data cleaning
protein_levels_cc_numeric <- process_protein_data(protein_levels)

# Perform hierarchical clustering and get cluster labels
protein_levels_cc_numeric_merged <- perform_clustering(protein_levels_cc_numeric, num_clusters = 4)

# Assign each sample to a cluster
hc_sample_clusters <- assign_cluster_samples(protein_levels_cc_numeric_merged, num_clusters = 4)

# Identify enriched proteins in each cluster
proteincluster_top10_df <- identify_enriched_proteins(protein_levels_cc_numeric, hc_sample_clusters, num_clusters = 4, num_top_proteins = 10)

# Generate a final summary for each cluster
cluster_summary_final <- generate_cluster_summary(protein_levels_cc_numeric_merged, proteincluster_top10_df, clinical_dat)

# Write cluster summary to Github output folder
write.table(cluster_summary_final, './output/cluster_summary.txt', col.names = T, row.names = F, append = F, sep = '\t')