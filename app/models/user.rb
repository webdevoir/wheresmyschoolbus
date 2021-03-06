class User < ActiveRecord::Base
  has_many :busses
  
  cattr_reader :per_page
  @@per_page = 20

  accepts_nested_attributes_for :busses, :allow_destroy=>true, :reject_if=>lambda {|b| b["fleet_id"].blank? && b["id"].blank?}
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :busses_attributes, :student_ids
  
  validates_presence_of :first_name, :if=>:has_signed_in?
  validates_presence_of :last_name, :if=>:has_signed_in?
  validates_presence_of :password, :if=>:password_required?
  validates_presence_of :password_confirmation, :if=>:password_required?
  
  private
  def password_required?
    sign_in_count > 0 && ((confirmation_sent_at? && encrypted_password.blank?) || password.present? || password_confirmation.present?)
  end
  def has_signed_in?
    sign_in_count > 0
  end
end
