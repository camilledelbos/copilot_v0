class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         

# has_many :maps
has_many :travels
has_many :routes, through: :travels
# has_many :stages, through: :routes
end
