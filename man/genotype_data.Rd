% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{genotype_data}
\alias{genotype_data}
\title{An example of genotype data for two genetic variants (SNPs).
Here, genotype\_data is a data.frame with the columns as SNPs (e.g., rs1 and rs2 here).
The rows correspond to the 500 individuals in the same order as in the phenotype data.}
\format{
A data.frame with the columns as SNPs (e.g., rs1 and rs2 here)
and individuals in the rows with the same order as in the phenotype data:
}
\usage{
data(genotype_data)
}
\description{
An example of genotype data for two genetic variants (SNPs).
Here, genotype\_data is a data.frame with the columns as SNPs (e.g., rs1 and rs2 here).
The rows correspond to the 500 individuals in the same order as in the phenotype data.
}
\examples{
data(genotype_data)
geno <- genotype_data
}
\keyword{datasets}
