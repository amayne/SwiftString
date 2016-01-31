Pod::Spec.new do |s|
  s.name             = "SwiftString"
  s.version          = "0.2"
  s.summary          = "A lightweight string extension for Swift"

  s.description      = <<-DESC
                        Common methods and String operations for Swift
                       DESC

  s.homepage         = "https://github.com/amayne/SwiftString"
  s.license          = 'MIT'
  s.author           = { "Andrew Mayne" => "andrew@redbricklab.com" }
  s.source           = { :git => "https://github.com/amayne/SwiftString.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/amayne'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SwiftString' => ['Pod/Assets/*.png']
  }
end
