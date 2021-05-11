class AuthorController < ApplicationController
  def index
    @authors = Author.all.order(created_at: :asc)
  end

  def new; end

  def show
    @author = Author.find(params[:id])
  end

  def show_with_stories
    @author = Author.find(params[:id])
    if params[:sort_by_name]
      @stories = @author.stories.order(:name)
    else
      @stories = @author.stories
    end
  end

  def create
    admin = params[:author][:admin] == 'on'
    author = Author.create({name: params[:author][:name], admin: admin})
    author.save
    redirect_to '/authors'
  end

  def update
    author = Author.find(params[:id])
    admin = params[:author][:admin] == 'on'
    author.update({name: params[:author][:name], admin: admin})
    redirect_to "/author/#{author.id}"
  end

  def delete; end

  def edit
    @author = Author.find(params[:id])
  end
end
