module V1
  class DoctorsController < ApplicationController
    before_action :require_admin, except: %i[index]
    before_action :category, only: %i[show update destroy]

    def index
      @doctors = User.all.where(isDoctor: true).order(name: :desc)
      json_response(@doctors)
    end

    def create
      @doctor = Doctor.create!(doctor_params)
      json_response(@doctor, :created) if @doctor.save!
    end

    def update
      @doctor.update!(doctor_params)
      json_response(@doctor)
    end

    def destroy
      @doctor.destroy
      head :no_content
    end

    private

    def doctor_params
      params.permit(:user_id)
    end

    def require_admin
      raise(ExceptionHandler::InvalidToken, Message.no_admin) unless current_user.admin
    end
  end
end