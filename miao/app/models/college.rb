class College < ActiveRecord::Base
  validates :college_code, :name, :university_code, presence: true
  validates :college_code, inclusion: 1000000..35000000
  validates :university_code, inclusion: 1000..35000
end