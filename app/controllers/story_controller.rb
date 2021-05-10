class StoryController < ApplicationController
  def index
    @stories = Story.all
  end

  def create
  end

  def delete
  end

  def edit
  end

  def new
  end

  def show
    @story = Story.find(params['id'])
  end

  def update
  end
end
