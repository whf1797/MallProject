source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'

platform :ios, '10.0'

target 'MallProject' do

  pod 'Moya', '~> 14.0.0'
  pod 'Alamofire', '~> 5.4.2'
  # JSON解析工具
  pod 'SwiftyJSON'
  # JSON <-> Model
  pod 'HandyJSON', '~> 5.0.2'
  # 网络图片加载、缓存
  pod 'Kingfisher', '~> 6.2.1'
  # 代码自动布局工具
  pod 'SnapKit', '~> 5.0.0'
  pod 'MJRefresh', '~> 3.1.15.7'   #
  pod 'SwifterSwift', '~> 5.2.0'   # extension
  pod 'SwiftRichString', '~> 3.7.2'    # 富文本
  pod 'IQKeyboardManagerSwift', '~> 6.5.6' # 输入框遮挡
  pod 'JXSegmentedView'
  pod 'LYEmptyView', '~> 1.3.1' # 空白页面占位图
  pod 'MBProgressHUD'
  # 加密
  pod 'CryptoSwift', '~> 1.4.1'

end

# 忽略pods的警告
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
    end
  end
end
