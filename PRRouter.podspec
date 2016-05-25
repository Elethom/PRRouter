Pod::Spec.new do |s|
  s.name                = "PRRouter"
  s.version             = "0.3"
  s.summary             = "URL router framework for iOS"
  s.homepage            = "https://github.com/Elethom/PRRouter"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "Elethom Hunter" => "elethomhunter@gmail.com" }
  s.social_media_url    = "http://twitter.com/ElethomHunter"
  s.platform            = :ios
  s.source              = { :git => "https://github.com/Elethom/PRRouter.git", :tag => s.version }
  s.source_files        = "Sources/**/*.{h,m}"
  s.public_header_files = "Sources/Classes/PRRouter.h", "Sources/Categories/UIViewController+PRRouter.h"
  s.requires_arc        = true
end
