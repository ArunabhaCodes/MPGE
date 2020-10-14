## Resubmission
This is a resubmission. In this version we have:
* Rectified "EQTLs" as "eQTLs" in the title.
* Added reference in the Description field of the DESCRIPTION file in the form authors (year) <doi:...>
* Explained all the acronyms in the description text (eGST, GWAS etc.)
* Commented out "install.packages" call in the vignette.
* Replaced print() calls with message() calls.

## Test environments
* local OS High Sierra, R 3.6.0
* x86_64-pc-linux-gnu (on travis-ci), R 4.0.2
* win-builder (development (2020-10-11) and release (4.0.2))

## R CMD check results
We found 0 error and 0 warning while checking on all platforms. We also found 0 note while checking on Linux.

There is 1 note on local mac and in the result of build_win(). Note is regarding:
* This is a new package.
* Maintainer:  Arunabha Majumdar <statgen.arunabha@gmail.com>. We confirm that Arunabha Majumdar is maintainer of the package  and the email id is correct.
* The possible misspelling in the 'DESCRIPTION' file. Words listed here are: 'GxE', 'HDL', 'LDL', 'MPGE', 'Phenotypes', 'phenotypes'. We confirm that these words are correctly spelled.








