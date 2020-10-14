context("Check inputs of function mv_G_GE")

test_that("Throws error if pheno is not a numeric matrix or dataframe of more than one column", {
    expect_error(mv_G_GE(1:10, genotype_data, environment_data), "pheno should either be a matrix or a data.frame.")
    expect_error(mv_G_GE(phenotype_data[, 1], genotype_data, environment_data), "pheno should either be a matrix or a data.frame.")
    expect_error(mv_G_GE(phenotype_data[, 1, drop = FALSE], genotype_data, environment_data), "pheno should contain data for more than one phenotype.")
    expect_error(mv_G_GE(data.frame(A = rep("A", nrow(genotype_data)), B = 10), genotype_data, environment_data), "pheno should be a numeric matrix or data.frame.")
})

test_that("Throws error if geno is not a numeric matrix or dataframe or vector", {
    expect_error(mv_G_GE(phenotype_data, list(rep(1, nrow(phenotype_data))), environment_data), "geno should either be a vector or a matrix or a data.frame.")
    expect_error(mv_G_GE(phenotype_data, as.list(genotype_data), environment_data), "geno should either be a vector or a matrix or a data.frame.")
    expect_error(mv_G_GE(phenotype_data, as.character(genotype_data[,1]), environment_data), "geno should be a numeric matrix or data.frame.")
})

test_that("Throws error if number of individuals in geno and pheno are different", {
    expect_error(mv_G_GE(phenotype_data[1:10,], genotype_data, environment_data), "There are different number of individuals in pheno and geno.")
    expect_error(mv_G_GE(phenotype_data, genotype_data[1:10,], environment_data), "There are different number of individuals in pheno and geno.")
    expect_error(mv_G_GE(phenotype_data, genotype_data[1:10, 1], environment_data), "There are different number of individuals in pheno and geno.")
})

test_that("Throws error if env is not a matrix or dataframe or vector", {
    expect_error(mv_G_GE(phenotype_data, genotype_data, list(environment_data[,1])), "env should be a vector or a matrix or a data.frame.")
    expect_error(mv_G_GE(phenotype_data, genotype_data, as.list(environment_data)), "env should be a vector or a matrix or a data.frame.")
})

test_that("Throw error if more than one enviorenmental variable or number of individuals in env is different from geno or pheno.", {
    expect_error(mv_G_GE(phenotype_data, genotype_data, data.frame(environment_data[,1], environment_data[,1])), "There cannot be more than one enviorenmental variable.")
    expect_error(mv_G_GE(phenotype_data, genotype_data, matrix(rep(environment_data[,1], 2), ncol = 2)), "There cannot be more than one enviorenmental variable.")
    expect_error(mv_G_GE(phenotype_data, genotype_data, environment_data[1:10,]), "There are different number of individuals in pheno and env.")
    expect_error(mv_G_GE(phenotype_data, genotype_data, environment_data[1:10, , drop = FALSE]), "There are different number of individuals in pheno and env.")
})

test_that("Check output when geno is vector", {
    expect_equal(mv_G_GE(phenotype_data, genotype_data[,1], environment_data)$SNP, "rs0")
    expect_equal(round(mv_G_GE(phenotype_data, genotype_data[,1], environment_data)$G.P, digits = 9)[,1], 0.000151109)
    expect_equal(round(mv_G_GE(phenotype_data, genotype_data[,1], environment_data)$GE.P, digits = 9)[,1], 0.00082551)
})

test_that("Check output when geno is data.frame", {
    expect_equal(mv_G_GE(phenotype_data, genotype_data, environment_data)$SNP, c("rs1", "rs2"))
    expect_equal(mv_G_GE(phenotype_data, genotype_data, environment_data)$G.P[,1], c("rs1" = 0.000151109, "rs2" = 0.176325958))
    expect_equal(mv_G_GE(phenotype_data, genotype_data, environment_data)$GE.P[,1], c("rs1" = 0.00082551, "rs2" = 0.11378000))
})

