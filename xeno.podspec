#
# Be sure to run `pod lib lint xeno.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Xeno'
  s.version          = '0.1.3'
  s.summary          = 'Attract, convert, and keep customers through the power of live response'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Xeno is an online tool designed to help attract, convert, and keep customers through the power of live response.

You can access all of Xeno features for free and for an unlimited time. Only pay to customize Xeno to better reflect your brand in the eyes of your customers.
                       DESC

  s.homepage         = 'https://github.com/xenoapp/ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rémi Delhaye' => 'remi@slaask.com' }
  s.source           = { :git => 'https://github.com/xenoapp/ios-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/xenoapp/ios-sdk'

  s.swift_versions = '4.0'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Xeno/Classes/**/*'

  # s.resource_bundles = {
  #   'xeno' => ['xeno/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
