class User < ActiveRecord::Base
  has_one :user_type
  has_many :user_tables
  has_many :tables, through: :user_tables
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
