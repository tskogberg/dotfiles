#!/usr/bin/env ruby

load File.dirname(__FILE__) + "/.rubyrc"
include RubyRC

require "rubygems"

# Enable lambda prompts. https://gist.github.com/aalin/616586
class IRB::Irb
  alias original_prompt prompt
  def prompt(prompt, ltype, indent, line_no)
    prompt = prompt.call if prompt.respond_to?(:call)
    original_prompt(prompt, ltype, indent, line_no)
  end
end

IRB.conf[:PROMPT][:SIMPLE].merge!(PROMPT_I: lambda {
  PROMPT.call(">>")
})
IRB.conf[:PROMPT][:SIMPLE].merge!(PROMPT_S: lambda {
  PROMPT.call(">>")
})
IRB.conf[:PROMPT][:SIMPLE].merge!(PROMPT_C: lambda {
  PROMPT.call(">>")
})
IRB.conf[:PROMPT_MODE] = :SIMPLE
