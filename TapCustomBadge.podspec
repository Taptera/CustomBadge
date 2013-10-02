Pod::Spec.new do |s|
  s.name     = 'TapCustomBadge'
  s.version  = '2.0.1'
  s.license  = '(custom, see https://github.com/ckteebe/CustomBadge/blob/master/README)'
  s.summary  = 'Draws a typical iOS badge indicator with a custom text on any view.'
  s.homepage = 'https://github.com/Taptera/CustomBadge.git'
  s.author   = { 'Sascha Paulus' => 'open@spaulus.com' }
  s.source   = { :git => 'https://github.com/Taptera/CustomBadge.git', :tag => "v#{s.version}" }
  s.platform = :ios

  s.source_files = 'Classes/CustomBadge.{h,m}'

end
