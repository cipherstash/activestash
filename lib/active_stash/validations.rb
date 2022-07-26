module ActiveStash
  module Validations
    class UniquenessValidator < ActiveModel::EachValidator

      # Uniqueness validator for encryped fields.
      #
      # It relies on an exact index being present for the
      # attribute (created by default with `stash_index`)
      #
      def validate_each(record, attribute, value)
        result = record.class.query(attribute => value).first

        if (options[:case_sensitive] && result[attribute] == attribute) || result
          record.errors.add(attribute, options[:message] || "already exists")
        end
      end
    end
  end
end
