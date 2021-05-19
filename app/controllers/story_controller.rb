class StoryController < ApplicationController
  def index
    @stories = Story.all.where(published: true)
    @stories = @stories.where(name: params[:exact_match]) if params[:exact_match]
    @stories = @stories.where('name ILIKE ?', "%#{params[:partial_match]}%") if params[:partial_match]
  end

  def create
    author = Author.find(params[:id])
    s = Story.new(story_params)
    s.author = author
    s.published = params[:story][:published].nil? ? false : true
    s.save
    redirect_to "/authors/#{author.id}/stories"
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
    story_params[:published] = params[:story][:published].nil? ? false : true
    story.update(story_params)
    redirect_to "/stories/#{story.id}"
  end

  def delete
    story = Story.find(params[:id])
    story.delete
    redirect_to '/stories'
  end

  private

  def story_params
    params.require(:story).permit(:name, :likes)
  end
end
