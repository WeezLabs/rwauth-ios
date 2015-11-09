Pod::Spec.new do |s|
  s.name = "RWAuth"
  s.version = "0.1.0"
  s.license = 'MIT'
  s.summary = "Auth library written in swift"
  
  s.homepage = 'https://github.com/WeezLabs/rwauth-ios'
  s.authors = 'Weezlabs'
  
  s.source = { :git => 'https://github.com/WeezLabs/rwauth-ios.git', :tag => s.version }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Source/*.swift'