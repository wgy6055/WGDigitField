#
# Be sure to run `pod lib lint WGDigitField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WGDigitField'
  s.version          = '0.1.0'
  s.summary          = 'A customizable digit input field.'

  s.description      = <<-DESC
To make sure user inputing security code with a smooth experience, this pod will help you initializing a customized digit field with very short codes.
                       DESC

  s.homepage         = 'https://github.com/wgy6055/WGDigitField'
  s.screenshots      = 'https://s1.ax1x.com/2018/10/19/iwvqAS.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '王冠宇' => 'wangguanyu@mobike.com' }
  s.source           = { :git => 'https://github.com/wgy6055/WGDigitField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WGDigitField/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WGDigitField' => ['WGDigitField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Masonry'
end
