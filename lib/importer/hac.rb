module Importer
  class Hac
    class CredentialsMissingError < StandardError; end
    class OtherError < StandardError; end
    class NilResultsError < StandardError; end

    attr_reader :data

    def initialize
      check_env_vars
    end

    def import
      get_data
      raise NilResultsError, 'Data from HAC is nil!' if data.blank?

      data.each do |s|
        student = Student.find_or_create_by(student_id: s[:student_id], name: s[:student_name])

        s[:classes].each do |c|
          course = Course.find_or_create_by(student: student, name: c[:class_name])
          course.update(
            average: c[:average].to_f,
            last_update: convert_date(c[:last_update])
          )

          c[:assignments].each do |a|
            assignment = Assignment.find_or_create_by(course: course, student: student, name: a[:assignment_name])
            assignment.update(
              date_assigned: convert_date(a[:date_assigned]),
              due_date: convert_date(a[:due_date]),
              category: a[:category],
              score: a[:score].to_f,
              total_points: a[:total_points].to_f
            )
          end
        end
      end

      self
    end

    private

    def check_env_vars
      raise CredentialsMissingError, 'HAC_URL is missing. Check app/config/local_env.yml' if ENV['HAC_URL'].blank?
      raise CredentialsMissingError, 'HAC_SCHOOL is missing. Check app/config/local_env.yml' if ENV['HAC_SCHOOL'].blank?
      raise CredentialsMissingError, 'HAC_USERNAME is missing. Check app/config/local_env.yml' if ENV['HAC_USERNAME'].blank?
      raise CredentialsMissingError, 'HAC_PASSWORD is missing. Check app/config/local_env.yml' if ENV['HAC_PASSWORD'].blank?
      true
    end

    def hac_params
      {
        url: ENV['HAC_URL'],
        school: ENV['HAC_SCHOOL'],
        username: ENV['HAC_USERNAME'],
        password: ENV['HAC_PASSWORD']
      }
    end

    def get_data
      begin
        @data = HacAdapter.all_reports(hac_params)
      rescue => e
        raise OtherError, e.message
      end
    end

    def convert_date(date)
      return nil if date.blank?
      Date.strptime(date, '%m/%d/%Y')
    end
  end
end
