if defined?(PryByebug)
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
end

Pry.prompt = [
  lambda { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
  lambda { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
]
