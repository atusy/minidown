## Test environments

- local: x86_64-pc-linux-gnu (R-release)
- Rhub
    - Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    - Ubuntu Linux 16.04 LTS, R-release, GCC
    - Fedora Linux, R-devel, clang, gfortran
- GitHub Actions
    - macOS-latest (devel and release)
    - windows-latest (release and 3.6)
    - ubuntu-16.04 (devel, release, oldrelease, 3.5, 3.4, 3.3)
- r-hub
    - Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    - Ubuntu Linux 16.04 LTS, R-release, GCC
    - Fedora Linux, R-devel, clang, gfortran
- win-builder
    - x86_64-w64-mingw32 (64-bit), R Release
    - x86_64-w64-mingw32 (64-bit), R Under development

## R CMD check results

0 errors | 0 warnings | 0 note

## revdepcheck results

We checked 4 reverse dependencies (0 from CRAN + 4 from BioConductor), comparing R CMD check results across CRAN and dev versions of this package.

* We saw 0 new problems
* We failed to check 0 packages
