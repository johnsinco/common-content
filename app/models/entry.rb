class Entry < Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: Textile
  field :body, type: Textile

  validates :body, presence: true

  validates :child_contents, length: {:maximum => 0}

end