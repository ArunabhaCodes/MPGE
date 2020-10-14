# Documentation of the example dataset to demonstrate how to run the main functions in MPGE.
#'An example of phenotype data.
#'
#'Here phenotype\_data is a data.frame with three columns for three phenotypes
#' and the number of rows to be the number of individuals in the sample (500 in this toy data).
#'  Data for each phenotype provided must be adjusted individually for relevant
#'   covariates (e.g., age, sex, genetic ancestry) beforehand,
#'    and should follow a normal distribution.
#'@usage data(phenotype_data)
#'
#'@format A numeric matrix or data.frame with three columns for three phenotypes
#'and 500 rows for the individuals in the sample.
#'
#'@examples
#'data(phenotype_data)
#'pheno <- phenotype_data
"phenotype_data"

#'An example of genotype data for two genetic variants (SNPs).
#'Here, genotype\_data is a data.frame with the columns as SNPs (e.g., rs1 and rs2 here).
#' The rows correspond to the 500 individuals in the same order as in the phenotype data.
#'
#'@usage data(genotype_data)
#'
#'@format A data.frame with the columns as SNPs (e.g., rs1 and rs2 here)
#' and individuals in the rows with the same order as in the phenotype data:
#'
#'@examples
#'data(genotype_data)
#'geno <- genotype_data
"genotype_data"

#'An example of data of the environmental variable (e.g., smoking status).
#'Here, environment_data is a data frame with single column for the environmental
#' variable. The order of the 500 individuals in the row must be the same as provided
#'  in the phenotype and genotype data. Here, the environmental variable has two
#'  categories which were coded as 1 and 0 (e.g., smokers and non-smokers).
#'   Instead of numeric values, these can also be considered to be factors in
#'    the absence of a defined order in the categories.
#'
#'@usage data(environment_data)
#'
#'@format A data.frame with single column for the environmental
#' variable. The order of the 500 individuals in the row must be the same as provided
#'  in the phenotype and genotype data:
#'
#'@examples
#'data(environment_data)
#'geno <- environment_data
"environment_data"

#'An example of step 1 (marginal genetic association) and step 2 (GxE interaction)
#' p-values across genetic variants (SNPs).
#'Here, mv_G_GxE_pvalues is a data.frame with three columns. First column
#' lists the set of 1000 genetic variants. Second column provides
#'  the vector of p-values obtained from testing the marginal multivariate
#'   genetic association for these SNPs. And the third column provides the
#'    vector of p-values obtained from testing the overall GxE effect
#'     in presence of possible marginal genetic effect and marginal environmental effect.
#'
#'@usage data(mv_G_GxE_pvalues)
#'
#'@format A data.frame with three columns. First column
#' lists the set of 1000 genetic variants. Second column provides
#'  the vector of p-values obtained from testing the marginal multivariate
#'   genetic association for these SNPs. And the third column provides the
#'    vector of p-values obtained from testing the overall GxE effect
#'     in presence of possible marginal genetic effect and marginal environmental effect:
#'
#'@examples
#'data(mv_G_GxE_pvalues)
#'geno <- mv_G_GxE_pvalues
"mv_G_GxE_pvalues"
