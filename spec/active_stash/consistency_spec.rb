require_relative "../support/user"
require_relative "../support/user_inconsistent"
require_relative "../support/user_inconsistent2"
require_relative "../support/migrations/create_users"

RSpec.describe "constistency checks" do
  describe "when no collection exists" do
    it "raises an error" do
      expect { User.collection.info }.to raise_error(ActiveStash::NoCollectionError)
    end
  end

  describe "when the backing collection exists" do
    before(:example) { User.collection.create! }
    after(:example) { User.collection.drop! }

    it "does not raise an error" do
      expect { User.collection.info }.to_not raise_error
    end

    describe "when the backing collection exists but is missing an index" do
      it "raises an error" do
        expect { UserInconsistent.collection(true).info }.to raise_error(ActiveStash::CollectionDivergedError)
        UserInconsistent.collection.drop!
        UserInconsistent.collection.create!
        expect { UserInconsistent.collection(true).info }.to_not raise_error
      end
    end

    describe "when the backing collection exists but has an additional index" do
      it "raises an error" do
        expect { UserInconsistent2.collection(true).info }.to raise_error(ActiveStash::CollectionDivergedError)
      end
    end
  end
end
