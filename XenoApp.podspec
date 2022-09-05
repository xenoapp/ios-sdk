Pod::Spec.new do |s|
  s.name             = 'XenoApp'
  s.version          = '0.3.0'
  s.summary          = 'Attract, convert, and keep customers through the power of live response'
  s.description      = <<-DESC
Xeno is an online tool designed to help attract, convert, and keep customers through the power of live response.

You can access all of Xeno features for free and for an unlimited time. Only pay to customize Xeno to better reflect your brand in the eyes of your customers.
                       DESC

  s.homepage         = 'https://github.com/xenoapp/ios-sdk'
  s.screenshots      = 'https://s3.amazonaws.com/assets.xenoapp.com/ios-sdk-1.png'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Xeno' => 'contact@xenoapp.com' }
  s.source           = { git: 'https://github.com/xenoapp/ios-sdk.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/xenocares'
  s.swift_version    = '4.0'

  s.ios.deployment_target = '9.0'

  s.source_files = 'XenoApp/Classes/**/*'
end
