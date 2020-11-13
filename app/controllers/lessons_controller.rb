class LessonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    def index
        @lessons = current_user.lessons
    end

    def show
        
    end

    def new
        @lesson = Lesson.new
    end

    def create
        @lesson = Lesson.new(lesson_params)
        if @lesson.save
            redirect_to lesson_path(@lesson)
        else
            render :new
        end
    end

    def edit
        
    end

    def update
        if @lesson.update(lesson_params)
            redirect_to lesson_path(@lesson)
        else
            render :edit
        end
    end

    def destroy
        @lesson.destroy
        redirect_to lesson_path
    end


    private

    def set_lesson
        @lesson = current_user.lessons.find(params[:id])
    end

    def lesson_params
        params.require(:lesson).permit(:location, :start_time, :end_time, :teacher_id, :student_id)
    end
end
