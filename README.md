# Alfred 2 Workflow Ruby Template

A template for Ruby-based Alfred 2 workflow development.

## Example Projects

* [alfred2-top-workflow]( https://github.com/zhaocai/alfred2-top-workflow )
* [alfred2-google-workflow]( https://github.com/zhaocai/alfred2-google-workflow )


## Main features:

* Use standard [bundler][gembundler] to easily package, manage, and update ruby gems in the workflow.
* Friendly exception and debug output to the Mac OS X Console
* Automate rescue feedback items to alfred when something goes wrong.

> Alfred workflow and feedback related functions are located in a separate [alfred-workflow gem]( https://github.com/zhaocai/alfred-workflow ) which can be easily installed by adding `gem "alfred-workflow"` in the Gemfile.

* Functions for smart case query filter of feedback results.
* Functions for finding the bundle ID, cache and storage paths, and query arguments.
* Functions for reading and writing plist files.
* Functions to simplify generating feedback XML for Alfred.
* Functions to simplify saving and retrieving settings.


## Quick Example

```ruby
require 'rubygems' unless defined? Gem
require "bundle/bundler/setup"
require "alfred"

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  fb.add_file_item(File.expand_path "~/Applications/")

  puts fb.to_alfred(ARGV)
end
```

Main code are wrapped in `Alfred.with_friendly_error` block. Exceptions and debug messages are logged to Console log file **~/Library/Logs/Alfred-Workflow.log**.

One more example with rescue feedback automatically generated!

```ruby
require 'rubygems' unless defined? Gem
require "bundle/bundler/setup"
require "alfred"

def my_code_with_something_goes_wrong
  true
end

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true

  fb = alfred.feedback

  if my_code_with_something_goes_wrong
    raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  end
end
```

![rescue feedback](https://raw.github.com/zhaocai/alfred2-ruby-template/master/screenshots/rescue%20feedback.png)



## Quick Start Guide

You may directly download the [alfred2-ruby-template]( https://github.com/zhaocai/alfred2-ruby-template/raw/master/alfred2-ruby-template.alfredworkflow ) here, install, and play with the keywords: `test feedback` and `test rescue feedback`.

### Step 1: Clone or Fork

Clone or fork this repo to your local directory: 

`git clone https://github.com/zhaocai/alfred2-ruby-template.git`

### Step 2: Config.yml
Update **domain** and **id** in the `config.yml` file.

```yaml
# bundle_id = "domain.id"
# path is the relative path to the workflow in the project root
---
path: workflow
domain: your.domain
id: alfred2-ruby-template
```

### Step 3: Install
`[sudo] gem install plist` if you have not installed the **plist** gem.

Run `rake install` to install the workflow. Now you can see the workflow loaded in the
Alfred workflow interface.

### Step 4: Add Ruby Gems

Edit **workflow/Gemfile**. Add some gems.

```ruby
source "https://rubygems.org"

gem "plist"
gem "logging"
gem "alfred-workflow"
```

Run `rake bundle:install` to pull the gems into **workflow/bundle/** folder.

### Step 5: Your Code

Now you are good to add your own code based on the previous example.


## Troubleshooting

1. System bundler version is too old.

`sudo gem install bundler`



## Reference

* [alfred2-ruby-framework]( https://github.com/canadaduane/alfred2-ruby-framework )

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
