
<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
========

Interaction between a genetic variant (e.g., a SNP) and an environmental variable (e.g., physical activity) can have a shared effect on multiple phenotypes (e.g., LDL and HDL). MPGE is a two-step method to test for an overall interaction effect on multiple phenotypes. In first step, the method tests for an overall marginal genetic association between the genetic variant and the multivariate phenotype. In the second step, SNPs which show an evidence of marginal overall genetic effect in the first step are prioritized while testing for an overall GxE effect. That is, a more liberal threshold of significance level is considered in the second step while testing for an overall GxE effect for these promising SNPs compared to the other SNPs.

This R-package consists of the following main functions:

1.  mv\_G\_GE: for a batch of genetic variants, this function provides two different p-values for each genetic variant, one from the test of marginal overall genetic association with multiple phenotypes, and the other from the test of overall GxE effect on multivariate phenotype allowing for a possible marginal effect due to the genetic variant and a marginal effect due to the environmental variable.
2.  WHT: this function implements the weighted multiple hypothesis testing procedure to adjust for multiple testing while combining the two steps of testing gene-environment interaction in the two-step GxE testing procedure, given two sets of p-values obtained using the previous function mv\_G\_GE for genome-wide genetic variants.
3.  SST: this function implements the subset multiple hypothesis testing procedure to adjust for multiple testing while combining the two steps of testing gene-environment interaction based on the same two sets of p-values described above.

Installation
============

You can install eGST from CRAN.

``` r
install.packages("MPGE")
library("MPGE")
```

Run mv\_G\_GE
=============

We will demonstrate how to run the mv\_G\_GE function. First, load the example data.

``` r
library("MPGE")
# Load the phenotype data
phenofile <- system.file("extdata", "phenotype_data.rda", package = "MPGE")
head(phenotype_data)
```

Here phenotype\_data is a data.frame with three columns for three phenotypes and the number of rows to be the number of individuals in the sample (500 in this toy data). Data for each phenotype provided must be adjusted individually for relevant covariates (e.g., age, sex, genetic ancestry) beforehand, and should follow a normal distribution.

``` r
library("MPGE")
# Load the genotype data
genofile <- system.file("extdata", "genotype_data.rda", package = "MPGE")
head(genotype_data)
```

Here, genotype\_data is a data.frame with the columns as SNPs (e.g., rs1 and rs2 here). The rows correspond to the 500 individuals in the same order as in the phenotype data.

``` r
library("MPGE")
# Load the data for environmental variable
genofile <- system.file("extdata", "environment_data.rda", package = "MPGE")
head(environment_data)
# For example, non-smoker coded as 0 and smoker coded as 1.
```

Here, environment\_data is a data frame with single column for the environmental variable. The order of the 500 individuals in the row must be the same as provided in the phenotype and genotype data. Here, the environmental variable has two categories which were coded as 1 and 0 (e.g., smokers and non-smokers). Instead of numeric values, these can also be considered to be factors in the absence of a defined order in the categories. Now, given the required phenotype, genotype and environmental data, we run the mv\_G\_GE function next.

``` r
#Compute the p-value of testing marginal multivariate genetic association. And, compute the p-value of testing multivariate GxE effect in presence of possible marginal genetic effect and marginal environmental effect on the phenotypes.
result <- mv_G_GE(phenotype_data, genotype_data, environment_data)
result
```

The output ('result') of mv\_G\_GE is a data.frame. Each row of the output provides the pair of p-values for each genetic variant, first one (G.P) from the test of marginal overall genetic association, and the second one (GE.P) from the test of overall GxE effect in presence of possible marginal genetic effect and marginal environmental effect.

Run WHT and SST
===============

Next, we demonstrate how to run WHT and SST. First, load the example data.

``` r
library("MPGE")
# Load the p-values
pvalues <- system.file("extdata", "mv_G_GxE_pvalues.rda", package = "MPGE")
head(mv_G_GxE_pvalues)
```

Here, mv\_G\_GxE\_pvalues is a data.frame with three columns. First column lists the set of 1000 genetic variants. Second column provides the vector of p-values obtained from testing the marginal multivariate genetic association for these SNPs. And the third column provides the vector of p-values obtained from testing the overall GxE effect in presence of possible marginal genetic effect and marginal environmental effect. Thus, the input data has the same structure as the output produced by the first function mv\_G\_GE. Next, we run WHT for this example data.

``` r
#Run WHT to implement the weighted hypothesis testing to adjust for multiple comparison, and find the significant SNPs with an overall GxE effect.
result <- WHT(mv_G_GxE_pvalues)
str(result)
```

The output is a list, first element of which ('GEsnps') is a character vector providing the set of SNPs found to have a significant signal of overall GxE effect. Second element is a dataframe providing the adjusted GxE test p-values (with the corresponding genetic variants in the first column) obtained by the weighted hypothesis testing procedure adjusting for multiple comparison.

``` r
#Run SST to implement the subset testing to adjust for multiple comparison, and find the significant SNPs with an overall GxE effect.
result <- SST(mv_G_GxE_pvalues)
str(result)
```

Here, we run SST for the same example data analyzed by WHT function above. The output from SST is a character vector providing the set of SNPs having a significant signal of overall GxE effect identified by subset testing to adjust for the multiple comparison.

Getting more details
====================

For more details, please see the MPGE refernce manual. For any question, please send an email to <statgen.arunabha@gmail.com> or <tanushree.haldar@gmail.com>. Also, you can see our manuscript for more details related to the main method: A Majumdar, KS Burch, S Sankararaman, B Pasaniuc, WJ Gauderman, JS Witte (2020) A two-step approach to testing overall effect of gene-environment interaction for multiple phenotypes. bioRxiv.
