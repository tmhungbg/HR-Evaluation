class Period < ActiveRecord::Base
  has_many :evaluation_results
  has_many :staffs, through: :evaluation_results
end
