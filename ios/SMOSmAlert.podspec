
Pod::Spec.new do |s|
  s.name         = "SMOSmAlert"
  s.version      = "1.0.0"
  s.summary      = "SMOSmAlert"
  s.description  = <<-DESC
                  SMOSmAlert
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/author/SMOSmAlert.git", :tag => "master" }
  s.source_files  = "SMOSmAlert/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  