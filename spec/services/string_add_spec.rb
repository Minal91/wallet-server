require 'rails_helper'
RSpec.describe StringAdd, type: :service do
    describe ".add" do
        it "returns 0 for empty string" do
            expect(StringAdd.add("")).to eq(0)
        end

        it "returns the number for a single number string" do
            expect(StringAdd.add("1")).to eq(1)
            expect(StringAdd.add("1, 0")).to eq(1)
        end

        it "handle new lines between numbers" do
            expect(StringAdd.add("1\n2,3")).to eq(6)
            expect(StringAdd.add("1\n2,3\n4")).to eq(10)
            expect(StringAdd.add("1\n2,3\n4\n5")).to eq(15)
        end

        # it "returns the sum for two number strings" do
        #     expect(StringAdd.add("1", "5")).to eq("6")
        #     expect(StringAdd.add("5", "1")).to eq("6")
        #     expect(StringAdd.add("1,5", "")).to eq("6")
        #     expect(StringAdd.add("", "1,5")).to eq("6")
        #     expect(StringAdd.add("1,5", "0")).to eq("6")
        # end

    end
end