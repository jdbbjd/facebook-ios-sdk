# Use the --use-libraries switch when pushing or linting this podspec

Pod::Spec.new do |s|

  s.name         = 'FBSDKCoreKit'
  s.version      = '9.2.0'
  s.summary      = 'Official Facebook SDK for iOS to access Facebook Platform core features'

  s.description  = <<-DESC
                   The Facebook SDK for iOS CoreKit framework provides:
                   * App Events (for App Analytics)
                   * Graph API Access and Error Recovery
                   * Working with Access Tokens and User Profiles
                   DESC

  s.homepage     = 'https://developers.facebook.com/docs/ios/'
  s.license      = { type: 'Facebook Platform License', file: 'LICENSE' }
  s.author       = 'Facebook'

  s.platform     = :ios, :tvos
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '10.0'

  s.source       = {
    git: 'https://github.com/facebook/facebook-ios-sdk.git',
    tag: "v#{s.version}"
  }

  s.ios.weak_frameworks = 'Accelerate', 'Accounts', 'AdSupport', 'Social', 'Security', 'StoreKit', 'QuartzCore', 'CoreGraphics', 'UIKit', 'Foundation', 'AudioToolbox'
  s.tvos.weak_frameworks = 'CoreLocation', 'Security', 'QuartzCore', 'CoreGraphics', 'UIKit', 'Foundation', 'AudioToolbox'

  s.default_subspecs = 'Core', 'Basics'
  s.swift_version = '5.0'
  s.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS': '$(inherited) FBSDKCOCOAPODS=1',
    'DEFINES_MODULE': 'YES'
  }
  s.user_target_xcconfig = {'GCC_PREPROCESSOR_DEFINITIONS': '$(inherited) FBSDKCOCOAPODS=1' }
  s.library = 'c++', 'stdc++'

  s.subspec 'Basics' do |ss|
    ss.source_files = 'Sources/FBSDKCoreKit_Basics/**/*.{h,m}'
    ss.private_header_files = 'Sources/FBSDKCoreKit_Basics/**/*+Internal.h'
    ss.library = 'z'
  end

  s.subspec 'Core' do |ss|
    ss.dependency 'FBSDKCoreKit/Basics'
    ss.exclude_files = 'Sources/FBSDKCoreKit_Basics/**/*',
                       'FBSDKCoreKit/FBSDKCoreKit/include/**/*',
                       'FBSDKCoreKit/FBSDKCoreKit/Swift/Exports.swift'
    ss.source_files = 'FBSDKCoreKit/FBSDKCoreKit/**/*.{h,hpp,m,mm,swift}'
    ss.public_header_files = 'FBSDKCoreKit/FBSDKCoreKit/*.h',
                             'FBSDKCoreKit/FBSDKCoreKit/AppEvents/*.h',
                             'FBSDKCoreKit/FBSDKCoreKit/AppLink/*.h',
                             'FBSDKCoreKit/FBSDKCoreKit/AppLink/Resolver/*.h',
                             'FBSDKCoreKit/FBSDKCoreKit/GraphAPI/*.h'
    ss.private_header_files = 'FBSDKCoreKit/FBSDKCoreKit/Internal/**/*.h',
                              'FBSDKCoreKit/FBSDKCoreKit/AppEvents/Internal/**/*.h'
    ss.resource_bundles = { 'FacebookSDKStrings' => ['FacebookSDKStrings.bundle/**/*.strings'] }
    ss.library = 'c++', 'stdc++'
  end
end
