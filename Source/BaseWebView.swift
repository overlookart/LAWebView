//
//  BaseWebView.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/21.
//

import UIKit
import WebKit

// MARK: - webview监听枚举
private enum WebObserve {
    case title
    case url
    case loading
    case progress
    case canGoBack
    case canGoForward
    
    var keyStr: String {
        switch self {
            case .title: return "title"
            case .url: return "URL"
            case .loading: return "loading"
            case .progress: return "estimatedProgress"
            case .canGoBack: return "canGoBack"
            case .canGoForward: return "canGoForward"
        }
    }
}

open class BaseWebView: WKWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var webTitle: ((String) -> Void)?
    private var webUrl: ((URL?) -> Void)?
    private var webLoading: ((Bool) -> Void)?
    private var webProgress: ((Float) -> Void)?
    private var webCanGoBack: ((Bool) -> Void)?
    private var webCanGoForward: ((Bool) -> Void)?
    
    public var webObserves: (Title:((String) -> Void)?, Url:((URL?) -> Void)?, Loading:((Bool) -> Void)?, Progress:((Float) -> Void)?, CanGoBack:((Bool) -> Void)?, CanGoForward:((Bool) -> Void)?)? {
        didSet {
            if let webtitle = webObserves?.Title {
                if let _ = webTitle {
                    self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
                }
                webTitle = webtitle
                self.addObserver(self, forKeyPath: WebObserve.title.keyStr, options: .new, context: nil)
            }
            
            if let weburl = webObserves?.Url {
                if let _ = webUrl {
                    self.removeObserver(self, forKeyPath: WebObserve.url.keyStr)
                }
                webUrl = weburl
                self.addObserver(self, forKeyPath: WebObserve.url.keyStr,options: .new, context: nil)
            }
            
            if let webloading = webObserves?.Loading {
                if let _ = webLoading {
                    self.removeObserver(self, forKeyPath: WebObserve.loading.keyStr)
                }
                webLoading = webloading
                self.addObserver(self, forKeyPath: WebObserve.loading.keyStr, options: .new, context: nil)
            }
            
            if let webprogress = webObserves?.Progress {
                if let _ = webProgress {
                    self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
                }
                webProgress = webprogress
                self.addObserver(self, forKeyPath: WebObserve.progress.keyStr, options: .new, context: nil)
            }
            
            if let webcangoback = webObserves?.CanGoBack {
                if let _ = webCanGoBack {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
                }
                webCanGoBack = webcangoback
                self.addObserver(self, forKeyPath: WebObserve.canGoBack.keyStr, options: .new, context: nil)
            }
            
            if let webcangoforward = webObserves?.CanGoForward {
                if let _ = webCanGoForward {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
                }
                webCanGoForward = webcangoforward
                self.addObserver(self, forKeyPath: WebObserve.canGoForward.keyStr, options: .new, context: nil)
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == WebObserve.progress.keyStr {
            webProgress?(Float(self.estimatedProgress))
        }else if keyPath == WebObserve.title.keyStr {
            webTitle?(self.title ?? "Null")
        }else if keyPath == WebObserve.url.keyStr {
            webUrl?(self.url)
        }else if keyPath == WebObserve.loading.keyStr {
            webLoading?(self.isLoading)
        }else if keyPath == WebObserve.canGoBack.keyStr {
            webCanGoBack?(self.canGoBack)
        }else if keyPath == WebObserve.canGoForward.keyStr {
            webCanGoForward?(self.canGoForward)
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let _ = webProgress {
            self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
        }
        
        if let _ = webTitle {
            self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
        }
        
        if let _ = webUrl {
            self.removeObserver(self, forKeyPath: WebObserve.url.keyStr)
        }
        
        if let _ = webLoading {
            self.removeObserver(self, forKeyPath: WebObserve.loading.keyStr)
        }
        
        if let _ = webCanGoBack {
            self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
        }
        
        if let _ = webCanGoForward {
            self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
        }
    }
    
}




