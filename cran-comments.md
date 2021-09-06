## Test environments

- Local
    - Debian GNU/Linux 10 (buster), R 4.2
- GitHub Actions
    - {os: macOS-latest,   r: 'release'}
    - {os: windows-latest, r: 'release'}
    - {os: windows-latest, r: '3.6'}
    - {os: ubuntu-18.04,   r: 'devel', http-user-agent: 'release'}
    - {os: ubuntu-18.04,   r: 'release'}
    - {os: ubuntu-18.04,   r: 'oldrel/1'}
    - {os: ubuntu-18.04,   r: 'oldrel/2'}
    - {os: ubuntu-18.04,   r: 'oldrel/3'}
    - {os: ubuntu-18.04,   r: 'oldrel/4'}
- rhub
    -  Debian Linux, R-devel, clang, ISO-8859-15 locale
    -  Debian Linux, R-devel, GCC
    -  Debian Linux, R-devel, GCC, no long double
    -  Debian Linux, R-patched, GCC
    -  Debian Linux, R-release, GCC
    -  Fedora Linux, R-devel, clang, gfortran
    -  Fedora Linux, R-devel, GCC
    -  CentOS 8, stock R from EPEL
    -  Debian Linux, R-devel, GCC ASAN/UBSAN
    -  macOS 10.13.6 High Sierra, R-release, brew
    -  macOS 10.13.6 High Sierra, R-release, CRAN's setup
    -  Oracle Solaris 10, x86, 32 bit, R-release
    -  Oracle Solaris 10, x86, 32 bit, R release, Oracle Developer Studio 12.6
    -  Ubuntu Linux 20.04.1 LTS, R-devel, GCC
    -  Ubuntu Linux 20.04.1 LTS, R-release, GCC
    -  Ubuntu Linux 20.04.1 LTS, R-devel with rchk
    -  Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    -  Windows Server 2008 R2 SP1, R-oldrel, 32/64 bit
    -  Windows Server 2008 R2 SP1, R-patched, 32/64 bit
    -  Windows Server 2008 R2 SP1, R-release, 32/64 bit
- win-builder
    - x86_64-w64-mingw32 (64-bit), R Release
    - x86_64-w64-mingw32 (64-bit), R Under development

## R CMD check results

0 errors | 0 warnings | 0 note

## revdepcheck results

We checked 8 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages

