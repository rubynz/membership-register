module Admin
  class MembersController < ::MembersController
    http_basic_authenticate_with MembershipRegister.basic_auth_options

    # GET /members
    # GET /members.json
    def index
      @members = Member.all
    end

  end
end
