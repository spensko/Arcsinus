# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

target 'Arcsinus' do
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'RealmSwift'
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
            config.build_settings['CLANG_WARN_STRICT_PROTOTYPES'] = 'NO'
        end
    end
end
