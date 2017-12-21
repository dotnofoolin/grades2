Fabricator(:assignment) do
  student
  course
  name { Faker::Lorem.sentence }
  category { Faker::Lorem.words.first }
  score { Faker::Number.number }
  total_points { Faker::Number.number }
  due_date { Time.now }
  date_assigned { Time.now }
end
