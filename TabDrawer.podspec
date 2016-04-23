#
# Be sure to run `pod lib lint TabDrawer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TabDrawer"
  s.version          = "0.1.0"
  s.summary          = "A TabBar UI element that can display a customizable drawer"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                    TabDrawer is a UIView subclass that can be used to show a tab bar which can either fire off actions when selected, or display a customizable drawer. 
                       DESC

  s.homepage         = "https://github.com/winslowdibona/TabDrawer"
  s.license          = 'MIT'
  s.author           = { "winslowdibona" => "dibona.winslow@gmail.com" }
  s.source           = { :git => "https://github.com/winslowdibona/TabDrawer.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TabDrawer/Classes/**/*'
  s.resource_bundles = {
    'TabDrawer' => ['TabDrawer/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'EasyPeasy'
end
