#' Add Rmd Report
#'
#' Add a template file for create a rmarkdown html report
#'
#' @param project_path the absolute directory path of where the project was created using `myProject::init()`
#' @export

add_report <- function(project_path)
{
    if (!dir.exists(project_path)) {
        message(crayon::red(cli::symbol$cross, project_path, 'not found'),
                '\n')
    }

    dir.create(paste0(project_path, '/report'))

    file.copy(
        from = system.file('report.Rmd', package = 'myProject'),
        to = paste0(project_path, '/report')
    )

    message(crayon::green(cli::symbol$tick, 'Rmd report template added'),
            '\n')

    usethis::use_git_ignore('report/report.html')

    return(invisible(NULL))
}
