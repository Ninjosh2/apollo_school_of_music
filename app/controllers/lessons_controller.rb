class LessonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    def index
        @student = current_user.students.find_by_id(params[:student_id])
        @teacher = Teacher.find_by_id(params[:teacher_id])
        if @student
            @lessons = @student.lessons
        elsif @teacher
            @lessons = current_user.lessons.by_teacher(@teacher)
        else
            @lessons = current_user.lessons
        end
        filter_options
    end

    def show
        
    end

    def new
        @student = current_user.students.find_by_id(params[:student_id])
        @teacher = Teacher.find_by_id(params[:teacher_id])
        if @student
            @lesson = @student.lessons.build
        elsif @teacher
            @lesson = @teacher.lessons.build
        else
            @lesson = Lesson.new
        end
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

    def filter_options
        if params[:filter_by_time] == "upcoming"
            @lessons = @lessons.upcoming
        elsif params[:filter_by_time] == "past"
            @lessons = @lessons.past
        end
        if params[:sort] == "most_recent"
            @lessons = @lessons.most_recent
        elsif params[:sort] == "longest_ago"
            @lessons = @lessons.longest_ago
        end
    end

    def lesson_params
        params.require(:lesson).permit(:location, :start_time, :end_time, :teacher_id, :student_id)
    end
end
