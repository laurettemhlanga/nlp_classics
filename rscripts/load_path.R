rm(list = ls())

# packges to use 
list_of_packages <- c("stringr","ggplot2", "dplyr", "purrr", "haven", "tidyverse", 
                      "tidyr", "factoextra", "MASS", "broom", "ggwordcloud",  
                      "wordcloud", "stringr", "spacyr", "tidytext", "plotly", "widyr", 
                      "showtext", "ggtext", "kableExtra", "data.table",
                      "tidytext", "wordcloud2", "wordcloud", "reshape2", "GGally", 
                      "syuzhet", "corrplot", "gutenbergr", "textdata" )



read_install_pacakges <- function(packages = list_of_packages
){
  new_packages <- packages[!(list_of_packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new_packages)
  return(sapply(list_of_packages, require, character.only = TRUE))
}

read_install_pacakges()


map_theme <- function(){
  theme(axis.text.x = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_blank(),
        axis.ticks = ggplot2::element_blank(),
        rect = ggplot2::element_blank(),
        plot.background = ggplot2::element_rect(fill = "white", colour = NA),
        plot.title = element_text(hjust = 0.5),
        legend.title.align=0.5,
        legend.title=element_text(size=18, colour = 'black'),
        legend.text =element_text(size = 18, colour = 'black'),
        legend.key.height = unit(0.65, "cm"))
}


theme_manuscript <- function(){
  theme_bw() + 
    theme(panel.border = element_rect(colour = "black", fill=NA, size=0.5),
          plot.title = element_text(hjust = 0.5),
          axis.text.x = element_text(size = 12, color = "black"), 
          axis.text.y = element_text(size = 12, color = "black"),
          axis.title.x = element_text(size = 12),
          axis.title.y = element_text(size =12),
          legend.title=element_text(size=12, colour = 'black'),
          legend.text =element_text(size = 12, colour = 'black'),
          legend.key.height = unit(1, "cm"))
}




get_multiple_sentiments <- function(text) {
  # Function to get sentiment scores from both packages
  # Get sentimentr score
  # Get syuzhet score 
  sentimentr_score <- sentiment(text)$sentiment %>%
    mean()
  
  syuzhet_score <- get_sentiment(text, method="syuzhet") %>% 
    mean()
  
  return(c(sentimentr=sentimentr_score, 
           syuzhet=syuzhet_score))
}


process_book <- function(data, book_title) {
  # Function to read & preprocess each book
  # Remove common words
  data %>% 
    
    mutate(book = book_title) %>%
    unnest_tokens(word, text) %>%
    anti_join(stop_words) 
}


get_sentiment_arc <- function(book_df) {
  # Function to get sentiment trajectory over time
  book_df %>%
    mutate(section = row_number() %/% (n() / 10)) %>%
    inner_join(get_sentiments("bing"), by = "word") %>%
    group_by(book, section, sentiment) %>%
    summarise(sentiment_score = n(), .groups = "drop")
  
}


character_sentiment <- function(book_df, character_list) {
  # Function to get sentiment trends per character
  
  book_df %>%
    filter(word %in% character_list) %>%
    inner_join(get_sentiments("bing"), by = "word") %>%
    group_by(book, word, sentiment) %>%
    summarise(sentiment_score = n(), .groups = "drop")
}



plot_wordcloud <- function(book_df, sentiment_type) {
  # Function to generate word cloud for positive & negative words
  book_df %>%
    inner_join(get_sentiments("bing"), by = "word") %>%
    filter(sentiment == sentiment_type) %>%
    count(word, sort = TRUE) %>%
    with(wordcloud(word, n, max.words = 100, colors = brewer.pal(8, "Dark2")))
}
