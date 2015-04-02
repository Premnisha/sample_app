class ArticlesController < ApplicationController
  require 'articles_service'
  def index
    articles_object = ArticlesService.new
    count ={}
    count[:value] = params[:state] || 1
    @articles_list = articles_object.get_articles(count)
    @articles_list = @articles_list.first[1]
    if(@state == 1)
    @msg = { "success" => "true", "message" => @articles_list}
 
    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end
  end
end
