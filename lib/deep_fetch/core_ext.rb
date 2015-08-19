class Hash
  def deep_fetch *args, &block
    raise ArgumentError.new("wrong number of arguments (0 for 1..n)") if args.empty?

    value = self

    while args.size > 0
      arg = args.shift

      if value.kind_of?(Hash)
        value = value.fetch(arg, &block)
      elsif value.kind_of?(Array)
        value = value[arg]
      else
        value = {}.fetch(arg, &block)
      end
    end

    value
  end
end
