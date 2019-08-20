Fabricator(:student) do
  student_id { Faker::Number.number(digits: 6) }
  name { Faker::Name.name }
end

Fabricator(:student_with_courses, from: :student) do
  courses(count: 5) { Fabricate(:course_with_assignments) }
end
