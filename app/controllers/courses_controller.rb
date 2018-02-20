class CoursesController < ApplicationController
  def show
    @course = course
  end

  private

  def course_params
    params.permit(:id)
  end

  def course
    Course.find(course_params[:id])
  end
end
