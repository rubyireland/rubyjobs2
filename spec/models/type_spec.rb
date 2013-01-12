describe Type do
	describe "validations" do
		it "is valid with valid attributes" do
			Factory.build(:type).should be_valid
		end
		
		it { should validate_presence_of(:name) }
	end
end
