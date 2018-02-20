class Course < ApplicationRecord
  belongs_to :student
  has_many :assignments

  include GradeLetter

  def grade
    grade_letter(average)
  end

  def last_update_formatted
    return nil if last_update.blank?
    last_update.strftime('%m/%d/%Y')
  end
end
