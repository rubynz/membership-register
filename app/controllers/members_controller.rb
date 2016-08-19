class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    respond_with @member
  end

  def new
    @member = Member.new
    respond_with @member
  end

  def edit
    respond_with @member
  end

  def create
    @member = Member.new(member_params)
    @member.save
    respond_with @member
  end

  def update
    @member.update(member_params)
    respond_with @member
  end

private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:full_name, :email, :address)
  end
end
