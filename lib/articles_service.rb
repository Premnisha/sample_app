class ArticlesService
  require 'open-uri'

  def get_articles( count = {} )
  	return JSON.parse(open("http://api.feedzilla.com/v1/categories/26/subcategories/1320/articles.json?count=#{count[:value]}").read)
  end
  
end