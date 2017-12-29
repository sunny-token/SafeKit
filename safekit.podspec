Pod::Spec.new do |s|

  s.name         = "safekit"
  s.version      = "0.0.1"
  s.ios.deployment_target = '7.0'
  s.summary      = "A delightful setting interface framework."
  s.homepage     = "https://github.com/sunny-token/SafeKit/"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "sunhua" => "sunhua@163.com" }
  s.source       = { :git => "https://github.com/sunny-token/SafeKit.git", :tag => s.version}
  s.source_files = "safeKit", "safeKit/*.{h,m}"
end
