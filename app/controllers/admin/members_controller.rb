module Admin
  class MembersController < ::MembersController
    http_basic_authenticate_with MembershipRegister.basic_auth_options

    def index
      @members = Member.all.order(joined_at: :desc)
    end

  private

    def token_valid?
      true
    end

  end
end
