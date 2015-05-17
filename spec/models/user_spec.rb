require 'spec_helper'

describe User do

  let(:valid_attributes) {
    {
        first_name: "Frizky",
        last_name: "Kramer",
        email: "frizkykramer@gmail.com",
        password: "test",
        password_confirmation: "test"
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes)}

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insesnsitive)" do
      user.email = "FRIZKYKRAMER@GMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email address to look like an email" do
      user.email = "jason"
      expect(user).to_not be_valid
    end

  end

  describe "#downcase_email" do
    it "makes the email attributes lower case" do
      user = User.new(valid_attributes.merge(email: "FRIZKYKRAMER@GMAIL.COM"))
      #user.downcase_email
      #expect(user.email).to eq("frizkykramer@gmail.com")
      expect{ user.downcase_email }.to change{ user.email }.
                                           from("FRIZKYKRAMER@GMAIL.COM").
                                           to("frizkykramer@gmail.com")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "FRIZKYKRAMER@GMAIL.COM"
      expect(user.save).to be_true
      expect(user.email).to eq("frizkykramer@gmail.com")
    end
  end

end
