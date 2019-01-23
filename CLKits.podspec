#
#  Be sure to run `pod spec lint CLKits.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "CLKits"
  s.version      = "1.0.1"
  s.summary      = "CLKit just save your time"
  s.homepage     = "https://github.com/coooliang/CLKits"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "coooliang"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/coooliang/CLKits.git", :tag => "#{s.version}" }
  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.ios.frameworks = 'AVFoundation', 'UIKit'
  s.default_subspec = 'All'
  
  s.subspec 'All' do |ss|
    ss.source_files = 'Sources/**/*.{h,m}'
    ss.dependency "AFNetworking", "~> 3.2.1"
    ss.dependency "pop", "~> 1.0.12"
  end

  s.subspec 'CLFaster' do |ss|
    ss.dependency 'CLKits/CLFaster'
    ss.source_files = 'CLKits/CLFaster/**/*.{h,m}'
  end

  s.subspec 'CLNetworking' do |ss|
    ss.dependency 'CLKits/CLNetworking'
    ss.source_files = 'CLKits/CLNetworking/**/*.{h,m}'
    ss.dependency "AFNetworking", "~> 3.2.1"
  end

  s.subspec 'CLPopAnimation' do |ss|
    ss.dependency 'CLKits/CLPopAnimation'
    ss.source_files = 'CLKits/CLPopAnimation/**/*.{h,m}'
    ss.dependency "pop", "~> 1.0.12"
  end

end
