class Language < ActiveRecord::Base
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
  validates :flag, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2 }
  validates :code, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2 }
  
  def to_s
    "<Language #{id} #{code} #{flag} #{name}>"
  end
end
