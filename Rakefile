require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require 'yaml'
require 'plist'

config_file = 'config.yml'

workflow_home = File.expand_path("~/Library/Application Support/Alfred 2/Alfred.alfredpreferences/workflows")

$config = YAML.load_file(config_file)
$config["bundleid"] = "#{$config["domain"]}.#{$config["id"]}"
$config["plist"] = File.join($config["path"], "info.plist")
$config["workflow_dbx"] = File.join(File.expand_path($config["dropbox"]), "/Alfred.alfredpreferences/workflows")

# import sub-rakefiles
FileList['*/Rakefile'].each { |file|
  import file
}

desc "Update config"
task :config do
  modified = false

  info = Plist::parse_xml($config["plist"])

  if info['bundleid'] != $config["bundleid"]
    info['bundleid'] = $config["bundleid"]
    modified = true
  end
  if info['createdby'] != $config["created_by"]
    info['createdby'] = $config["created_by"]
    modified = true
  end
  if info['description'] != $config["description"]
    info['description'] = $config["description"]
    modified = true
  end
  if info['name'] != $config["name"]
    info['name'] = $config["name"]
    modified = true
  end
  if info['webaddress'] != $config["website"]
    info['webaddress'] = $config["website"]
    modified = true
  end
  if info['readme'] != $config["readme"]
    info['readme'] = $config["readme"]
    modified = true
  end

  if modified == true
    File.open($config["plist"], "wb") { |file| file.write(info.to_plist) }
  end
end

task :chdir => [:config] do
  chdir $config['path']
end

desc "Install Gems"
task "bundle:install" => [:chdir] do
  sh %Q{/usr/bin/bundle install --standalone --clean} do |ok, res|
    if !ok
      puts "fail to install gems (status = #{res.exitstatus})"
    end
  end
end

desc "Update Gems"
task "bundle:update" => [:chdir] do
  sh %Q{/usr/bin/bundle update && /usr/bin/bundle install --standalone --clean} do |ok, res|
    if !ok
      puts "fail to update gems (status = #{res.exitstatus})"
    end
  end
end

desc "Install to Alfred"
task :install => [:config] do
  ln_sf File.expand_path($config["path"]), File.join(workflow_home, $config["bundleid"])
end

desc "Unlink from Alfred"
task :uninstall => [:config] do
  rm File.join(workflow_home, $config["bundleid"])
end

desc "Install to Dropbox"
task :dbxinstall => [:config] do
  ln_sf File.expand_path($config["path"]), File.join($config["workflow_dbx"], $config["bundleid"])
end

desc "Unlink from Dropbox"
task :dbxuninstall => [:config] do
  rm File.join($config["workflow_dbx"], $config["bundleid"])
end

desc "Clean up all the extras"
task :clean => [:config] do
end

desc "Remove any generated file"
task :clobber => [:clean] do
  rmtree File.join($config["path"], ".bundle")
  rmtree File.join($config["path"], "bundle")
end

desc "Create packed Workflow"
task :export => [:config] do
  file = "#{$config['id']}.alfredworkflow"
  output = 'output'

  FileUtils.rm file if File.exists? file
  FileUtils.rmtree output if File.exists? output

  FileUtils.cp_r $config['path'], output
  chdir output

  # clean up workflow files for export
  Dir.foreach('.') do |file|
    FileUtils.rmtree file if %w(Gemfile Gemfile.lock .bundle config.yml).include? file
  end
  Dir.chdir('bundle/ruby/2.0.0') do
    Dir.foreach('.') do |dir|
      FileUtils.rmtree dir if %w(build_info cache doc specifications).include? dir
    end
    Dir.chdir('gems') do
      Dir.foreach('.') do |dir|
        next if dir == '.' || dir == '..'
        Dir.chdir(dir) do
          Dir.foreach('.') do |subdir|
            next if dir == '.' || dir == '..'
            FileUtils.rmtree subdir if !(%w(. .. lib).include? subdir)
          end
        end
      end
    end
  end

  `/usr/bin/zip -r ../#{file} *`

  chdir('..')
  FileUtils.rmtree output

  puts 'Workflow exported to project directory'
end