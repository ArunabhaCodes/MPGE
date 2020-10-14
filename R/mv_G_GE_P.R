## We test for multivariate marginal genetic association between each SNP and a multivariate phenotype
## We test for multivariate GxE effect in the second stage
## These tests are dependent on the "car" package which requires an R version >= R.3.5.0
## Explaination of the arguments - Y: matrix with the multivariate phenotype data, geno - genotype data (vector),
## env - environmental data (vector).
#'Test for marginal overall genetic association with multivariate phenotype,
#' and test for overall GxE effect on the multivariate phenotype
#'in presence of marginal effect due to the genetic variant
#'and a marginal effect due to the environmental variable.
#'
#'Run \code{\link{mv_G_GE}} to obtain two different sets of p-values, one from the
#' test for marginal overall genetic association with multiple phenotypes (using multivariate linear regression),
#'  and the other
#'from the test of overall GxE effect on multivariate phenotype allowing for a possible
#' genetic effect
#' due to the genetic variant and an effect due to the environmental variable.
#' @param pheno A numeric matrix or data.frame with the number of individuals (n) as the number of rows and the
#' number of phenotypes (k) as the number of columns. It contains the values of k phenotypes
#'  (e.g. LDL and HDL) across the individuals. Each phenotype (e.g. LDL) must be individually
#'   adjusted for relevant covariates (age, sex, principal components of
#'    genetic ancestries, etc) beforehand. Therefore, each column of pheno matrix should be the adjusted
#'     residuals
#'    of the corresponding phenotype. Each final phenotype (column) should be continuous
#'     and normally distributed. No default.
#' @param geno A numeric matrix/data.frame (for a batch of genetic variants), or a numeric vector (for a single genetic variant).
#' It contains the genotype values of the genetic variants/variant across the individuals.
#'  For a batch of variants, columns correspond to variants, and rows correspond to n individuals.
#'   For a SNP, three different ways of genotype coding are possible:
#'  additive, dominant and recessive, where additive coding is more common. No default.
#' @param env A vector of length n (number of individuals). It contains the values of the
#' environmental variable (e.g., frequency of alcohol consumption). It
#' can also contain factors, e.g., "yes" or "no" smoking status.
#' @return The output is a data.frame with three columns. First column is the name of
#' the SNPs or genetic variants. The main columns are as follows:
#'    \item{G.P}{P value of testing multivariate marginal genetic association
#'     between the genetic variant
#'     and the vector of phenotypes.}
#'    \item{GE.P}{P value of testing multivariate overall GxE effect
#'     in presence of possible marginal effect due
#'     to the genetic variant and marginal effect
#'    due to the environmental variable.}
#'
#' @references A Majumdar, KS Burch, S Sankararaman, B Pasaniuc, WJ Gauderman, JS Witte (2020)
#' A two-step approach to testing overall effect of gene-environment interaction for multiple phenotypes.
#' bioRxiv, doi: https://doi.org/10.1101/2020.07.06.190256
#'
#' @seealso \code{\link{WHT}}, \code{\link{SST}}
#'
#' @export
##library("car")                     ## This will need to be included as "require()"
mv_G_GE <- function(pheno, geno, env){
    ## Check input 'pheno'
    if(!is.matrix(pheno) && !is.data.frame(pheno))
        stop("pheno should either be a matrix or a data.frame.", call. = FALSE)
    if(ncol(pheno) == 1)
        stop("pheno should contain data for more than one phenotype.", call. = FALSE)
    if(!is.numeric(as.matrix(pheno)))
        stop("pheno should be a numeric matrix or data.frame.", call. = FALSE)
    ## Check input 'geno'
    if(!is.atomic(geno) && !is.matrix(geno) && !is.data.frame(geno))
        stop("geno should either be a vector or a matrix or a data.frame.", call. = FALSE)
    if(is.matrix(geno))
        geno <- as.data.frame(geno)
    if(!is.numeric(as.matrix(geno)))
        stop("geno should be a numeric matrix or data.frame.", call. = FALSE)
    if((is.data.frame(geno) && nrow(pheno) != nrow(geno)) || (is.vector(geno) && nrow(pheno) != length(geno)))
        stop("There are different number of individuals in pheno and geno.", call. = FALSE)
    ## Check input 'env'
    if(!is.atomic(env) && !is.matrix(env) && !is.data.frame(env))
        stop("env should be a vector or a matrix or a data.frame.", call. = FALSE)
    if((is.matrix(env) || is.data.frame(env)) && (nrow(env) > 1 && ncol(env) > 1))
        stop("There cannot be more than one enviorenmental variable.", call. = FALSE)
    if(is.data.frame(env) | is.matrix(env))
        env <- env[, 1]
    if(length(env) != nrow(pheno))
        stop("There are different number of individuals in pheno and env.", call. = FALSE)

    if(is.atomic(geno))
        genoList <- list("rs0" = geno)
    if(is.data.frame(geno))
        genoList <- as.list(geno)
    pvalSNP <- purrr::map(genoList, function(x) mv_G_GE_base(pheno, x, env))
    RESULTS <- data.frame(SNP = names(pvalSNP), stringsAsFactors = FALSE)
    pvalSNP <- as.data.frame(pvalSNP)
    for(var in c("G.P", "GE.P")) {
        tmp <- pvalSNP[, grep(var, colnames(pvalSNP)), drop = FALSE]
        colnames(tmp) <- gsub(paste0(".", var), "", colnames(tmp))
        RESULTS[ ,var] <- t(tmp[, RESULTS$SNP])
    }
    return(RESULTS)
}



