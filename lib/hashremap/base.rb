# frozen_string_literal: true

module Hashremap
  extend ActiveSupport::Concern

  module ClassMethods
    def remappable
      puts "Ok"
    end
  end
end

# Include the extension 
ActiveRecord::Base.send(:include, Hashremap)
