class EvaluationsController < ApplicationController
  before_filter :require_login, :only => [:create, :update, :delete, :new, :edit]
  # GET /evaluations
  # GET /evaluations.json
  def index
    if params[:student_id]
      if params[:semestr]
        @student = Student.find(params[:student_id])
        @evaluations = @student.evaluations.where(:semestr => params[:semestr])
      else                                                # в случае обработки вложенного маршрута
        @student = Student.find(params[:student_id])
        @evaluations = @student.evaluations
      end                                                 # получаем оценки для студента с params[:student_id]
      
    else
      @evaluations = Evaluation.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @evaluations }
    end
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/new
  # GET /evaluations/new.json
  def new
    @evaluation = Evaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/1/edit
  def edit
    @evaluation = Evaluation.find(params[:id])
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(params[:evaluation])

    respond_to do |format|
      if @evaluation.save       # в случае удачного сохранения оценки вызываем метод, который вычисляет средний
        Evaluation.gpa_for_student(@evaluation.student_id)  # балл и записывает в таблицу студенты
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully created.' }
        format.json { render json: @evaluation, status: :created, location: @evaluation }
      else
        format.html { render action: "new" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.json
  def update
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation = Evaluation.find(params[:id])
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to evaluations_url }
      format.json { head :no_content }
    end
  end
end
