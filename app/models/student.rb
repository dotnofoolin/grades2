class Student < ApplicationRecord
  has_many :courses
  has_many :assignments

  def courses_for_dashboard
    courses.where('average > 0.0').order('last_update DESC')
  end
end
