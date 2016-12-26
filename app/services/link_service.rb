class LinkService
  def self.call(*args)
    new(*args).call
  end

  def initialize(params = {})
    @params       = params
    @origin       = params.fetch(:origin, nil)
    @links_amount = Link.count
  end

  def call
    Link.find_by(origin: origin) || Link.create(link_params)
  end

  private

  attr_reader :params, :origin, :links_amount


  def calc_chars
    if links_amount <= 185193
      3
    elsif links_amount <= 10_556_001
      4
    else
      2
    end
  end

  def generate_safe_link(chars_count)
    ['q','w','e','r','t','y','u','p','a','s','d','f','g','h','j','k','z','x','c','v','b','n','m',\
    'Q','W','E','R','T','Y','U','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M',\
    '2','3','4','5','6','7','8','9','-','_'].sample(chars_count).join
  end

  def link_params
    {
      origin:  origin,
      shorten: generate_safe_link(calc_chars)
    }
  end
end