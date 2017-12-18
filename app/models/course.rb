class Course < ApplicationRecord
  belongs_to :student
  has_many :assignments

  def grade
    return 'A' if average >= 90.00
    return 'B' if (average >= 80.00 && average < 90.00)
    return 'C' if (average >= 70.00 && average < 80.00)
    return 'D' if (average >= 60.00 && average < 70.00)
    'F'
  end

  def last_update_formatted
    return nil if last_update.blank?
    last_update.strftime('%m/%d/%Y')
  end
end
