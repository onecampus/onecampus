class University < ActiveRecord::Base
  validates :university_code, :name, :province_code, presence: true
  validates :university_code, inclusion: 1000..35000
end