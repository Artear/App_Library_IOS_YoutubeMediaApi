Pod::Spec.new do |s|
s.name             = 'YoutubeMediaApi'
s.version          = '0.1.1'
s.summary          = 'A Elegant Swift library for obtain Metadata of Youtube videos.'

s.description      = <<-DESC

A Elegant Swift library for obtain Metadata of Youtube videos.

DESC

s.homepage         = 'https://github.com/Artear/App_Library_IOS_YoutubeMediaApi'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Maro90' => 'mauro.d.gonzalez90@gmail.com' }
s.source           = { :git => 'https://github.com/Artear/App_Library_IOS_YoutubeMediaApi.git', :tag => s.version }

s.ios.deployment_target = '8.0'

s.source_files = 'YoutubeMediaApi/Classes/**/*'

s.dependency 'PromiseKit', '~> 4.4'
s.dependency 'PromiseKit/Alamofire'
end
