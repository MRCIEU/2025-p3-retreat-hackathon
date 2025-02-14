# Breast Cancer Proteomes

This respository contains:
.
├── LICENSE
├── README.md
├── Snakefile
├── code
│   ├── 01_download_data.sh
│   ├── README.md
│   ├── clinical_description.Rmd
│   ├── report
│   └── s01_download_data.sh
├── data
│   ├── README.md
│   └── raw
│       ├── 77_cancer_proteomes_CPTAC_itraq.csv
│       ├── PAM50_proteins.csv
│       └── clinical_data_breast_cancer.csv
├── environment.yml
├── output
│   ├── README.md
│   └── clinical_description.html
├── protocol
│   └── protocol.md
└── snakemake.md

## Abstract

This project explores the application of proteomic data analysis techniques to breast cancer research while emphasizing reproducibility and version control practices. Using publicly available iTRAQ proteome profiling data from 77 breast cancer samples, we analyze protein expression patterns to identify potential clustering structures. Principal component analysis (PCA) and hierarchical clustering are employed to classify samples, and results are compared with PAM50 mRNA-based classifications. To facilitate reproducibility, we implement a Snakemake pipeline for automated analysis and utilize Git and GitHub for version control. This study serves as both an exploratory investigation into proteomic data clustering and a learning opportunity for best practices in open science and collaborative coding.

## Using this code

To run this code, ...

## Availability of data

The data used in this project are available from <https://www.kaggle.com/datasets/piotrgrabo/breastcancerproteomes/code>. 

## Funding statement

This work was supported by the Medical Research Council. 

## Further information

If you would like any further information, please contact venexia.walker@bristol.ac.uk. 

## Acknowledgements

Thank you to Tomg Gaunt, Amanda Chong, Yi Liu and everone else involved in organising this wonderful retreat.
