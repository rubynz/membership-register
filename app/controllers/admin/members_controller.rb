require "csv"

module Admin
  class MembersController < ::MembersController
    http_basic_authenticate_with(
      name: ENV.fetch("AUTH_NAME") { "secretary" },
      password: ENV.fetch("AUTH_PASSWORD") {
        Rails.logger.info("You have not set a password for the admin area")
        SecureRandom.hex
      }
    )

    def index
      @members = Member.all.order(updated_at: :desc)

      respond_to do |format|
        format.html
        format.csv do
          csv_content = CSV.generate(headers: true) do |csv|
            csv << Member::EXPORTABLE_FIELDS

            @members.pluck(*Member::EXPORTABLE_FIELDS).each { |member| csv << member }
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
      params.require(:member).permit(:full_name, :email, :phone, :joined_at)
    end

  end
end
