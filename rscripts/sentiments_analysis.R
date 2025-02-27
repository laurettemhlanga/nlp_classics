



# Define the URL for Pride and Prejudice since it has been archived
book_url <- "https://www.gutenberg.org/cache/epub/1342/pg1342.txt"


book_path <- "data/books/pride_prejudice.txt"

if (!dir.exists("data/books")) {
  
  dir.create("data/books", recursive = TRUE)
  
}




if (!file.exists(book_path)) {
  
  download.file(book_url, destfile = book_path, mode = "wb")
  message("Book downloaded successfully!")
  
} else {
  
  message("Book already exists locally.")
  
}



pride_text <- readLines(book_path, encoding = "UTF-8")


pride_df <- data.frame(text = pride_text, stringsAsFactors = FALSE)
sense_text <- gutenberg_download(161)
emma_text <- gutenberg_download(158)


book_files <- list(pride_df, 
                   sense_text[,2], 
                   emma_text[,2])

names(book_files) <- c("pride and prejudice",
                       "sense and sensibility", 
                       "emma")

book_title <- names(book_files)






books_df <- map2_dfr(book_files, 
                     names(book_files), 
                     process_book)


# Load sentiment dictionary
nrc_sentiments <- get_sentiments("nrc")

sentiment_data <- books_df %>%
  inner_join(nrc_sentiments, by = "word") %>%
  count(book, sentiment, sort = TRUE)


ggplot(sentiment_data, aes(x = sentiment, y = n, fill = book)) +
  geom_col(position = "dodge") +
  theme_minimal() +
  labs(title = "Sentiment Distribution in Austen’s Books",
       x = "Sentiment Category",
       y = "Word Count") +
  theme_manuscript()




# Compute sentiment arc
sentiment_arc_data <- get_sentiment_arc(book_df = books_df)



# Plot sentiment trends over time
ggplot(sentiment_arc_data, aes(x = section,
                               y = sentiment_score, 
                               color = sentiment)) +
  geom_line() +
  facet_wrap(~ book, scales = "free_y") +
  theme_minimal() +
  labs(title = "Sentiment Arc Over Time",
       x = "Book Section",
       y = "Sentiment Score")


#################################################
#Character Sentiment Trends
################################################


characters <- list(
  # Define major characters per book
  "Pride and Prejudice" = c("Elizabeth", "Darcy", "Jane", "Bingley"),
  "Sense and Sensibility" = c("Elinor", "Marianne", "Edward", "Willoughby"),
  "Emma" = c("Emma", "Knightley", "Frank", "Harriet")
)




# Apply to all books
character_sentiments <- map2_dfr(books_df, characters, character_sentiment)

# Plot sentiment per character
ggplot(character_sentiments, aes(x = word, y = sentiment_score, fill = sentiment)) +
  geom_col(position = "dodge") +
  facet_wrap(~ book, scales = "free") +
  theme_minimal() +
  labs(title = "Sentiment Trends of Main Characters",
       x = "Character",
       y = "Sentiment Score")




#################################################
# Define gender-based words
################################################


male_words <- c("he", "him", "his", "mr", "man", "men")
female_words <- c("she", "her", "mrs", "miss", "lady", "woman", "women")

# Function to compute sentiment distribution for gender terms
gender_sentiment <- function(book_df) {
  book_df %>%
    filter(word %in% c(male_words, female_words)) %>%
    inner_join(get_sentiments("bing"), by = "word") %>%
    group_by(book, word, sentiment) %>%
    summarise(sentiment_score = n(), .groups = "drop") %>%
    mutate(gender = ifelse(word %in% male_words, "Male", "Female"))
}

# Apply function to all books
gender_sentiment_data <- map_dfr(books_df, gender_sentiment)

# Plot gender-based sentiment distribution
ggplot(gender_sentiment_data, aes(x = sentiment, y = sentiment_score, fill = gender)) +
  geom_col(position = "dodge") +
  facet_wrap(~ book) +
  theme_minimal() +
  labs(title = "Gender-Based Sentiment Comparison",
       x = "Sentiment",
       y = "Word Count")


###########################################################
#word cloud with high impact 
###########################################################

# Function to generate word cloud for positive & negative words
plot_wordcloud <- function(book_df, sentiment_type) {
  book_df %>%
    inner_join(get_sentiments("bing"), by = "word") %>%
    filter(sentiment == sentiment_type) %>%
    count(word, sort = TRUE) %>%
    with(wordcloud(word, n, max.words = 100, colors = brewer.pal(8, "Dark2")))
}

# Plot word clouds
par(mfrow = c(1, 2)) # Set up side-by-side plots
plot_wordcloud(books_df, "positive") # Positive words
plot_wordcloud(books_df, "negative") # Negative words


