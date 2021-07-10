require "csv"

module Admin
  class MembersController < ::MembersController
    http_basic_authenticate_with MembershipRegister.basic_auth_options

    def index
      @members = Member.all.order(updated_at: :desc)

      respond_to do |format|
        format.html
        format.csv do
          csv_content = CSV.generate(headers: true) do |csv|
            csv << %w[id full_name joined_at email address data created_at updated_at token token_updated_at]

            @members.each do |member|
              csv << [
                member.id,
                member.full_name,
                member.joined_at,
                member.email,
                member.address,
                member.data,
                member.created_at,
                member.updated_at,
                member.token,
                member.token_updated_at
              ]
            end
          end

          send_data csv_content, type: "text/csv"
        end
      end
    end

    def create
      @member = Member.new(member_params)
      @member.save
      respond_with :admin, @member
    end

    def update
      @member.update(member_params)
      respond_with :admin, @member
    end

  private

    def token_valid?
      true
    end

    def member_params
      params.require(:member).permit(:full_name, :email, :address, :joined_at)
    end

  end
end
