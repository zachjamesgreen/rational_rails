class AuthorController < ApplicationController
  def index
    @authors = Author.includes(:stories).all.order(created_at: :asc)
    @authors = @authors.sort_by(&:stories_count) if params[:sort_by_stories]
    @authors = @authors.where(name: params[:exact_match]) if params[:exact_match]
    @authors = @authors.where('name ILIKE ?', "%#{params[:partial_match]}%") if params[:partial_match]
  end

  def new; end

  def show
    @author = Author.find(params[:id])
  end

  def show_with_stories
    @author = Author.find(params[:id])
    likes = params[:greater_than].to_i
    @stories = @author.stories
    @stories = @stories.where(likes: likes + 1..Float::INFINITY) if params[:greater_than]
    @stories = @stories.order(:name) if params[:sort_by_name]
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
    redirect_to "/authors/#{author.id}"
  end

  def delete
    author = Author.find(params[:id])
    author.stories.delete_all
    author.destroy
    redirect_to '/authors'
  end

  def edit
    @author = Author.find(params[:id])
  end
end
