Pod::Spec.new do |spec|
 
  # 项目名称	
  spec.name         = "WiFiCamera" 
  # 版本号 与 仓库标签号 对应
  spec.version      = "0.0.1" 
  #iOS最低版本
  spec.platform     = :ios, "10.0"
  # 项目简介 
  spec.summary      = "iOS SDK and Demo for devices designed by Convergence Ltd." 
  # 你的主页
  spec.homepage     = "https://github.com/ConvergenceSoftware/WiFiCamera" 
  # 开源证书
  spec.license      = "MIT" 
  #库维护者和邮箱
  spec.author             = { "kuiZhang98" => "evija98@icloud.com" }
  #仓库地址，不能用SSH地址
  spec.source       = { :git => "https://github.com/ConvergenceSoftware/WiFiCamera.git", :tag => "#{spec.version}" } 
  #pod文件路径
  spec.source_files  = "CVGC", "CVGC/**/*.{h,m}"   
  #引用库
  spec.frameworks = 'UIKit'
  #依赖的非系统的静态库
  spec.vendored_libraries = "CVGC/include/CameraBuffer/*.{a}"
  
end
