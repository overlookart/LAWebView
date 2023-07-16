//
//  WebConfigComponent.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
import WebKit
class WebConfigComponent: WKWebViewConfiguration {
    override init() {
        super.init()
    }
    
    /// 初始化 WebConfig
    /// - Parameters:
    ///   - preferences: 首选项
    ///   - processPool: 进程池
    ///   - userContentController: 内容控制器
    ///   - websiteDataStore: 数据存储
    init(preferences: WKPreferences? = nil, processPool: WKProcessPool? = nil, userContentController: WKUserContentController? = nil, websiteDataStore: WKWebsiteDataStore? = nil) {
        super.init()
        //UserAgent字符串中使用的应用程序名称。
//        self.applicationNameForUserAgent = ""
        
        //Web视图要使用的首选项对象。
        if let pref = preferences {
            self.preferences = pref
        }
        //从中获取视图的Web Content进程的进程池。
        if let proc = processPool {
            self.processPool = proc
        }
        //用户内容控制器，用于与Web视图关联
        if let cter = userContentController {
            self.userContentController = cter
        }
        //Web视图将使用的网站数据存储
        if let webds = websiteDataStore {
            self.websiteDataStore = webds
        }
        
        
        /**
         网页是否可缩放
         一个布尔值，该值确定WKWebView对象是否应始终允许缩放网页
         将此属性设置为TRUE可以缩放网页，而不考虑作者的意图。 ignoresViewportScaleLimits属性将覆盖网页中user-scalable的HTML属性。 默认为FALSE。
         */
        ignoresViewportScaleLimits = false
        
        /**
         设置渲染
         一个布尔值，指示Web视图是否抑制内容渲染，直到将其完全加载到内存中为止
         */
        suppressesIncrementalRendering = false
        
        
        //设置媒体播放
         
        /**
         一个布尔值，指示HTML5视频是内置播放还是使用本机全屏控制器
         您必须设置此属性才能播放嵌入式视频。 将此属性设置为true可以内联播放视频 将此属性设置为false可以使用本机全屏控制器 在iPhone上将视频元素添加到HTML文档时，还必须包括playsinline属性
         iPhone的默认值为false，iPad的默认值为true
         在iOS 10.0之前创建的应用必须使用webkit-playsinline属性
         */
        allowsInlineMediaPlayback = false
        
        /**
         是否允许AirPlay
         */
        allowsAirPlayForMediaPlayback = true
        
        /**
         指示HTML5视频是否可以画中画。
         */
        allowsPictureInPictureMediaPlayback = true
        
        /**
         确定哪些媒体类型需要用户手势才能开始播放
         使用WKAudiovisualMediaTypeNone或 [] 表示不需要用户手势即可开始播放媒体
         .all 所有的都需要
         .audio 音频需要
         .video 视频需要
         */
        mediaTypesRequiringUserActionForPlayback = .all
        
        //设置选中颗粒度
        /**
         用户可以用来在Web视图中交互选择内容的粒度级别
         .character 选择端点可以放置在任何字符边界处
         .dynamic 选择粒度根据选择自动变化
         */
        selectionGranularity = .dynamic
        
        //识别数据类型
        /**
         所需的数据检测类型
         指定dataDetectoryTypes值会将交互性添加到与该值匹配的Web内容中 例如，如果dataDetectorTypes属性设置为WKDataDetectorTypeLink，则Safari在文本“ Visit apple.com”中向“ apple.com”添加链接
         默认值为无。
         
         要指示不执行任何数据检测，请使用一组空的数据检测器类型，由空数组文字[]指示 例如，让myDataDetector：WKDataDetectorTypes = []
         .phoneNumber 电话号码被检测到并变成链接
         .link 检测到文本中的URL，并将其转换为链接
         .address 检测到地址并将其转换为链接
         .calendarEvent 检测到将来的日期和时间并将其转换为链接
         .trackingNumber 检测到跟踪号并将其转换为链接
         .flightNumber 检测航班号并将其转换为链接
         .lookupSuggestion ?
         .all 检测到以上所有数据类型后，它们就会变成链接。 选择此值将自动包括添加到此常量的任何新检测类型
         */
        dataDetectorTypes = .all
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     每个URL方案只能有一个处理程序。 如果为无效的URL方案注册处理程序，或者为URL方案注册处理程序多次，或者为WebKit已经处理的URL方案注册处理程序，则会引发异常。 您可以调用handlesURLScheme（_ :)方法来确定WebKit是否处理特定的URL方案。URL方案不区分大小写。 有效的URL方案必须以ASCII字母开头，并且只能包含ASCII字母，数字，“ +”字符，“-”字符和“。”。 特点
    */
    
    /// 添加 URL Schemes & Handlers
    /// - Parameters:
    ///   - urlSchemeHandler: handler
    ///   - urlScheme: scheme
    override func setURLSchemeHandler(_ urlSchemeHandler: WKURLSchemeHandler?, forURLScheme urlScheme: String) {
        super.setURLSchemeHandler(urlSchemeHandler, forURLScheme: urlScheme)
    }
    
    func addUserScript(script: LAUserScript?) {
        if let s = script {
            self.userContentController.addUserScript(s)
            
        }
    }
}
