chkPVAL <- function(PVAL) {
    if(!is.data.frame(PVAL))
        stop("PVAL must be a data.frame with 3 columns", call. = FALSE)
    if(!all(c("SNP", "G.P", "GE.P") %in% colnames(PVAL)))
        stop("PVAL must have 3 columns, named 'SNP', 'G.P', 'GE.P'", call. = FALSE)
    ## Check SNP column
    if(is.logical(PVAL$SNP))
        stop("SNP column of PVAL data.frame should not be logical", call. = FALSE)
    if(any(duplicated(PVAL$SNP)))
        stop("There can not be more than one SNP with the same name.", call. = FALSE)
    for(cName in c("G.P", "GE.P")) {
        colVAL <- PVAL[, cName]
        if(!is.numeric(colVAL))
            stop(paste(cName, "column is not numeric."), call. = FALSE)
        if(any(colVAL < 0 | colVAL > 1))
            stop(paste("Entries of the column", cName, "should be more than 0 and less than 1."), call. = FALSE)
    }
}

chk0_1cutoff <- function(x, xName, defaultVal) {
    if(!is.numeric(x)) {
        warning(paste(xName, "must be numeric. Default value is used."), call. = FALSE)
        return(defaultVal)
    }
    if(x < 0 | x > 1) {
        warning(paste(xName, "must be more than 0 and less than 1. Default value is used."), call. = FALSE)
        return(defaultVal)
    }
    return(x)
}

chkInteger <- function(x, xName, defaultVal) {
    if(!is.numeric(x)) {
        warning(paste(xName, "must be numeric. Default value is used."), call. = FALSE)
        return(defaultVal)
    }
    if(x <= 0 || x != floor(x)) {
        warning(paste(xName, "must be a positive integer. Default value is used."), call. = FALSE)
        return(defaultVal)
    }
    return(x)
}
