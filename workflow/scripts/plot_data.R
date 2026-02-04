library(ggplot2)

expected_colnames <- c("x", "sin_x")

read_data <- function(file_list) {
  full_dataset <- data.table::data.table()

  for (file in file_list) {
    data <- data.table::fread(
      file,
      header = TRUE,
      sep = "\t"
    )

    if (ncol(data) != length(expected_colnames)) {
      warning(paste(
        "File",
        file,
        "has",
        ncol(data),
        "columns but expected",
        length(expected_colnames)
      ))
    }

    full_dataset <- data.table::rbindlist(
      list(full_dataset, data),
      fill = TRUE
    )
  }

  data.table::setnames(full_dataset, expected_colnames)
  return(full_dataset)
}

make_plot <- function(dataset, x_var, y_var) {
  ggplot(
    data = dataset,
    mapping = aes(x = .data[[x_var]], y = .data[[y_var]])
  ) +
    geom_line() +
    ylab("sin(x)") +
    theme_bw()
}


main <- function(in_files, out_file) {
  full_dataset <- read_data(in_files)
  plot <- make_plot(
    full_dataset,
    expected_colnames[[1]],
    expected_colnames[[2]]
  )
  suppressMessages(ggplot2::ggsave(
    out_file,
    plot,
  ))
}

print(snakemake@input)
main(snakemake@input, snakemake@output[[1]])
