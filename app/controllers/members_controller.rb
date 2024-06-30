class MembersController < ApplicationController
  InvalidToken = Class.new(StandardError)
  TOKEN_EXPIRY = 24.hours

  rescue_from InvalidToken, with: :render_token_error

  before_action :set_member, only: [:show, :edit, :update]

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
    @member = MembershipApplication.new(member_params)
    @member.save
    respond_with @member, location: [@member, token: @member.token]
  end

  def update
    @member = @member.becomes(MembershipApplication)
    @member.update(member_params)
    respond_with @member
  end

private

  def set_member
    @member = Member.find(params[:id])
    raise InvalidToken unless token_valid?
  end

  def member_params
    params.require(:member).permit(:full_name, :email, :address)
  end

  def token
    session[:token] = params[:token] || session[:token]
  end

  def token_valid?
    @member.token == token &&
      @member.token_updated_at > TOKEN_EXPIRY.ago
  end

  def render_token_error
    render :token_error
  end
end
