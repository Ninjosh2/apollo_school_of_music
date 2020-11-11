class StudentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
        @students = current_user.students
    end

    def show
        @student = current_user.students.find(params[:id])
    end

    def new

    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end
end
