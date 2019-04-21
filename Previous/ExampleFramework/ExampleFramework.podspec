Pod::Spec.new do |s|
  s.name = 'ExampleFramework'
  s.version = '1.0.0'
  s.summary = 'This is an example of a cross-platform Swift framework!'
  s.source = { :git => '[REPO URL]', :tag => s.version }
  s.authors = '[NAME / COMPANY NAME]'
  s.license = 'Copyright'
  s.homepage = '[WEBSITE URL]'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Framework/**/*.swift'
  s.dependency 'Alamofire', '3.1.1'
  s.dependency 'AlamofireImage', '~> 2.2.0'
end
