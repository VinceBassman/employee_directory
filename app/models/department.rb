class Department < ApplicationRecord
  #has_many :positions
  has_many :employees
  has_many :rooms
end
