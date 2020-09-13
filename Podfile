# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def rxswift
  pod 'RxSwift'
  pod 'NSObject+Rx'
end

def rxcocoa
	pod 'RxCocoa'
end

def rxdatasources
  pod 'RxDataSources'
end

def rxrealm
  pod 'RxRealm'
  pod 'RealmSwift'
end

target 'Domain' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  rxswift
  rxcocoa
  rxdatasources
  rxrealm
  # Pods for Domain

end

target 'Platform' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  rxswift

  # Pods for Platform

end

target 'ProjectNews' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Kingfisher'
  pod 'SVProgressHUD'
  pod 'SnapKit'
  pod 'CRRefresh'
  pod 'RxRealmDataSources'
  pod 'Fuzi'
  # Pods for ProjectNews

  target 'ProjectNewsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ProjectNewsUITests' do
    # Pods for testing
  end

end
