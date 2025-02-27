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

**File organization**
nlp_classics           
 📂 data/                 
    ├── pride_prejudice.txt  
    ├── sense_sensibility.txt  
    ├── emma.txt  
    ├── mansfield_park.txt  
    ├── processed_data.csv  
 📂 images/               
    ├── sentiment_trend.png  
    ├── gender_sentiment_comparison.png  
    ├── wordcloud_positive.png  
    ├── wordcloud_negative.png  
 📂 notebooks/             
    ├── sentiment_analysis.ipynb  
    ├── gender_bias_analysis.ipynb  
    ├── ml_book_classification.ipynb  
 📂 r_scripts/           
    ├── sentiment_analysis.R  
    ├── gender_bias_analysis.R  
 📂 docs/                 #
    ├── project_description.md  
    ├── methodology.md  
 📂 models/               # Machine learning classification models  
    ├── trained_model.pkl  
    ├── model_performance_metrics.json  
 📜 README.md    

**Methods Used**
- Sentiment Analysis: Bing, NRC, AFINN, VADER
- Tokenization & NLP Preprocessing: tidytext, NLTK, spaCy
- Data Visualization: ggplot2, matplotlib, wordcloud
- Machine Learning for Book Classification: Naïve Bayes, Logistic Regression

**Theme 1: Sentiment Trends in Literature** How do emotions shift across different books?
- Analyzing sentiment flow across chapters
- Tracking emotional arcs in storytelling
- Comparing sentiment distributions in different books

**Theme 2: Gender & Sentiment Bias** Do male and female characters have different sentiment scores?
- Are female characters assigned more “negative” sentiment words than male characters?
- Are male characters associated with rationality while females get emotional adjectives?
- Is Austen’s portrayal of gender reflected in modern AI sentiment analysis?

 **Theme 3: Machine Learning for Book Classification** Can sentiment-based features predict which book a paragraph comes from?
- Building a classifier to predict Austen book authorship
- Training a sentiment-based ML model on text excerpts
- Exploring genre classification using emotional ton
