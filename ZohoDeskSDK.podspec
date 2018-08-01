Pod::Spec.new do |spec|
spec.name          = 'ZohoDeskSDK'
spec.version       = '0.0.7'
spec.license       = { :type => 'MIT' }
spec.homepage      = 'https://desk.zoho.com'
spec.authors       = { 'Rajeshkumar Lingavel' => 'rajeshkumar.l@zohocorp.com' }
spec.summary       = 'iOS API Provoider for Desk'
spec.source        = { :git => 'https://github.com/zoho/Desk-iOSSDK.git', :tag => spec.version }
spec.platform = :ios, "9.0"
spec.social_media_url = 'https://twitter.com/zoho'	
spec.documentation_url = 'https://www.zoho.com/desk/developers/mobilesdk/ios'

spec.source_files   = 'native/**/*.{swift,h,plist}'
spec.framework      = 'SystemConfiguration'
end
