class LinksController < ApplicationController

  def index
  end

  def create
    @short_url = Link.create(link_params)
    # flash[:notice] = 'Short link has been successfully generated'
    render :show
  end

  def show
    redirect_to "http://#{(Link.find_by shorten: params[:id]).origin}"
  end

  private
  def calc_n
    return 3 if Link.all.count <= 100
    return 4 if Link.all.count <= 1000
    return 5 if Link.all.count <= 10000
  end

  def link_params
    {origin: params[:origin], shorten: SecureRandom.urlsafe_base64(calc_n)}
  end
end