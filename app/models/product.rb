class Product < ActiveRecord::Base
  has_many :product_details,:dependent => :destroy
end
