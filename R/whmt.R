## Apply the weighted hypothesis multiple testing procedure (WHMT)
## One set of p-values are from the test for association for the main genetic effect: Pg
## Second set of p-values are from the test for GxE effects: Pge
#'Weighted multiple hypothesis testing procedure to combine two steps of testing gene-environment interaction
#'in a two-step procedure.
#'
#'Run \code{\link{WHT}} to adjust for multiple testing
#'while combining two steps of the GxE interaction testing procedure. The procedure is applicable for
#'a multivariate phenotype, as well as a univariate phenotype.
#' @param PVAL A data.frame with three columns.
#'  The first column (PVAL$SNP) provides the name of all SNPs or genetic variants tested.
#'  Second column (PVAL$G.P) contains the p-values of the variants obtained from testing
#'  an overall marginal genetic
#'  association between the multivariate phenotype and each genetic variant individually.
#' And the third column (PVAL$GE.P) contains the p-values obtained from testing overall GxE effect on the
#' multivariate phenotype in presence of possible marginal effect due to the genetic variant and
#' a marginal effect
#' due to the environmental variable. Number of rows in PVAL is the same as the number
#'  of genetic variants, and it has the same structure as in the output of \code{\link{mv_G_GE}}.
#'   No default.
#' @param first_bin_size A positive integer providing the number of SNPs in the top bin
#'  while ranking the SNPs or genetic variants according to their
#' relative importance in the first step, which is evaluated with respect to the strength of
#'  overall marginal genetic association with
#' the multivariate phenotype. Default is 5.
#' @param FWER A positive real number between 0 and 1 providing the overall
#'  family wise error rate to be maintained while
#' identifying the genetic variants having a genome-wide significant overall GxE effect
#'  on the multivariate phenotype.
#' Default is 0.05.
#' @return The output produced by the function is a list consisting of:
#'    \item{GEsnps}{Vector of SNPs/genetic variants identified to have a genome-wide significant overall GxE effect.}
#'    \item{adjusted.PV}{A data.frame providing the adjusted p-values with the corresponding
#'     genetic variants obtained by the weighted multiple hypothesis testing procedure.}
#' @references A Majumdar, KS Burch, S Sankararaman, B Pasaniuc, WJ Gauderman, JS Witte (2020)
#' A two-step approach to testing overall effect of gene-environment interaction for multiple phenotypes.
#' bioRxiv, doi: https://doi.org/10.1101/2020.07.06.190256
#'
#' @seealso \code{\link{SST}}, \code{\link{mv_G_GE}}
#'
#' @export
WHT <- function(PVAL, first_bin_size = 5, FWER = 0.05){

  chkPVAL(PVAL)
  FWER <- chk0_1cutoff(FWER, "FWER", 0.05)
  first_bin_size <- chkInteger(first_bin_size, "first_bin_size", 5)
  snp_set <- as.character(PVAL$SNP)
  pv1 = as.numeric(PVAL$G.P); pv2 = as.numeric(PVAL$GE.P); B = first_bin_size;

  m = length(pv1)                            ## number of SNPs
  adj_pv2 = numeric(m)
  rank_snps_step1 = rank(pv1)
  snps = paste0("SNP", 1:length(pv1))

  data_step1 = data.frame(snp=1:m, rank=rank_snps_step1, stringsAsFactors=FALSE)
  data1 = data_step1[order(data_step1$rank), ]

  n_parti = 0;
  bin_sizes = 0;
  n_SNPs_covered = 0;
  n_SNPs_remained = m;
  last_indicator = 0
  cum_bin_size = 0

  while(n_SNPs_remained > 0)
  {

    n_parti = n_parti + 1
    if(n_parti == 1){
      bin_sizes[n_parti] = B
      cum_bin_size[n_parti] = bin_sizes[n_parti]
    }
    if(n_parti > 1){
      bin_sizes[n_parti] = 2*bin_sizes[n_parti-1]
      cum_bin_size[n_parti] = cum_bin_size[n_parti-1] + bin_sizes[n_parti]
      if(last_indicator == 1){
        bin_sizes[n_parti] = m - cum_bin_size[n_parti-1]     ## include or exclude this adjustment
        cum_bin_size[n_parti] = m
      }
    }

    if(n_parti == 1){
      posi1 = 1;
      posi2 = bin_sizes[n_parti];
      snps = data1$snp[posi1:posi2]
      parti_w = 1/(2^n_parti)
      adj_factor = parti_w / bin_sizes[n_parti]
      adj_pv2[snps] = pv2[snps] / adj_factor
    }else{
      posi1 = cum_bin_size[n_parti-1] + 1;
      posi2 = cum_bin_size[n_parti];
      snps = data1$snp[posi1:posi2]
      parti_w = 1/(2^n_parti)
      adj_factor = parti_w / bin_sizes[n_parti]
      adj_pv2[snps] = pv2[snps] / adj_factor
    }

    if(last_indicator == 1) n_SNPs_covered = m else n_SNPs_covered = n_SNPs_covered + bin_sizes[n_parti]

    n_SNPs_remained = m - n_SNPs_covered
    if( n_SNPs_remained <= 2*bin_sizes[n_parti] ) last_indicator = 1

  }

  GEsnps <- "None"
  signif_posi <- which(adj_pv2 < FWER)
  if(length(signif_posi) > 0) GEsnps <- snp_set[signif_posi]

  result <- list(GEsnps = GEsnps, adjusted.PV = data.frame(SNP =snp_set, adj.P = adj_pv2, stringsAsFactors = FALSE))

  return(result)

}



