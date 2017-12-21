Fabricator(:course) do
  student
  name { Faker::Educator.course }
  average { Faker::Number.between(0.00, 100.00) }
  last_update { Time.now }
end

Fabricator(:course_with_assignments, from: :course) do
  assignments(count: 5) { Fabricate(:assignment) }
end
