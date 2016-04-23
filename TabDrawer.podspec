Pod::Spec.new do |s|
  s.name             = "TabDrawer"
  s.version          = "0.1.0"
  s.summary          = "A TabBar UI element that can display a customizable drawer"

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
  s.dependency 'EasyPeasy'
end
