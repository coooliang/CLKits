#
#  Be sure to run `pod spec lint CLKits.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "CLKits"
  spec.version      = "1.0.0"
  spec.summary      = "CLKit just save your time"
  spec.homepage     = "https://github.com/coooliang/CLKits"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "coooliang"
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/coooliang/CLKits.git", :tag => "#{spec.version}" }
  spec.source_files  = "CLKits/CLKits/CLKits/**/*.{h,m}"
  spec.requires_arc = true
  spec.frameworks = "Foundation","UIKit"
  spec.dependency "AFNetworking", "~> 3.2.1"
  spec.dependency "pop", "~> 1.0.12"


end
