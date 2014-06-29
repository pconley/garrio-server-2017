class Rank < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :language
  
  validates :user, presence: true
  validates :score, presence: true
  validates :language, presence: true
  
  validates_uniqueness_of :language_id, :scope => :user_id
  
  def to_s
    "<Rank ##{id} #{language.name} user:#{user.name}>"
  end
end
