source("load_path.R")

loaded_books <- readRDS("data/books/book_files.RDS")



books_df <- map2_dfr(loaded_books, 
                     names(loaded_books), 
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


