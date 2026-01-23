RSpec.describe MembershipApplication do
  subject {
    described_class.new(
      full_name: "John Doe",
      email: "john.doe@example.com",
      phone: "02X 000 0000"
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "full_name" do
      it "must be present" do
        subject.full_name = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:full_name]).to include("can't be blank")
      end

      it "must be unique (case insensitive)" do
        described_class.create!(full_name: "John Doe", email: "other@example.com", phone: "02X 000 0001")
        expect(subject).not_to be_valid
        expect(subject.errors[:full_name]).to include(I18n.t("errors.messages.already_registered"))
      end
    end

    describe "email" do
      it "must be present" do
        subject.email = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("can't be blank")
      end

      it "must be unique (case insensitive)" do
        described_class.create!(full_name: "Jane Doe", email: "john.doe@example.com", phone: "02X 000 0001")
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include(I18n.t("errors.messages.already_registered"))
      end

      it "must be a valid format" do
        subject.email = "invalid_email"
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include(I18n.t("errors.attributes.email.invalid"))
      end
    end

    describe "phone" do
      it "must be present" do
        subject.phone = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:phone]).to include("can't be blank")
      end
    end
  end
end
