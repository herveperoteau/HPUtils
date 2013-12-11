Pod::Spec.new do |s|
  s.name     = 'HPUtils'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Utils: MD5Digest, ...'
  s.author   = { 'Herve Peroteau' => 'herve.peroteau@gmail.com' }
  s.description = 'Utils: MD5Digest, ...'
  s.platform = :ios
  s.source = { :git => "https://github.com/herveperoteau/HPUtils.git"}
  s.source_files = 'HPUtils'
  s.requires_arc = true
end

