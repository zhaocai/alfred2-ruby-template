#!/usr/bin/env ruby
# encoding: utf-8

# Add workflow directory to ruby path
($LOAD_PATH << File.expand_path("..", __FILE__)).uniq!

require "rubygems"
require "bundle/bundler/setup"

require "lib/alfred"

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  fb.add_item({
    :title    => "Just a Test!"         ,
    :subtitle => "feedback item"                     ,
    :arg      => "A test feedback Item" ,
    :valid    => "yes"                  ,
  })

  puts fb.to_xml
end




