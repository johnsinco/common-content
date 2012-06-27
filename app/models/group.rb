class Group < Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: Textile
  field :body, type: Textile

  validates :body, presence: true

end