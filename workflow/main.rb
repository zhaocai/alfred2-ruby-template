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
    :title    => "Just a Test!"         ,
    :subtitle => "feedback item"        ,
    :arg      => "A test feedback Item" ,
    :valid    => "yes"                  ,
  })


  puts fb.to_xml
end



