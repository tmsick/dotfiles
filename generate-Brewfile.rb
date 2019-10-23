#!/usr/bin/env ruby
# frozen_string_literal: true

brwe_repos = `brew tap`.split("\n")
brew_formulae = `brew list`.split("\n")
cask_formulae = `brew cask list`.split("\n")
mas_apps = `mas list`.split("\n")

brwe_repos.sort.each do |t|
  puts "tap '#{t}'"
end
puts ''
brew_formulae.sort.each do |f|
  puts "brew '#{f}'"
end
puts ''
cask_formulae.sort.each do |f|
  puts "cask '#{f}'"
end
puts ''
mas_apps.map! do |app|
  id, *name = app.split(' ')
  id = id.to_i
  name.pop
  name = name.join(' ')
  [id, name]
end
mas_apps.sort_by { |id, _| id }.each do |id, name|
  puts "mas '#{name}', id: #{id}"
end
