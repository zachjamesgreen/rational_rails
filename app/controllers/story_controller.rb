class StoryController < ApplicationController
  def index
    @stories = Story.all
  end

  def create
    author = Author.find(params[:id])
    story = Story.create(name: params[:story][:name], likes: params[:story][:likes], published: params[:story][:published], author: author)
  end

  def delete
  end

  def edit
  end

  def new
    @author = Author.find(params[:id])
  end

  def show
    @story = Story.find(params['id'])
  end

  def update
  end
end
