Pod::Spec.new do |s|
  s.name         = "JBAudioPlayerView"
  s.version      = "1.0.1"
  s.summary      = "Simple view component for playing audio files in iOS. Suitable for usage in UITableView and UICollectionView."
  s.homepage     = "https://github.com/josipbernat/JBAudioPlayerView"
  s.screenshots  = "https://cloud.githubusercontent.com/assets/2537227/5857444/204ac438-a24c-11e4-95e7-75aa4981d351.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             	= { "Josip Bernat" => "josip.bernat@gmail.com" }
  s.social_media_url	= "http://twitter.com/josipbernat"
  s.platform     		= :ios, "7.0"
  s.source       	= { :git => "https://github.com/josipbernat/JBAudioPlayerView.git", :tag => "v1.0.1 }
  s.source_files  	= 'JBAudioPlayerView/JBAudioPlayerView/**/*.{h,m,png}'
  s.resource_bundles = {'Assets' => ['JBAudioPlayerView/JBAudioPlayerView/Assets/*']}
  s.requires_arc 	= true 
  s.dependency 		"PureLayout"
end
