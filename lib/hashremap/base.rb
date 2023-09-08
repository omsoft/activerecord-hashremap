# frozen_string_literal: true

module Hashremap
  # extend ActiveSupport::Concern

  def self.included(base)
    base.extend Hashremap::ClassMethods
  end

  module ClassMethods
    def remappable
      puts "Ok"
    end
  end
end

# Include the extension
ActiveRecord::Base.include Hashremap
