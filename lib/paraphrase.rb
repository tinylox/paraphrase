require 'paraphrase/version'
require 'paraphrase/errors'
require 'paraphrase/query'

module Paraphrase

  class << self
    attr_reader :mappings
    attr_writer :mapping_class
  end

  self.mapping_class = Query

  def self.register(name, klass=nil, &block)
    @mappings ||= {}

    raise Paraphrase::DuplicateMappingError if mappings[name]

    @mappings[name] = if block_given?
      Class.new(@mapping_class, &block)
    elsif klass.is_a?(Class)
      klass
    end
  end

  def self.[](name)
    mappings[name]
  end
end
