require 'spec_helper'

describe User do
  before do
    @user = User.new(
      username: "exampleusername",
      name: "Example Name",
      email: "user@example.com"
    )
  end

  subject { @user }

  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "responds to properties" do
    expect(@user).to respond_to(:username)
    expect(@user).to respond_to(:name)
    expect(@user).to respond_to(:email)
    expect(@user).to respond_to(:remember_token)
  end

  it "is invalid without username" do
    @user.username = " "
    expect(@user).not_to be_valid
  end

  it "is valid without name" do
    @user.name = " "
    expect(@user).to be_valid
  end

  it "is invalid without email" do
    @user.email = " "
    expect(@user).not_to be_valid
  end

  context "with invalid email format" do
    it "is invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "with valid email format" do
    it "is valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it "is not valid " do
      expect(@user).not_to be_valid
    end

    context "even with upcase email" do
      before do
        user_with_same_upcase_email = @user.dup
        user_with_same_upcase_email.email = @user.email.upcase
        user_with_same_upcase_email.save
      end

      it "is not valid " do
        expect(@user).not_to be_valid
      end
    end
  end

  context "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.email = "user2@example.com"
      user_with_same_username.save
    end

    it "is not valid " do
      expect(@user).not_to be_valid
    end

    context "even with upcase email" do
      before do
        user_with_same_upcase_username = @user.dup
        user_with_same_upcase_username.email = "user2@example.com"
        user_with_same_upcase_username.username = @user.username.upcase
        user_with_same_upcase_username.save
      end

      it "is not valid " do
        expect(@user).not_to be_valid
      end
    end
  end

  context "remember_token" do
    before { @user.save }
    it "it is not valid when blank" do
      expect(@user.remember_token).not_to be_blank
    end
  end



end
