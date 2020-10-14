context("check function WHT")
test_that("Throws error if PVAL is not a data.frame of at least 3 columns", {
    expect_error(WHT(1:10), "PVAL must be a data.frame with 3 columns")
    expect_error(WHT(mv_G_GxE_pvalues[, 1:2]), "PVAL must have 3 columns, named 'SNP', 'G.P', 'GE.P'")
    expect_error(WHT(mv_G_GxE_pvalues[, 2:3]), "PVAL must have 3 columns, named 'SNP', 'G.P', 'GE.P'")
    expect_error(WHT(data.frame(G.P = mv_G_GxE_pvalues$G.P, mv_G_GxE_pvalues[, c(1, 2)])), "PVAL must have 3 columns, named 'SNP', 'G.P', 'GE.P'")
})

test_that("Throws error if SNP column in PVAL is logical or have duplicate entry", {
    AA <- mv_G_GxE_pvalues
    M <- sample(c(TRUE, FALSE), nrow(AA), replace = TRUE)
    expect_error(WHT(data.frame(SNP = M, AA[, 2:3])), "SNP column of PVAL data.frame should not be logical")
    expect_error(WHT(data.frame(SNP = rep("a", nrow(AA)), AA[, 2:3])), "There can not be more than one SNP with the same name.")
})

test_that("Throws error if either 'G.P' or 'GE.P' is not numeric or the values are not in between 0 and 1", {
    AA <- mv_G_GxE_pvalues
    M <- sample(c(TRUE, FALSE), nrow(AA), replace = TRUE)
    expect_error(WHT(data.frame(G.P = M, AA[, c(1, 3)])), "G.P column is not numeric.")
    expect_error(WHT(data.frame(GE.P = M, AA[, 1:2])), "GE.P column is not numeric.")
    M <- sample(letters, nrow(AA), replace = TRUE)
    expect_error(WHT(data.frame(G.P = M, AA[, c(1, 3)])), "G.P column is not numeric.")
    expect_error(WHT(data.frame(GE.P = M, AA[, 1:2])), "GE.P column is not numeric.")
    M <- sample(1:nrow(AA), nrow(AA), replace = FALSE)
    expect_error(WHT(data.frame(G.P = M, AA[, c(1, 3)])), "Entries of the column G.P should be more than 0 and less than 1.")
    expect_error(WHT(data.frame(GE.P = M, AA[, 1:2])), "Entries of the column GE.P should be more than 0 and less than 1.")
    M <- sample(-(1:nrow(AA)), nrow(AA), replace = FALSE)
    expect_error(WHT(data.frame(G.P = M, AA[, c(1, 3)])), "Entries of the column G.P should be more than 0 and less than 1.")
    expect_error(WHT(data.frame(GE.P = M, AA[, 1:2])), "Entries of the column GE.P should be more than 0 and less than 1.")
})

test_that("Throws warning if first_bin_size is not an integer", {
    expect_warning(WHT(mv_G_GxE_pvalues, first_bin_size = 0.05), "first_bin_size must be a positive integer. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, first_bin_size = "a"), "first_bin_size must be numeric. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, first_bin_size = 0), "first_bin_size must be a positive integer. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, first_bin_size = -10), "first_bin_size must be a positive integer. Default value is used.")
})

test_that("Throws warning if FWER is not a number betwenn 0 and 1", {
    expect_warning(WHT(mv_G_GxE_pvalues, FWER = -1), "FWER must be more than 0 and less than 1. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, FWER = 10), "FWER must be more than 0 and less than 1. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, FWER = 1.5), "FWER must be more than 0 and less than 1. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, FWER = "p"), "FWER must be numeric. Default value is used.")
    expect_warning(WHT(mv_G_GxE_pvalues, FWER = TRUE), "FWER must be numeric. Default value is used.")
})

