Pod::Spec.new do |s|
  s.name             = "SwiftString"
  s.version          = "1.0.9"
  s.summary          = "A comprehensive, lightweight string extension for Swift 3"

  s.description      = <<-DESC
                        Common methods and String operations for Swift
                       DESC

  s.homepage         = "https://github.com/iamjono/SwiftString"
  s.license          = 'MIT'
  s.author           = { "Andrew Mayne" => "andrew@redbricklab.com" }
  s.source           = { :git => "https://github.com/iamjono/SwiftString.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
