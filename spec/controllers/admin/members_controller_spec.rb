require "rails_helper"

describe Admin::MembersController do
  context "when user is authenticated" do
    before do
      @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("secretary:password")
    end

    context "when there are no memberships" do
      it "downloads an empty CSV" do
        get :index, format: :csv

        expect(response.body).to eq %[id,full_name,joined_at,email,address,data,created_at,updated_at
]
      end
    end

    context "when there are some memberships" do
      before do
        ["Alice", "Beatrice"].each do |full_name|
          Member.create!(
            full_name: full_name,
            email: %[#{full_name}@example.com].downcase,
            address: "#{full_name} Address",
          )
        end
      end

      it "returns text/csv as the content-type" do
        get :index, format: :csv

        expect(response.content_type).to eq "text/csv"
      end

      it "includes only three lines" do
        get :index, format: :csv

        expect(response.body.lines.size).to eq 3
      end

      it "includes the first member" do
        get :index, format: :csv

        expect(response.body).to match %[.{8}-.{4}-.{4}-.{4}-.{12},Alice,.*,alice@example.com,Alice Address,{},.*,.*]
      end

      it "does not include the token" do
        get :index, format: :csv

        expect(response.body).not_to match %[#{Member.take.token}]
      end

      it "includes the second member" do
        get :index, format: :csv

        expect(response.body).to match %[.{8}-.{4}-.{4}-.{4}-.{12},Beatrice,.*,beatrice@example.com,Beatrice Address,{},.*,.*]
      end
    end
  end
end
