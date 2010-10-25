class SearchController < ApplicationController
  
  def new
    @page_title = "Search Rubyocracy"
  end

  def create
    query = params[:query]
    # Handle invalid queries
    if query.blank?
      redirect_to search_path
      return false
    end
    @page_title     = "Search results for #{query}"
    @scope          = Story.with_query(query)
    @other_keywords = Story.popular_keywords_from(@scope) - [query]
    @stories        = @scope.all(:include => [:site, :categories])
  end

end
