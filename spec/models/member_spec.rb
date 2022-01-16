RSpec.describe Member do
  subject { Member.new(full_name: "Jonh Doe") }

  it "is valid" do
    expect(subject).to be_valid
  end

  it "sets joined_at" do
    expect { subject.save }.to change { subject.joined_at }
  end

  it "sets token" do
    expect { subject.save }.to change { subject.token }
  end

  it "sets uuid" do
    expect { subject.save }.to change { subject.id }
  end

  it "uses uuid" do
    subject.save!
    expect(subject.reload.id).to match %r[\b.{8}-.{4}-.{4}-.{4}-.{12}]
  end

  it "is valid without full_name" do
    subject.full_name = nil
    expect(subject).to be_valid
  end

  describe "#confirm!" do
    it "sets the last_active_at value of the record to the current time" do
      subject.last_active_at = 3.years.ago

      expect {
        subject.confirm!
      }.to change {
        subject.last_active_at.year
      }.from(3.years.ago.year).to Date.current.year
    end
  end
end
