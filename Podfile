# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

target 'Zvatada' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Zvatada
 	pod 'FirebaseAnalytics'
 	pod 'FirebaseAuth'
 	pod 'FirebaseFirestore'
	pod 'Alamofire'
	pod 'IQKeyboardManagerSwift'
	pod 'BottomPopup'
 	pod 'FirebaseMessaging'
	pod 'ReachabilitySwift'
 	pod 'AlamofireImage'
 	pod 'SwiftyJSON'
	#pod 'Kingfisher'
	pod 'SVProgressHUD'
	pod 'SkeletonView'
	pod 'OpalImagePicker', '~> 2.1.0'
	pod 'SideMenu'
	pod 'Toast-Swift'
	pod "FlagPhoneNumber"
	pod "ViewAnimator"
	pod 'OpalImagePicker', '~> 2.1.0'
	pod 'SSToastMessage', '~> 1.0.0'
	#pod 'GoogleMaps', '7.2.0'



end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

