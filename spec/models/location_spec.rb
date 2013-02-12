describe Location do
	describe "validations" do
		it "is valid with valid attributes" do
			build(:location).should be_valid
		end
		
		it { should validate_presence_of(:name) }
	end
end
