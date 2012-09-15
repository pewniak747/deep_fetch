require_relative '../lib/deep_fetch'
require 'rspec'

describe Hash do
  describe "deep_fetch" do
    it "should return value from hash" do
      {:foo => :bar}.deep_fetch(:foo).should == :bar
    end

    it "should return value from block if key not found" do
      {:foo => :bar}.deep_fetch(:baz) { :boo } .should == :boo
    end

    it "should rise KeyError if no block and key not found" do
      expect do
        {:foo => :bar}.deep_fetch(:baz).should
      end.to raise_error(KeyError)
    end

    it "should fetch from deep hash" do
      {:foo => {:bar => :baz}}.deep_fetch(:foo, :bar).should == :baz
    end

    it "should return value from block if key not found in deep hash" do
      {:foo => {:bar => :baz}}.deep_fetch(:foo, :baz) { :boo } .should == :boo
    end

    it "should raise KeyError if key not found in deep hash and no block" do
      expect do
        {:foo => {:bar => :baz}}.deep_fetch(:foo, :baz)
      end.to raise_error(KeyError)
    end

    it "should return values from arrays in deep hash" do
      {:foo => [nil, {:bar => :baz}]}.deep_fetch(:foo, 1, :bar).should == :baz
    end

    it "should fetch hash from deep hash" do
      {:foo => {:bar => :baz}}.deep_fetch(:foo).should == {:bar => :baz}
    end

    it "should fetch array from deep hash" do
      {:foo => {:bar => [:baz]}}.deep_fetch(:foo, :bar).should == [:baz]
    end

    it "should not evaluate a default block when fetching from deep hash" do
      bomb = ->() { raise "BOOM" }
      expect do
        {:foo => {:bar => :baz}}.deep_fetch(:foo, :bar, &bomb).should == :baz
      end.not_to raise_error
    end
  end
end
