Pod::Spec.new do |s|

  s.name         = "SHSafekit"
  s.version      = "1.0.1"
  s.ios.deployment_target = '8.0'
  s.summary      = "A delightful setting interface framework."
  s.homepage     = "https://github.com/sunny-token/SafeKit/"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "sunhua" => "sunhua@163.com" }
  s.source       = { :git => "https://github.com/sunny-token/SafeKit.git", :tag => s.version}
  s.requires_arc = false
  s.source_files = "safeKit/**/*.{h,m}"

  s.requires_arc = 'safeKit/ARC/*.{h,m}'

end
