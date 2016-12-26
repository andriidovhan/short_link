class LinksController < ApplicationController
  helper_method :link

  def index
    @link = Link.new
  end

  def create
    if link.valid?
      flash[:notice] = 'Short link has been successfully generated'
    else
      flash[:error] = 'Invalid input'
    end

    render :index
  end

  def show
    @link = Link.find_by(shorten: params[:shorten])

    if @link
      redirect_to "http://#{link.origin}"
    else
      flash[:error] = 'Not found'
      redirect_to root_path
    end
  end

  def update
    create
  end

  private

  def link
    @link ||= LinkService.call(params[:link])
  end
end