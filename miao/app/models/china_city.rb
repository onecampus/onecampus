class ChinaCity < ActiveRecord::Base
  validates :area_code, :area, :parent_id, :level, presence: true
  validates :area_code, inclusion: 100000..1000000
  validates :level, inclusion: 1..3
end
