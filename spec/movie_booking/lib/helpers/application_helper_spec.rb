# frozen_string_literal: true

require 'spec_helper'

describe Helpers::ApplicationHelper do
  subject { AnyClass }

  describe '.serialize' do
    let(:collection) { [ValuesClass.new('value1'), ValuesClass.new('value2')] }
    let(:serialized_collection) { [{ key: 'value1' }, { key: 'value2' }] }

    it 'serializes a collection of values with a serializer class' do
      expect(subject.serialize(SomeSerializer, collection))
        .to eq(serialized_collection)
    end
  end
end

class AnyClass
  extend Helpers::ApplicationHelper
end

class SomeSerializer
  class << self
    def call(values)
      values.symbolize_keys
    end
  end
end

class ValuesClass
  def initialize(value)
    @value = value
  end

  def values
    { 'key' => @value }
  end
end
