Pod::Spec.new do |s|
 
  # 项目名称	
  s.name         = "WiFiCamera" 
  # 版本号 与 仓库标签号 对应
  s.version      = "1.0.01" 
  #iOS最低版本
  s.platform     = :ios, "10.0"
  # 项目简介 
  s.summary      = "iOS SDK and Demo for devices designed by Convergence Ltd." 
  # 你的主页
  s.homepage     = "https://github.com/ConvergenceSoftware/WiFiCamera" 
  # 开源证书
  s.license      = "MIT" 
  #库维护者和邮箱
  s.author             = { "kuiZhang98" => "evija98@icloud.com" }
  #仓库地址，不能用SSH地址
  s.source       = { :git => "https://github.com/ConvergenceSoftware/WiFiCamera.git", :tag => "#{s.version}" } 
  #pod文件路径
  s.source_files  = "CVGC/*.{h,m}"   
  #引用库
  s.frameworks = 'UIKit'
  #依赖的非系统的静态库
  s.static_framework = true
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  #s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }


end
