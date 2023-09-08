# frozen_string_literal: true

module Hashremap
  # def self.included(base)
  #   base.extend Hashremap::ClassMethods
  # end

  def remappable
    extend ClassMethods
    include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def traverse_and_update
      puts "Ok"
    end
  end
end

# Include the extension
# ActiveRecord::Base.include Hashremap
ActiveRecord::Base.extend Hashremap
# ActiveSupport.on_load(:active_record) do
#   include Hashremap
# end
