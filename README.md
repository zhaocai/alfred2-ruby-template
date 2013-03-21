# Alfred 2 Workflow Ruby Template

A template for Ruby-based Alfred 2 workflow development.

## Main features:

* Use standard [bundler][gembundler] to easily package, manage, and update ruby gems in the workflow.
* Friendly exception and debug output to the Mac OS X Console

Alfred workflow and feedback related function are located in a separate [alfred-workflow gem]( https://github.com/zhaocai/alfred-workflow ) which can be easily installed by adding `gem "alfred-workflow", "~>1.0.4"` in the Gemfile.

* Functions for finding the bundle ID, cache and storage paths, and query arguments.
* Functions for reading and writing plist files.
* Functions to simplify generating feedback XML for Alfred.
* Functions to simplify saving and retrieving settings.


## Quick Example

```ruby
require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require "alfred"

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  fb.add_file_item(File.expand_path "~/Applications/")

  puts fb.to_xml
end
```



## Quick Start Guide

### Step 1: Clone

Clone or fork this repo to your local directory: https://github.com/zhaocai/alfred2-ruby-template.git

### Step 2: Config.yml
Update **domain** and **id** in the `config.yml` file.

```yaml
---
path: workflow
# bundle_id = "domain.id"
domain: your.domain
id: alfred2-ruby-template
```

### Step 3: Install

Run `rake install` to install the workflow. Now you can see the workflow loaded in the
Alfred workflow interface.

### Step 4: Add Ruby Gems

Edit **workflow/Gemfile**. Add some gems.

```ruby
source "https://rubygems.org"

gem "plist"
gem "logging"
gem "alfred-workflow", "~>1.0.4"
```

Run `rake bundle_install` to pull the gems into **workflow/bundle/** folder.

### Step 5: Your Code

Now you are good to add your own code based on the previous example.

## LICENSE:

Copyright (c) 2013 Zhao Cai <caizhaoff@gmail.com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.


[gembundler]: http://gembundler.com/
