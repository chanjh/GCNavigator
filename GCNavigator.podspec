
Pod::Spec.new do |s|

  s.name         = "GCNavigator"
  s.version      = "0.1.2"
  s.summary      = "iOS 路由化中间件"
  s.description  = <<-DESC
这是 iOS 路由化中间件
                   DESC

  s.homepage     = "https://github.com/chanjh/GCNavigator"
  s.license      = 'MIT'
  s.author       = { "Gill Chan" => "hi@chanjh.com" }
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/chanjh/GCNavigator.git", :tag => "#{s.version}" }
  s.source_files = 'GCNavigator/**/*'

end
