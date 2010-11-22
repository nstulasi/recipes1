class User < ActiveRecord::Base
  has_many :recipe

  
  attr_accessor :current_password

  validates_presence_of :screen_name, :e_mail, :password
  validates_uniqueness_of :screen_name
  validates_uniqueness_of :e_mail, :case_sensitive => false
  validates_length_of :screen_name, :within => 6..30
  validates_length_of :e_mail, :within => 6..50
  validates_length_of :password, :within => 6..30
  validates_confirmation_of :password
  validates_format_of     :e_mail,     :with => /^[A-Z0-9_.%-]+@([A-Z0-9_]+\.)+[A-Z]{2,4}$/i,
                                       :message => "must be a valid e-mail address"
  validates_presence_of :first_name, :last_name
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
  def login!(session)
    session[:user_id] = id
  end
  
  def self.logout!(session)
    session[:user_id] = nil
  end
  
  def self.logged_in?(session)
    session[:user_id] != nil
  end
  
  def self.logged_in(session)
    return nil if not logged_in?(session)
    User.find(session[:user_id])
  end
  
  def update_attributes(attributes)
    if attributes[:password].empty?
      # the user doesn't want to change the password
      attributes[:password] = password
      attributes[:password_confirmation] = password
    elsif attributes[:current_password] != password
      # the user provided incorrect current_password
      errors.add(:current_password, "is incorrect")
      return false
    end
    super(attributes)
  end
end
