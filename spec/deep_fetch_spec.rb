require 'minitest/spec'
require 'minitest/autorun'

require_relative '../lib/deep_fetch'

describe Hash do
  describe "deep_fetch" do
    it "must_equal return value from hash" do
      {:foo => :bar}.deep_fetch(:foo).must_equal :bar
    end

    it "must_equal return value from block if key not found" do
      {:foo => :bar}.deep_fetch(:baz) { :boo } .must_equal :boo
    end

    it "must_equal rise KeyError if no block and key not found" do
      lambda do
        {:foo => :bar}.deep_fetch(:baz).must_equal
      end.must_raise(KeyError)
    end

    it "must_equal fetch from deep hash" do
      {:foo => {:bar => :baz}}.deep_fetch(:foo, :bar).must_equal :baz
    end

    it "must_equal return value from block if key not found in deep hash" do
      {:foo => {:bar => :baz}}.deep_fetch(:foo, :baz) { :boo } .must_equal :boo
    end

    it "must_equal raise KeyError if key not found in deep hash and no block" do
      lambda do
        {:foo => {:bar => :baz}}.deep_fetch(:foo, :baz)
      end.must_raise(KeyError)
    end

    it "must_equal return values from arrays in deep hash" do
      {:foo => [nil, {:bar => :baz}]}.deep_fetch(:foo, 1, :bar).must_equal :baz
    end

    it "must_equal fetch hash from deep hash" do
      {:foo => {:bar => :baz}}.deep_fetch(:foo).must_equal({:bar => :baz})
    end

    it "must_equal fetch array from deep hash" do
      {:foo => {:bar => [:baz]}}.deep_fetch(:foo, :bar).must_equal [:baz]
    end

    it "must_equal fetch hash from deeper hash" do
      {:foo => {:bar => {:baz => :boo}}}.deep_fetch(:foo, :bar).must_equal({:baz => :boo})
    end

    it "must_equal not evaluate a default block when fetching from deep hash" do
      bomb = ->() { raise "BOOM" }
      {:foo => {:bar => :baz}}.deep_fetch(:foo, :bar, &bomb).must_equal :baz
    end

    it "must raise ArgumentError if invoked without arguments" do
      lambda do
        {}.deep_fetch
      end.must_raise(ArgumentError)
    end

    it "must raise KeyError when deep key does not exist" do
      lambda do
        {:foo => :bar}.deep_fetch(:foo, :foo)
      end.must_raise(KeyError)
    end
  end
end
