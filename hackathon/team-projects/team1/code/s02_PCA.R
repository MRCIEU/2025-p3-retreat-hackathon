# load packages
library(tidyverse)

# read data file
prot <- read_csv("data/raw/77_cancer_proteomes_CPTAC_itraq.csv")

# identify duplicate samples
sample_ids <- names(prot %>% dplyr::select(-1,-2,-3,-84,-85,-86))
base_ids <- sub("\\..*","", sample_ids)
duplicated_bases <- base_ids[duplicated(base_ids) | duplicated(base_ids, fromLast = TRUE)]
original_duplicates <- sample_ids[base_ids %in% duplicated_bases]
original_duplicates

# remove duplicate samples
prot_nd <- prot %>%
  dplyr::select(-any_of(original_duplicates))

# select only protein ID and sample columns
prot_matrix <- prot_nd %>%
  dplyr::select(-gene_symbol, -gene_name)
# make the protein ID become the rownames
pca_matrix <- prot_matrix %>% 
  column_to_rownames("RefSeq_accession_number") %>%
# coerce to a matrix    
  as.matrix() %>%
# transpose the matrix  
  t()
# perform the PCA
sample_pca <- prcomp(pca_matrix)

# Convert matrix to tibble
as_tibble(pca_matrix, rownames = "sample")


  