class Hash
  def deep_fetch *args, &block
    raise ArgumentError.new("wrong number of arguments (0 for 1..n)") if args.empty?

    value = fetch(args.shift, &block)
    if args.size > 0
      if value.kind_of?(Hash)
        value.deep_fetch(*args, &block)
      elsif value.kind_of?(Array)
        value = value[args.shift]
        if args.size > 0
          value.deep_fetch(*args, &block)
        else
          value
        end
      else
        {}.fetch(args.shift, &block)
      end
    else
      value
    end
  end
end
