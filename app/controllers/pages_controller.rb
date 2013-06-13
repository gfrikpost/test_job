class PagesController < ApplicationController
  
  def index
    
    if params[:surname] or params[:group_id] or params[:gpa_greater_or_equal] or params[:gpa_less_or_equal]
      @sql = Student.filter(params)         # если определенны параметры фильтра
      @students = Student.where(@sql)       # формируем необходимый sql запросс
    else
      @students = Student.first(10)      # по умолчанию получаем первых 10 студентов с наивысшим баллом
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.js 
      format.json { render json: @students }
    end
  end
  
  def ip_character
    @students = Student.ip_charcterization
    
    respond_to do |format|
      format.html { render 'pages/index' }
      format.js 
      format.json { render json: @students }
    end
  end
  
end
