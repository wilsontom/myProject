#' Add Rmd Report
#'
#' Add a template file for create a rmarkdown html report
#'
#' @param project_path the absolute directory path of where the project was created using `myProject::init()`
#' @param type character
#' @export

add_presentation <- function(project_path, type = '')
{
    if (!dir.exists(project_path)) {
        message(crayon::red(cli::symbol$cross, project_path, 'not found'),
                '\n')
    }

    dir.create(paste0(project_path, '/presentation'))

    if(type == 'presento'){


    file.copy(
        from = system.file('presento.Rmd', package = 'myProject'),
        to = paste0(project_path, '/presentation/slides.Rmd')
    )

    message(crayon::green(cli::symbol$tick, 'Rmd presento presentation template added'),
            '\n')

    }

    setwd(project_path)

    renv::install('binb')

    return(invisible(NULL))
}
