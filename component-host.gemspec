# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'component_host'
  s.version = '0.0.0.1'
  s.summary = 'Component Host'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'developers@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/component-host'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'
  s.bindir = 'bin'

  s.add_runtime_dependency 'casing'
  s.add_runtime_dependency 'log'
  s.add_runtime_dependency 'ntl-actor', '>= 1.0.0.pre1'
  s.add_runtime_dependency 'virtual'
end
