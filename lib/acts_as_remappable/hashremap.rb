# frozen_string_literal: true

module ActsAsRemappable
  class Hashremap
    # list of columns that will be ignored on updates
    STOP_WORDS = %i[id created_at updated_at].freeze

    # @input object, The object upon which the Hash keys will be remapped
    def initialize(object)
      @ar_object = object
    end

    # @input hash, The current node that is being traversed
    def traverse_and_update!(hash)
      traverse(hash) do |key, value|
        traverse_and_update_existing_items(key, value)
      end
    end

    # @input hash, The current node that is being traversed
    def traverse_and_create!(hash)
      traverse(hash) do |key, value|
        traverse_and_update_existing_items(key, value)
        traverse_and_create_new_items(key, value)
      end
    end

    private

    def traverse(hash)
      hash.each do |key, value|
        if object_column_names.include?(key.to_s)
          update_column(key, value)
        elsif object_associations.include?(key.to_sym) && value.is_a?(Array)
          yield(key, value)
        else
          raise(UnrecognizedTableColumnError, "cannot find column #{key} on #{@ar_object.class} class")
        end
      end
    end

    def object_column_names
      @ar_object.class.column_names
    end

    def object_associations
      @ar_object.class.reflect_on_all_associations.map(&:name)
    end

    def traverse_and_update_existing_items(key, values)
      values.select { |item| item.with_indifferent_access.key?(:id) }
            .each do |hsh|
              association = @ar_object.public_send(key).find(hsh['id'])
              ActsAsRemappable::Hashremap.new(association).traverse_and_update!(hsh)
            end
    end

    def traverse_and_create_new_items(key, values)
      values.reject { |item| item.with_indifferent_access.key?(:id) }
            .each do |hsh|
              @ar_object.public_send(key) << symbol_to_konst(key).new(hsh)
            end
    end

    def update_column(column_name, value)
      return false if STOP_WORDS.include?(column_name.to_sym)

      @ar_object.public_send("#{column_name}=", value)
      @ar_object.save
    end

    def symbol_to_konst(symbol)
      symbol.to_s.camelize.constantize
    end
  end
end
