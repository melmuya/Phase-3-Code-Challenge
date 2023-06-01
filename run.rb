class Author
    attr_reader :name
  
    def initialize(name)
      @name = name
      @articles = []
    end
  
    def articles
      @articles
    end
  
    def magazines
      @articles.map { |article| article.magazine }.uniq
    end
  
    def add_article(magazine, title)
      article = Article.new(self, magazine, title)
      @articles << article
      magazine.add_contributor(self)
      article
    end
  
    def topic_areas
      magazines.map { |magazine| magazine.category }.uniq
    end
  end
  
  class Magazine
    attr_accessor :name, :category
  
    @@all = []
  
    def initialize(name, category)
      @name = name
      @category = category
      @contributors = []
      @@all << self
    end
  
    def self.all
      @@all
    end
  
    def self.find_by_name(name)
      @@all.find { |magazine| magazine.name == name }
    end
  
    def contributors
      @contributors
    end
  
    def add_contributor(author)
      @contributors << author
    end
  
    def article_titles
      Article.all.select { |article| article.magazine == self }.map { |article| article.title }
    end
  
    def contributing_authors
      @contributors.select { |author| author.articles.count > 2 }
    end
  end
  
  class Article
    attr_reader :author, :magazine, :title
  
    @@all = []
  
    def initialize(author, magazine, title)
      @author = author
      @magazine = magazine
      @title = title
      @@all << self
    end
  
    def self.all
      @@all
    end
  end
  


# Create authors
author1 = Author.new("John Doe")
author2 = Author.new("Jane Smith")

# Create magazines
magazine1 = Magazine.new("Magazine 1", "Category 1")
magazine2 = Magazine.new("Magazine 2", "Category 2")

# Create articles and associate them with authors and magazines
article1 = author1.add_article(magazine1, "Article 1")
article2 = author1.add_article(magazine1, "Article 2")
article3 = author2.add_article(magazine1, "Article 3")
article4 = author2.add_article(magazine2, "Article 4")

# Test the methods

# Author methods
puts "Author: #{author1.name}"
puts "Articles by #{author1.name}: #{author1.articles.map(&:title)}"
puts "Magazines contributed by #{author1.name}: #{author1.magazines.map(&:name)}"
puts "Topic areas of #{author1.name}: #{author1.topic_areas}"

# Magazine methods
puts "\nMagazine: #{magazine1.name}"
puts "Contributors of #{magazine1.name}: #{magazine1.contributors.map(&:name)}"
puts "Article titles for #{magazine1.name}: #{magazine1.article_titles}"
puts "Contributing authors (more than 2 articles) for #{magazine1.name}: #{magazine1.contributing_authors.map(&:name)}"

puts "\nMagazine: #{magazine2.name}"
puts "Contributors of #{magazine2.name}: #{magazine2.contributors.map(&:name)}"
puts "Article titles for #{magazine2.name}: #{magazine2.article_titles}"
puts "Contributing authors (more than 2 articles) for #{magazine2.name}: #{magazine2.contributing_authors.map(&:name)}"
