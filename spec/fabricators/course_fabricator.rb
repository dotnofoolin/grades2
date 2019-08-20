Fabricator(:course) do
  student
  name { Faker::Educator.course }
  average { Faker::Number.within(range: 0..100) }
  last_update { Time.now }
end

Fabricator(:course_with_assignments, from: :course) do
  assignments(count: 5) { Fabricate(:assignment) }
end
