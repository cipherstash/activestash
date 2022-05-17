class User2 < ActiveRecord::Base
  include ActiveStash::Search
  self.table_name = "users2"
  self.collection_name = "activestash_test_#{ENV["ACTIVE_STASH_TEST_COLLECTION_PREFIX"] || ""}_users2"

  stash_index :first_name
  stash_index :dob, :last_name
  stash_index :gender, only: :exact
  stash_index :title, except: [:match, :range]
  stash_index :created_at, :updated_at, except: :range

  stash_match_all :first_name, :last_name, :email
end
