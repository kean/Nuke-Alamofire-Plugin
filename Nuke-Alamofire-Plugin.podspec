Pod::Spec.new do |s|
    s.name             = "Nuke-Alamofire-Plugin"
    s.version          = "0.1.0"
    s.summary          = "Alamofire plugin for Nuke - image managing framework"

    s.homepage         = "https://github.com/kean/Nuke-Alamofire-Plugin"
    s.license          = "MIT"
    s.author           = "Alexander Grebenyuk"
    s.source           = { :git => "https://github.com/kean/Nuke-Alamofire-Plugin", :tag => s.version.to_s }
    s.social_media_url = "https://twitter.com/a_grebenyuk"

    s.module_name      = "NukeAlamofirePlugin"

    s.ios.deployment_target = "8.0"
    s.watchos.deployment_target = "2.0"
    s.osx.deployment_target = "10.9"

    s.dependency "Nuke/Core"
    s.dependency "Alamofire", "~> 2.0"

    s.source_files  = "Source/**/*"
end
