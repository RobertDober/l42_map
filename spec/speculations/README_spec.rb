# DO NOT EDIT!!!
# This file was generated from "README.md" with the speculate_about gem, if you modify this file
# one of two bad things will happen
# - your documentation specs are not correct
# - your modifications will be overwritten by the speculate rake task
# YOU HAVE BEEN WARNED
RSpec.describe "README.md" do
  # README.md:22
  context "Polluting the global namespace, or not?" do
    # README.md:25
    require 'l42/map'
    it "the global namespace is **not polluted** (README.md:30)" do
      expect {
      Map
      }.to raise_error(NameError, "uninitialized constant Map")
    end
    it "we can access it inside the namespace (README.md:37)" do
      expect {
      L42::Map
      }.not_to raise_error
    end
  end
  # README.md:50
  context "Setup" do
    # README.md:53
    let(:empty) { L42::Map.new }
    let(:single) { L42::Map.new(a: 1) }
    let(:map) { L42::Map.new(a: 10, b: 20, c: 30) }
    # README.md:59
    context "The OpenStruct API" do
      it "they can be accessed by name (README.md:62)" do
        expect(single.a).to eq(1)
        expect(map.a).to eq(10)
        expect(map.c).to eq(30)
      end
      it "we can use the `[]` syntax (README.md:69)" do
        expect(empty[:a]).to be_nil
        expect(single[:a]).to eq(1)
        expect(map[:b]).to eq(20)
      end
    end
    # README.md:75
    context "Extensions to the OpenStruct API" do
      it "we can use `fetch` (README.md:78)" do
        expect {
        empty.fetch(:a)
        }.to raise_error(KeyError)

        expect(empty.fetch(:a, 42)).to eq(42)
        expect(empty.fetch(:a) { 43 }).to eq(43)

        expect(single.fetch(:a)).to eq(1)
      end
      it "we can merge into new instances (README.md:90)" do
        clone = empty.merge(x: "x")
        expect(clone.x).to eq("x")
        expect(empty).to be_empty
      end
      # README.md:96
      context "`with_default`" do
        # README.md:99
        let(:wd) { L42::Map.new.with_default(42) }
        it "any access will yield 42 (README.md:104)" do
          expect(wd.some_value).to eq(42)
        end
        it "the default value is passed on to clones (README.md:109)" do
          also_wd = wd.merge(a: 43)
          expect(wd.a).to eq(42)
          expect(also_wd.a).to eq(43)
          expect(also_wd.b).to eq(42)
        end
      end
      # README.md:116
      context "`Hash` methods" do
        it "our instance behaves much like a `Hash` (README.md:119)" do
          expect(map.slice(:a, :c)).to eq(L42::Map.new(a: 10, c: 30))

        end
        it "we can remove keys (README.md:127)" do
          expect(map.without(:a, :b)).to eq(L42::Map.new(c: 30))
        end
      end
    end
    # README.md:131
    context "`Enumerable`" do
      it "we can iterate (README.md:134)" do
        result = map.inject(0) { |s, (_k, v)| s + v }
        expect(result).to eq(60)
      end
    end
    # README.md:139
    context "Pattern Matching" do
      it "of course it behaves like a Hash in pattern matching (README.md:142)" do
        map => c:
        expect(c).to eq(30)
        expect {
        map => a:, b:, **nil
        }.to raise_error(NoMatchingPatternError) # sic, it is indeed a PatternMatchingError
      end
    end
  end
end