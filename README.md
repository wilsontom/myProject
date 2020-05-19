# myProject

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![R build status](https://github.com/wilsontom/myProject/workflows/R-CMD-check/badge.svg)](https://github.com/wilsontom/myProject/actions) [License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")

#### Installtion

Install directly from GitHub using the remotes package:

```R
remotes::install_github('wilsontom/myProject')
```

#### Usage

To create a new `drake`/`renv` project;

```R
# Initialise project
myProject::init('your_project_directory')

# Add Rmd report template
myProject::add_report('your_project_directory')
```
