Pod::Spec.new do |spec|

  spec.name         = "BetterWay"
  spec.version      = "0.0.1"
  spec.summary      = "A tool to find issues in roads."


  spec.homepage     = "http://EXAMPLE/BetterWay"

  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "BrunoImai" => "depenpr57@gmail.com" }

  spec.platform     = :ios, "5.0""

  spec.source       = { :git => "https://github.com/BrunoImai/BetterWayIOS.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"


  spec.requires_arc = true
  
end
