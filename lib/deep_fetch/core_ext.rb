class Hash
  def deep_fetch *args, &block
    value = fetch(args.shift, &block)
    if value.kind_of?(Hash) && args.size > 0
      value.deep_fetch(*args, &block)
    elsif value.kind_of?(Array) && args.size > 0
      value = value[args.shift]
      value.deep_fetch(*args, &block)
    else value
    end
  end
end
