# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require 'digest'
class User < ActiveRecord::Base
  acts_as_messageable
    
  has_many :mesajes
    
    has_many :user_acts
    has_many :activities, :through => :user_acts
    
    attr_accessor :password
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name, :presence => true,
                     :uniqueness => true,
                     :length => { :minimum => 3, :maximum => 20}
    
    validates :email, :presence => true,
                      :format => { :with => email_regex }
    
    validates :password, :presence => true,
                         :confirmation => true,
                         :length => { :within => 3..40 }
    
    before_save :encrypt_password
    
    def has_password?(submitted_password)
        encrypted_password == encrypt(submitted_password)
    end
    
    def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
    end

def self.authenticate(email, submitted_password)
user = find_by_email(email)
return nil  if user.nil?
return user if user.has_password?(submitted_password)
end

def self.authenticate_with_salt(id, cookie_salt)
user = find_by_id(id)
(user && user.salt == cookie_salt) ? user : nil
end


private

    def encrypt_password
        self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
        secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
        Digest::SHA2.hexdigest(string)
    end
    
    
end
