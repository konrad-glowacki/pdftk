Gem::Specification.new do |g|
  g.name = 'pdftk'
  g.version = '0.0.1'
  g.date = '2013-01-30'
  g.summary = 'Pdftk library for Rails'
  g.description = 'Pdftk library is used for merging diffrent pdf files.'
  g.authors = ['Konrad Glowacki']
  g.email = 'konrad.glowacki@gmail.com'
  g.homepage = 'https://github.com/webkrak'
  g.files = %w(README.md)
  g.files += Dir.glob("{lib,generators}/**/*")
  g.require_paths = ['lib']
  g.add_dependency('rails')
  g.add_development_dependency('rake')
end
