Pod::Spec.new do |spec|
spec.name          = 'ZohoDeskSDK'
spec.version       = '0.0.2'
spec.license       = { :type => 'MIT' }
spec.homepage      = 'https://desk.zoho.com'
spec.authors       = { 'Rajeshkumar Lingavel' => 'rajeshkumar.l@zohocorp.com' }
spec.summary       = 'iOS API Provoider for Desk'
spec.source        = { :git => 'https://github.com/zoho/Desk-iOSSDK.git', :tag => spec.version }

spec.ios.deployment_target  = '9.0'

spec.source_files   = 'native/**/*.{swift,h,plist}'
spec.framework      = 'SystemConfiguration'
end


