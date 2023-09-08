# frozen_string_literal: true

module Hashremap
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend Hashremap::ClassMethods
  end

  def prova
    puts "prova"
  end

  module ClassMethods
    def remappable
      puts "Ok"
    end
  end
end

# Include the extension
# ActiveRecord::Base.include Hashremap
ActiveSupport.on_load(:active_record) do
  include Hashremap
end
