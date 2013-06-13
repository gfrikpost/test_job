class PagesController < ApplicationController
  
  def index
    
    if params[:surname] or params[:group_id] or params[:gpa_greater_or_equal] or params[:gpa_less_or_equal]
      @sql = Student.filter(params)
      @students = Student.where(@sql)
    else
      @students = Student.first(10)
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
