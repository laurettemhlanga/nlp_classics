
source("load_path.R")

loaded_books <- readRDS("data/books/book_files.RDS")

# Define characters per book
characters <- list(
  "Pride and Prejudice" = c("Elizabeth", "Darcy", "Jane", "Bingley"),
  "Sense and Sensibility" = c("Elinor", "Marianne", "Edward", "Willoughby"),
  "Emma" = c("Emma", "Knightley", "Frank", "Harriet")
)




character_dialogues <- map2_dfr(loaded_books, names(characters), 
                                #  Apply function correctly with map2_dfr
                                ~extract_character_sentences(.x$text, characters[[.y]], .y))





character_sentiments <- character_dialogues %>%
  # Compute sentiment scores per sentence
  # Analyze sentence sentiment
  mutate(sentiment_score = sentimentr::sentiment(sentence)$sentiment) %>%  
  group_by(book, character) %>%
  summarise(average_sentiment = mean(sentiment_score, na.rm = TRUE), .groups = "drop")

# lot Sentiment by Character
ggplot(character_sentiments, aes(x = character, y = average_sentiment, fill = book)) +
  geom_col(position = "dodge") +
  facet_wrap(~ book, scales = "free") +
  theme_minimal() +
  labs(title = "Sentence-Level Sentiment of Characters",
       x = "Character",
       y = "Average Sentiment Score")







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



# Plot word clouds
par(mfrow = c(1, 2)) # Set up side-by-side plots
plot_wordcloud(books_df, "positive") # Positive words
plot_wordcloud(books_df, "negative") # Negative words


