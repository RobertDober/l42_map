require_relative "./lib/l42/map/version"
Gem::Specification.new do |s|
  s.name        = 'l42_map'
  s.version     = L42::Map::VERSION
  s.date        = '2022-09-10'
  s.summary     = 'Immutable OpenStruct On Steroids'
  s.description = "Immutable OpenStruct On Steroids, it combines Hash's and OpenStruct's semantics"
  s.authors     = ['Robert Dober']
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob('lib/l42/**/*.rb')
  s.homepage    =
    'https://github.com/robertdober/l42_map'
  s.license     = 'Apache-2.0'

  s.required_ruby_version = '>= 3.1.0'

  s.add_development_dependency 'speculate_about', '~> 1.0.2'
end
