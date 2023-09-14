# frozen_string_literal: true

module ActsAsRemappable
  def acts_as_remappable
    extend ClassMethods
    include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def traverse_and_update(hash)
      # By using a transaction the list of changes (INSERT and UPDATE statements)
      # will be committed in a single atomic operation, or not at all.
      #
      # This has two desirable effects:
      # Other threads or processes will not see an incomplete submission until all queries have terminated.
      # If an exception is raised at any point, the transaction is rolled back, and the exception is re-raised.
      ActiveRecord::Base.transaction do
        ActsAsRemappable::Hashremap.new(self).traverse_and_update(hash)
      end
    end
  end
end

# Include the extension
ActiveRecord::Base.extend ActsAsRemappable
