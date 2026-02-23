library(ggplot2)

#' Read and combine multiple data files
#'
#' Reads multiple tab-separated files, validates column counts, and combines
#' them into a single data.table. Column names are standardized across all
#' files.
#'
#' @param file_list Character vector of file paths to read
#' @param column_names Named list with elements 'x' and 'y' specifying the
#'   expected column names in the input files
#'
#' @return A data.table containing all combined data with standardized column
#' names.
#'   Returns an empty data.table if no valid files are processed.
#'
#' @section Warning:
#' A warning is issued for any file that doesn't have the expected number of
#' columns, but processing continues.
#'
read_data <- function(file_list, column_names) {
  column_names <- c(column_names[["x"]], column_names[["y"]])
  full_dataset <- data.table::data.table()

  for (file in file_list) {
    data <- data.table::fread(
      file,
      header = TRUE,
      sep = "\t"
    )

    if (ncol(data) != length(column_names)) {
      warning(paste(
        "File",
        file,
        "has",
        ncol(data),
        "columns but expected",
        length(column_names)
      ))
    }

    full_dataset <- data.table::rbindlist(
      list(full_dataset, data),
      fill = TRUE
    )
  }

  data.table::setnames(full_dataset, column_names)
  return(full_dataset)
}

#' Create a line plot from data
#'
#' Generates a ggplot2 line plot using specified columns from the dataset.
#' Uses a black-and-white theme for clean visualization.
#'
#' @param dataset A data.table or data.frame containing the data to plot
#' @param column_names Named list with elements 'x' and 'y' specifying which
#'   columns to use for the x and y aesthetics
#' @param plot_axes_labels Named list with elements 'x' and 'y' specifying
#'   the axis labels for the plot
#'
#' @return A ggplot object representing the line plot. Can be further modified
#'   using standard ggplot2 syntax.
make_plot <- function(dataset, column_names, plot_axes_labels) {
  ggplot(
    data = dataset,
    mapping = aes(
      x = .data[[column_names[["x"]]]],
      y = .data[[column_names[["y"]]]]
    )
  ) +
    geom_line() +
    xlab(plot_axes_labels[["x"]]) +
    ylab(plot_axes_labels[["y"]]) +
    theme_bw()
}

#' Main workflow function
#'
#' Orchestrates the complete workflow: reads input files, creates a plot,
#' and saves it to disk. This is the primary function called by the Snakemake
#' rule.
#'
#' @param in_files Character vector of input file paths
#'   (from \code{snakemake@input})
#' @param out_file Output file path for the saved plot
#'   (from \code{snakemake@output[[1]]})
#' @param column_names Named list with column specifications
#'  (from \code{snakemake@config[["column_names"]]})
#' @param plot_axes_labels Named list with axis label specifications
#'   (from \code{snakemake@config[["plot_axes_labels"]]})
#'
#' @return Invisibly returns the ggplot object. Primarily called for its
#'   side effect of saving a plot file.
#'
#' @section Side Effects:
#' \itemize{
#'   \item Reads files from \code{in_files}
#'   \item Saves a plot to \code{out_file}
#'   \item May issue warnings about column mismatches
#' }
#'
main <- function(in_files, out_file, column_names, plot_axes_labels) {
  full_dataset <- read_data(in_files, column_names)
  plot <- make_plot(
    full_dataset,
    column_names,
    plot_axes_labels
  )
  suppressMessages(ggplot2::ggsave(
    out_file,
    plot,
    width = 3,
    height = 3,
  ))
}

if (!exists("is_sourced") || !is_sourced) {
  if (exists("snakemake")) {
    main(
      snakemake@input,
      snakemake@output[[1]],
      snakemake@config[["column_names"]],
      snakemake@config[["plot_axes_labels"]]
    )
  } else {
    warning(
      "Script executed outside Snakemake context. ",
      "Please only use this via the `snakemake` workflow manager.\n",
      "To do this, use `snakemake --cores all --sdm conda`"
    )
  }
}
