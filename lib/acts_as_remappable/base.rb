# frozen_string_literal: true

module ActsAsRemappable
  def acts_as_remappable
    extend ClassMethods
    include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    # @input hash, The current node that is being traversed
    # @input object, The object upon which the Hash' fields are compared and updated
    def traverse_and_update(hash)
      ActsAsRemappable::Hashremap.new(self).traverse_and_update(hash)
    end
  end
end

# Include the extension
ActiveRecord::Base.extend ActsAsRemappable
