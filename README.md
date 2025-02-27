# nlp_classics
This project applies Natural Language Processing (NLP) and Sentiment Analysis to explore how emotion, gender representation, and literary classification work in Jane Austen’s books. We analyze:

- How emotions evolve across books (sentiment trajectory analysis)
- Differences in sentiment associated with male vs. female characters
- Whether sentiment-based features can classify a book correctly using Machine Learning

**Books Analyzed:**

 - Pride and Prejudice (ID: 1342)
 - Sense and Sensibility (ID: 161)
 - Emma (ID: 158)
 - Mansfield Park (ID: 141)

📜 README.md            - Project overview  
📂 data/                - Raw text files of books  
📂 images/              - Sentiment visualizations  
📂 notebooks/           - Jupyter Notebooks for analysis  
📂 r_scripts/           - R scripts for sentiment analysis  
📂 docs/                - Additional documentation  
📂 models/              - Machine learning classification models  

**Methods Used**
- Sentiment Analysis: Bing, NRC, AFINN, VADER
- Tokenization & NLP Preprocessing: tidytext, NLTK, spaCy
- Data Visualization: ggplot2, matplotlib, wordcloud
- Machine Learning for Book Classification: Naïve Bayes, Logistic Regression


**Theme 1: Sentiment Trends in Literature**
How do emotions shift across different books?
-- Analyzing sentiment flow across chapters
-- Tracking emotional arcs in storytelling
-- Comparing sentiment distributions in different books

