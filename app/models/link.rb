class Link < ActiveRecord::Base
  validates :origin, presence: true, length: { minimum: 4 }, uniqueness: true
  validates :shorten, presence: true, uniqueness: true

  def to_param
    shorten
  end
end