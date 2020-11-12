class TeachersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher, only: [:show, :edit, :update, :destroy]
    def index
        @teachers = Teachers.all
    end
    
    def show
        set_teacher
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

    private

    def set_teacher
        @teacher = Teacher.find(params[:id])
    end

    def teacher_params
        params.require(:teacher).permit(:name, :phone_number, :email, :instrument)
    end
end
