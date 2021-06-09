# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def movies_pods
  pod 'SVProgressHUD'
  pod 'Moya'
end

target 'GNBTrades' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GNBTrades
  movies_pods

  target 'GNBTradesTests' do
    inherit! :search_paths
    # Pods for testing
    movies_pods
  end

  target 'GNBTradesUITests' do
    # Pods for testing
    movies_pods
  end

end
