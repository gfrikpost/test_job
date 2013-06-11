class PagesController < ApplicationController
  
  def index
    @students = Student.first(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end
  
  def eval
    @student = Student.find(params[:id])
    @evaluations = @student.evaluations
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end
end
