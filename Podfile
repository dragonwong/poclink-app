# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'poclink-app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for poclink-app
  pod 'AFNetworking'
  pod 'MJExtension', '~> 3.0.13'
  pod 'YYKit'
  pod 'MMKV'
  pod 'GoogleSignIn'
  pod 'CocoaAsyncSocket'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
