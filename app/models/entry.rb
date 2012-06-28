class Entry < Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: Textile
  field :body, type: Textile

  validates :body, presence: true

  validate :childless

  def childless
    errors.add(:child_contents, 'Entry cannot contain children') unless child_contents.blank?
  end
end