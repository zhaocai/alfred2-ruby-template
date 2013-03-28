#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require "alfred"




Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  # add a file feedback
  fb.add_file_item(File.expand_path "~/Applications/")

  # add an arbitrary feedback
  fb.add_item({
    :uid      => ""                     ,
    :title    => "Just a Test"          ,
    :subtitle => "feedback item"        ,
    :arg      => "A test feedback Item" ,
    :valid    => "yes"                  ,
  })
  
  # add an feedback to test rescue feedback
  fb.add_item({
    :uid          => ""                     ,
    :title        => "Rescue Feedback Test" ,
    :subtitle     => "rescue feedback item" ,
    :arg          => ""                     ,
    :autocomplete => "failed"               ,
    :valid        => "no"                   ,
  })

  if ARGV[0].eql? "failed"
    alfred.with_rescue_feedback = true
    raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  end

  puts fb.to_xml(ARGV)
end



