class LinksController < ApplicationController

  def index
  end

  def create
    # binding.pry;
    unless (Link.find_by origin: params[:origin]).nil?
      @short_url = Link.find_by origin: params[:origin]
    else
      @short_url = Link.create(link_params)
    end

    # flash[:notice] = 'Short link has been successfully generated'
    render :show
  end

  def show
    redirect_to "http://#{(Link.find_by shorten: params[:id]).origin}"
  end

  private
  def calc_n
    return 2 if Link.all.count <= 3249
    return 3 if Link.all.count <= 185193
    return 4 if Link.all.count <= 10_556_001
  end

  def generate_safe_link(n)
    ['q','w','e','r','t','y','u','p','a','s','d','f','g','h','j','k','z','x','c','v','b','n','m',\
    'Q','W','E','R','T','Y','U','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M',\
    '2','3','4','5','6','7','8','9','-','_'].sample(n).join
  end

  def link_params
    {origin: params[:origin], shorten: generate_safe_link(calc_n)}
  end
end