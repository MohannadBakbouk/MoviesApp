source 'https://github.com/CocoaPods/Specs.git' 
platform :ios, '13.0'
def appPods
   pod 'Kingfisher','7.10.2'
   pod 'SnapKit','5.6.0'
  pod 'SkeletonView','1.30.4'
end

target 'MoviesApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MoviesApp
    appPods
   
  target 'MoviesAppTests' do
    inherit! :search_paths
    # Pods for testing
    appPods
  end

  target 'MoviesAppUITests' do
    # Pods for testing
  end

end
