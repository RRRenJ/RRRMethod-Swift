
Pod::Spec.new do |s|

  s.name         = "RRRMethod-Swift"
  s.version      = "0.0.7"
  s.summary      = "个人使用的swift方法汇集"
  s.description  = <<-DESC
                    个人使用的swift方法汇集
                   DESC
  s.homepage     = "https://github.com/RRRenJ/RRRMethod-Swift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "RRRenJ" => "https://github.com/RRRenJ" }
  s.source       = { :git => "https://github.com/RRRenJ/RRRMethod-Swift.git", :tag => s.version }


  s.source_files  = "RRRMethod-Swift/*.swift"
  s.frameworks   = 'UIKit', 'Foundation'
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'

  


end
