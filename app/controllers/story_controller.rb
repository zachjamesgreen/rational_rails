class StoryController < ApplicationController
  def index
    @stories = Story.all.where(published: true)
  end

  def create
    author = Author.find(params[:id])
    published = params[:story][:published].nil? ? false : true
    Story.create(name: params[:story][:name], likes: params[:story][:likes], published: published, author: author)
    redirect_to "/author/#{author.id}/stories"
  end

  def delete
  end

  def edit
    @story = Story.find(params[:id])
  end

  def new
    @author = Author.find(params[:id])
  end

  def show
    @story = Story.find(params['id'])
  end

  def update
    story = Story.find(params[:id])
    published = params[:story][:published].nil? ? false : true
    story.update(name: params[:story][:name], likes: params[:story][:likes], published: published)
    redirect_to "/story/#{story.id}"
  end
end
