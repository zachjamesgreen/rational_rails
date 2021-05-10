class AuthorController < ApplicationController
  def index
    @authors = Author.all.order(created_at: :asc)
  end

  def new
  end

  def show
    @author = Author.find(params[:id])
  end

  def show_with_stories
    @author = Author.find(params[:id])
  end

  def create
    admin = params[:author][:admin] == 'on' ? true : false
    author = Author.create({name: params[:author][:name], admin: admin})
    author.save
    redirect_to '/authors'
  end

  def update
  end

  def delete
  end

  def edit
    @author = Author.find(params[:id])
  end
end
