class PagesController < ApplicationController
  
  def index
    
    if params[:surname] 
      scope = Student.scoped
      scope = scope.with_surname(params[:surname]) if params[:surname].present?
      scope = scope.with_group_id(params[:group_id]) if params[:group_id].present?
      scope = scope.if_gpa_greater_or_equal(params[:gpa_greater_or_equal]) if params[:gpa_greater_or_equal].present?
      scope = scope.if_gpa_less_or_equal(params[:gpa_less_or_equal]) if params[:gpa_less_or_equal].present?
      @students = scope     # формируем необходимый sql запросс
    else
      @students = Student.first(10)
            # по умолчанию получаем первых 10 студентов с наивысшим баллом
    end
    
    @groups = Group.names_id # Получаем массив [название, ид группы]
    @semestrs = Evaluation::SEMESTERS
    
    respond_to do |format|
      format.html # index.html.erb
      format.js 
    end
  end
  
  def ip_character
    @students = Student.ip_charcterization
    
    respond_to do |format|
      format.html { render 'pages/index' }
      format.js 
    end
  end
  
end
