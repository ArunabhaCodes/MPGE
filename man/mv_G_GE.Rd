% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mv_G_GE_P.R
\name{mv_G_GE}
\alias{mv_G_GE}
\title{Test for marginal overall genetic association with multivariate phenotype,
and test for overall GxE effect on the multivariate phenotype
in presence of marginal effect due to the genetic variant
and a marginal effect due to the environmental variable.}
\usage{
mv_G_GE(pheno, geno, env)
}
\arguments{
\item{pheno}{A numeric matrix or data.frame with the number of individuals (n) as the number of rows and the
number of phenotypes (k) as the number of columns. It contains the values of k phenotypes
(e.g. LDL and HDL) across the individuals. Each phenotype (e.g. LDL) must be individually
adjusted for relevant covariates (age, sex, principal components of
genetic ancestries, etc) beforehand. Therefore, each column of pheno matrix should be the adjusted
residuals
of the corresponding phenotype. Each final phenotype (column) should be continuous
and normally distributed. No default.}

\item{geno}{A numeric matrix/data.frame (for a batch of genetic variants), or a numeric vector (for a single genetic variant).
It contains the genotype values of the genetic variants/variant across the individuals.
For a batch of variants, columns correspond to variants, and rows correspond to n individuals.
For a SNP, three different ways of genotype coding are possible:
additive, dominant and recessive, where additive coding is more common. No default.}

\item{env}{A vector of length n (number of individuals). It contains the values of the
environmental variable (e.g., frequency of alcohol consumption). It
can also contain factors, e.g., "yes" or "no" smoking status.}
}
\value{
The output is a data.frame with three columns. First column is the name of
the SNPs or genetic variants. The main columns are as follows:
\item{G.P}{P value of testing multivariate marginal genetic association
between the genetic variant
and the vector of phenotypes.}
\item{GE.P}{P value of testing multivariate overall GxE effect
in presence of possible marginal effect due
to the genetic variant and marginal effect
due to the environmental variable.}
}
\description{
Run \code{\link{mv_G_GE}} to obtain two different sets of p-values, one from the
test for marginal overall genetic association with multiple phenotypes (using multivariate linear regression),
and the other
from the test of overall GxE effect on multivariate phenotype allowing for a possible
genetic effect
due to the genetic variant and an effect due to the environmental variable.
}
\references{
A Majumdar, KS Burch, S Sankararaman, B Pasaniuc, WJ Gauderman, JS Witte (2020)
A two-step approach to testing overall effect of gene-environment interaction for multiple phenotypes.
bioRxiv, doi: https://doi.org/10.1101/2020.07.06.190256
}
\seealso{
\code{\link{WHT}}, \code{\link{SST}}
}
