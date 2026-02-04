library(ggplot2)

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
  ))
}

main(
  snakemake@input,
  snakemake@output[[1]],
  snakemake@config[["column_names"]],
  snakemake@config[["plot_axes_labels"]]
)
