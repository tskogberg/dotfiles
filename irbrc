#!/usr/bin/env ruby

load File.dirname(__FILE__) + '/.rubyrc'
include RubyRC

require "rubygems"

# Fixed-width prompt to avoid issues: https://ruby.social/@henrik/110694557615313865
IRB.conf[:PROMPT][:SIMPLE].merge!(
  PROMPT_I: ">> ",    # Changed from Proc to String
  PROMPT_S: " %l",
  PROMPT_C: " >",
  PROMPT_N: " >",
)
IRB.conf[:PROMPT_MODE] = :SIMPLE
