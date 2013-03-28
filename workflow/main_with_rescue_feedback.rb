#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem
require "bundle/bundler/setup"
require "alfred"


def something_goes_wrong
  true
end

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true

  fb = alfred.feedback

  if something_goes_wrong
    raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  end
end



