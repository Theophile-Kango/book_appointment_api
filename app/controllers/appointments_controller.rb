class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  # GET /appointments
  def index
    @appointments = Appointment.all.order(created_at: :desc)
    json_response(@appointments)
  end

  # POST appointment
  def create
    @appointment = current_user.appointments.build(appointment_params)
    json_response(@appointment, :created) if @appointment.save!
  end

  # GET /appointments/:id
  def show
    json_response(@appointment)
  end

  # PUT /appointments/:id
  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  # DELETE /appointments/:id
  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointment_params
    # whitelist params
    params.permit(:date)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
