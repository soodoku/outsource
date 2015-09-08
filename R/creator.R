#' Create Distributed Coding Tasks
#'
#' This function calculates the edit distance between OCR'd and human transcribed file.
#' The function by default prints the status of the task you are trying to delete. It will show up as 'deleted' if successful
#' @param input_files_dir path to directory containing text files that need to be coded; required
#' @param output_files_dir path to directory containing text files that need to be coded; required
#' @param path_to_form path to html form; required
#' @param n_per_worker maximum no. of stories that you want each worker to code
#' @param n_per_story  no. of times you want each story coded
#' @param seed seed for the random number generator
#' 
#' @export
#' @examples \dontrun{
#' creator(input_files_dir="path_to_input_files_dir", path_to_form="path_tp_html_form", 
#' 		   output_files_dir="path_to_output_files_dir", n_per_worker=20, n_per_story=3)
#' }

creator <- function(input_files_dir=NULL, path_to_form=NULL, output_files_dir=NULL, n_per_worker=10, n_per_story=3, seed=31415) 
{
	list_files     <- list.files(input_files_dir)
	n_files        <- length(list_files)
	n_total_tasks  <- n_files*n_per_story
	n_hits         <- ceiling(n_total_tasks/n_per_worker)

	stories        <- list()

	iterator       <- rep(1:length(list_files), n_per_story)

	# can be sampled better but ok for now
	# no duplication within worker
	set.seed(seed)
	for (i in 1:n_hits) {
		stories[[i]] <- sample(iterator[!duplicated(iterator)], n_per_worker, replace = FALSE)
		iterator     <- iterator[-which(iterator %in% stories[[i]])[1:n_per_worker]]
	}
	
	html_form <- read_file(path_to_form)

	# Part of the name/capped at 1 mil.
	part_name_1 <- paste0(sample(LETTERS), sample(LETTERS))
  	part_name_2 <- sample(100000:1100000, replace=FALSE)

	for (i in 1:n_hits) {
		
		html_file <- NA		
		outfile_name   <- paste0(part_name_1[i], part_name_2[i])
		
		# Build file
		for(j in list_files[stories[[i]]]) {
			story_i   <- read_file(paste0(input_files_dir, j))
			html_file <- paste0(story_i, html_form)
		    write(html_file, file = paste0(output_files_dir, outfile_name, ".html"), append=T)
		}

	}

}