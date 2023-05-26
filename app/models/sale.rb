class Sale < ApplicationRecord
  has_one_attached :sales_file

  belongs_to :item
  belongs_to :merchant
end
