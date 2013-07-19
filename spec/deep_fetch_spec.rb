require 'minitest/spec'
require 'minitest/autorun'

require File.expand_path('../../lib/deep_fetch', __FILE__)
require 'coveralls'

Coveralls.wear!

describe Hash do
  describe "deep_fetch" do
    describe "must return value" do
      it "from shallow hash" do
        {:foo => :bar}.deep_fetch(:foo).must_equal :bar
      end

      it "from block if key was not found" do
        {:foo => :bar}.deep_fetch(:baz) { :boo } .must_equal :boo
      end

      it "from deep hash" do
        {:foo => {:bar => :baz}}.deep_fetch(:foo, :bar).must_equal :baz
      end

      it "from block if key not found in deep hash" do
        {:foo => {:bar => :baz}}.deep_fetch(:foo, :baz) { :boo } .must_equal :boo
      end

      it "from arrays in deep hash" do
        {:foo => [nil, {:bar => :baz}]}.deep_fetch(:foo, 1, :bar).must_equal :baz
      end

      it "of hash from deep hash" do
        {:foo => {:bar => :baz}}.deep_fetch(:foo).must_equal({:bar => :baz})
      end

      it "of array from deep hash" do
        {:foo => {:bar => [:baz]}}.deep_fetch(:foo, :bar).must_equal [:baz]
      end

      it "of hash from deeper hash" do
        {:foo => {:bar => {:baz => :boo}}}.deep_fetch(:foo, :bar).must_equal({:baz => :boo})
      end

      it "from nested array" do
        {:foo => {:bar => [:baz]}}.deep_fetch(:foo, :bar, 0).must_equal(:baz)
      end

      it "of hash from deeper hash from nested array" do
        {:foo => {:bar => [{:baz => :boo}]}}.deep_fetch(:foo, :bar, 0).must_equal({:baz => :boo})
      end
    end

    describe "must rise KeyError" do
      it "if key not found in hash and no block provided" do
        lambda do
          {:foo => :bar}.deep_fetch(:baz).must_equal
        end.must_raise(KeyError)
      end

      it "if key not found in deep hash and no block provided" do
        lambda do
          {:foo => {:bar => :baz}}.deep_fetch(:foo, :baz)
        end.must_raise(KeyError)
      end

      it "must raise KeyError when deep key does not exist" do
        lambda do
          {:foo => :bar}.deep_fetch(:foo, :foo)
        end.must_raise(KeyError)
      end
    end

    describe "must rise ArgumentError" do
      it "if invoked without arguments" do
        lambda do
          {}.deep_fetch
        end.must_raise(ArgumentError)
      end
    end

    it "must not evaluate a default block when fetching from deep hash" do
      bomb = lambda { raise "BOOM" }
      {:foo => {:bar => :baz}}.deep_fetch(:foo, :bar, &bomb).must_equal :baz
    end
  end
end
