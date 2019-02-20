#
#  Be sure to run `pod spec lint CLKits.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "CLKits"
  s.version      = "1.0.3"
  s.summary      = "CLKits framework just save your time. deployment target ios 8.0"
  s.homepage     = "https://github.com/coooliang/CLKits"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "coooliang"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/coooliang/CLKits.git", :tag => "#{s.version}" }
  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.default_subspec = 'All'

  s.subspec 'All' do |all|
    all.source_files = 'Sources/CLFaster/**/*.{h,m}','Sources/CLNetworking/**/*.{h,m}','Sources/CLPopAnimation/**/*.{h,m}','Sources/JKDBModel/**/*.{h,m}','Sources/CLUI/CLHUD/**/*.{h,m}'
    all.dependency "AFNetworking", "~> 3.2.1"
    all.dependency "pop", "~> 1.0.12"
    all.dependency "FMDB", "~> 2.7.5"
    all.dependency "SVProgressHUD", "~> 2.1.2"
    all.dependency "FTIndicator", "~> 1.2.9"
    all.ios.frameworks = 'AVFoundation', 'UIKit'
  end


  s.subspec 'CLFaster' do |ss|
    ss.source_files = 'Sources/CLFaster/**/*.{h,m}'
    ss.ios.frameworks = 'UIKit'
  end

  s.subspec 'CLNetworking' do |ss|
    ss.source_files = 'Sources/CLNetworking/**/*.{h,m}'
    ss.dependency "AFNetworking", "~> 3.2.1"
    ss.ios.frameworks = 'AVFoundation'
  end

  s.subspec 'CLPopAnimation' do |ss|
    ss.source_files = 'Sources/CLPopAnimation/**/*.{h,m}'
    ss.dependency "pop", "~> 1.0.12"
    ss.ios.frameworks = 'UIKit'
  end

  s.subspec 'JKDBModel' do |ss|
    ss.source_files = 'Sources/JKDBModel/**/*.{h,m}'
    ss.dependency "FMDB", "~> 2.7.5"
    ss.ios.frameworks = 'AVFoundation'
  end

  s.subspec 'CLHUD' do |ss|
    ss.source_files = 'Sources/CLUI/CLHUD/**/*.{h,m}'
    ss.dependency "SVProgressHUD", "~> 2.1.2"
    ss.dependency "FTIndicator", "~> 1.2.9"
    ss.ios.frameworks = 'AVFoundation', 'UIKit'
  end

end

# https://blog.csdn.net/coooliang/article/details/84869937

# cd /Users/lion/Documents/CLKits/

# 1.validate
# pod spec lint CLKits.podspec --allow-warnings

# 2.register
# pod trunk register 61917380@qq.com 'Lion' --description='Lion'

# 4.push
# pod trunk push --allow-warnings --use-libraries

# 5.search
# rm ~/Library/Caches/CocoaPods/search_index.json
# pod search CLKits

# PS:
# - ERROR | [CLKits/All,CLKits/JKDBModel] xcodebuild:  CLKits/Sources/JKDBModel/JKDBHelper.h:10:9: error: 'FMDB.h' file not found with <angled> include; use "quotes" instead
# #import "FMDB.h"
