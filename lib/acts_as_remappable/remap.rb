# frozen_string_literal: true

module ActsAsRemappable
  class Hashremap
    # list of columns that will be ignored on updates
    STOP_WORDS = %i[id created_at updated_at].freeze

    def initialize(object)
      @ar_object = object
    end

    def traverse_and_update(hash)
      hash.each do |key, value|
        if object_column_names.include?(key.to_s)
          update_column(key, value)
        elsif object_associations.include?(key.to_sym) && value.is_a?(Array)
          value.each do |hsh|
            association = @ar_object.public_send(key).find(hsh['id'])
            ActsAsRemappable::Hashremap.new(association).traverse_and_update(hsh)
          end
        else
          raise(UnrecognizedTableColumnError, "cannot find column #{key} on #{@ar_object.class} class")
        end
      end
    end

    private

    def object_column_names
      @ar_object.class.column_names
    end

    def object_associations
      @ar_object.class.reflect_on_all_associations.map(&:name)
    end

    def update_column(column_name, value)
      return false if STOP_WORDS.include?(column_name.to_sym)

      # puts "#{model.class}-#{model.id}.public_send(#{column_name}=, #{value})"
      @ar_object.public_send("#{column_name}=", value)
    end
  end
end
