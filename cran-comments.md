## Test environments

- Local
    - Debian GNU/Linux 10 (buster), R 4.2
- GitHub Actions
    - {os: macOS-latest,   r: 'release'}
    - {os: windows-latest, r: 'release'}
    - {os: windows-latest, r: '3.6'}
    - {os: ubuntu-18.04,   r: 'devel', http-user-agent: 'release'}
    - {os: ubuntu-18.04,   r: 'release'}
    - {os: ubuntu-18.04,   r: 'oldrel-1'}
    - {os: ubuntu-18.04,   r: 'oldrel-2'}
    - {os: ubuntu-18.04,   r: 'oldrel-3'}
    - {os: ubuntu-18.04,   r: 'oldrel-4'}
- win-builder
    - x86_64-w64-mingw32 (64-bit), R Release
    - x86_64-w64-mingw32 (64-bit), R Under development

## R CMD check results

0 errors | 0 warnings | 0 note

## revdepcheck results

We checked 8 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages

