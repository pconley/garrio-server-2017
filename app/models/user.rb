class User < ActiveRecord::Base
    
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }, :length => { :in => 2..20 }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :length => { :in => 6..30 } #, :email => true
  validates :language_id, :presence => true, :on => :create
  
  belongs_to :language # native language
  
  has_many :ranks, :dependent => :destroy
  has_many :languages, :through => :ranks  
  
  def to_s
    "<User ##{id} #{name} #{language.name} is_admin?=#{is_admin?}>"
  end
  
  def is_admin?
    admin
  end
  
  def authenticate(pswd)
    true
  end
  
  def activated
    true
  end
    
  def login()
    self.last_login_at = Time.now
    gen_session_token()
  end
  
  def logout
    # invalidate the token
    clear_session_token()
  end
  
  def gen_session_token
    self.session_token = generate_token(:session_token)
    self.session_token_created_at = Time.now
    self.save!
    return self.session_token
  end

  def clear_session_token
    self.session_token = nil
    self.save!
  end

  def gen_registration_token
    self.registration_token = generate_token(:registration_token)
    self.registration_token_created_at = Time.now
  end

  def gen_reset_token
    self.password_reset_token = generate_token(:password_reset_token)
    self.password_reset_token_created_at = Time.now
    self.save!
    return self.password_reset_token
  end

  def generate_token(field)
    count = 0
    begin
      count += 1
      
      
      # hex = SecureRandom.hex
      # jwt.sign(profile, secret, { expiresInMinutes: 60*5 });
      
      # t = Time.now         #=> 2007-11-19 08:22:21 -0600
      # t + (60 * 60 * 24)   #=> 2007-11-20 08:22:21 -0600
      
      expires = Time.now + 3 * (60 * 60 * 24) # three days
      hex = JWT.encode({email: email, exp: expires}, "secret")
      puts "jwt = #{hex}"
      
      
      break if count > 10 # safety check
    end while User.where("#{field} = ?", hex).first
    return hex # a new unique token for this field in the User table
  end
  
  
end
