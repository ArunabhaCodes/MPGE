##library("car")                     ## This will need to be included as "require()"
mv_G_GE_base <- function(pheno, geno, env){
  ## Check for missing entry in geno

  Y <- as.matrix(pheno)            ## phenotype matrix
  G <- as.numeric(geno)            ## genotype vector
  E <- env                         ## environmental factor data

  ## screen for missing data
  misY <- which(rowSums(is.na(Y)) > 0)
  misG <- which(is.na(G) == TRUE)
  misE <- which(is.na(E) == TRUE)
  mis_all <- union(union(misY, misG), misE)
  if(length(mis_all) > 0){
    Y <- Y[-mis_all, ]; G <- G[-mis_all]; E <- E[-mis_all];
  }

  G <- G - mean(G)                 ## mean centered genotype vector
  if( class(E) == "numeric" || class(E) == "integer" ) E <- E - mean(E)
  ## mean centered environmental factor if numeric
  ##GE = G*E                         ## GxE covariate

  my.model = lm(Y ~ G)             ## test for multivariate main genetic association
  res = summary(stats::manova(my.model))
  Gpval = res$stats[1,6]

  pval <- 100
  my.model = lm(Y ~ G + E + G*E)
  res = summary(car::Manova(my.model, type="II"))
  CC <- capture.output(res)
  start_posi = which(CC == "Multivariate Tests: G:E")
  vals <- read.table(text=CC[start_posi+2])
  if(vals$V7 == "<") pval = as.numeric(vals$V8) else pval = as.numeric(vals$V7) ## There are four different tests
  GEpval <- pval

  result <- list(G.P = Gpval, GE.P = GEpval)
  return(result)
}

