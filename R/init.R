#' Create New Project
#'
#' Initialise a new project
#'
#' @param project_path a character vector of the directory where the `drake` & `renv` project will be created
#' @export
#' @examples
#' \dontrun{
#' init('/home/my_new_project')
#' }

init <- function(project_path)
{
    if (dir.exists(project_path)) {
        message(crayon::green(cli::symbol$tick, project_path, 'already exists'))
    }

    # Check if project_path needs creating

    if (!dir.exists(project_path)) {
        message(crayon::red(cli::symbol$cross, project_path, 'not found'),
                '\n')
        message(
            crayon::yellow(
                cli::symbol$ellipsis,
                'Creating directory at',
                project_path
            ),
            '\n'
        )
        dir.create(project_path)
    }

    # Chage working directory
    message(
        crayon::yellow(
            cli::symbol$ellipsis,
            'Setting working directory to',
            project_path
        ),
        '\n'
    )
    setwd(project_path)


    # Initialise git repository
    message(crayon::green(cli::symbol$tick, system('git init', intern = TRUE)), '\n')

    # Create git ignore
    usethis::use_git_ignore(c('.Rhistory', '.RData', '.Rproj.user'))

    #dev file

    # Initialise RStudio Project
    rstudioapi::initializeProject()
    message(crayon::green(cli::symbol$tick, 'Created RStudio project'))

    # Grab the project name
    project_name <- basename(getwd())


    # Initiliase drake
    message(crayon::yellow(cli::symbol$ellipsis, 'Creating drake infrastructure'))
    drake::use_drake(open = FALSE)

    # Create drake directory structure
    unlink('R/', recursive = TRUE)
    file.remove('make.R')
    file.remove('_drake.R')

    dir.create('data/')
    dir.create('R')

    dir.create('R/functions')
    invisible(file.create('R/plan.R'))
    invisible(file.create('R/packages.R'))


    # Create drake make file and populate
    invisible(file.create('_drake.R'))

    p1 <- paste0('source(\'R/packages.R\')')
    p2 <-
        paste0(
            '\'R/functions/\' %>%',
            '\n',
            'list.files(full.names = T) %>%',
            '\n',
            'walk(source)'
        )

    p3 <- paste0('source(\'R/plan.R\')')

    p4 <-
        paste0('drake_config(plan, verbose = 2, lock_envir = FALSE)')


    make_string <-
        paste0(p1, '\n', '\n', p2, '\n', '\n', p3, '\n', '\n', p4)

    writeLines(make_string, '_drake.R')


    # Initialise r-env

    # Write to files
    renv_string <- paste0('renv::restore()')

    pacman_string <-
        paste0('pacman::p_load(\'drake\',\'tidyverse\',\'piggyback\')')

    package_string <- paste0(renv_string, '\n', pacman_string)

    writeLines(package_string, 'R/packages.R')

    # Start drake plan
    writeLines('plan <- drake_plan()', 'R/plan.R')

    # Create README
    file.create('README.md')
    writeLines(paste0('# ', project_name), 'README.md')

    # Activate r-env
    renv::activate()

    # Install pacman
    renv::install(c('pacman', 'drake'))

    # Open project
    rstudioapi::openProject(project_path)

    # Finish
}
