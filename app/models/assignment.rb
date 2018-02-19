class Assignment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  def due_date_formatted
    return nil if due_date.blank?
    due_date.strftime('%m/%d/%Y')
  end

  def date_assigned_formatted
    return nil if date_assigned.blank?
    date_assigned.strftime('%m/%d/%Y')
  end
end
