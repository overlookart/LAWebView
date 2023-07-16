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
    case progress
    case canGoBack
    case canGoForward
    
    var keyStr: String {
        switch self {
        case .title: return "title"
        case .progress: return "estimatedProgress"
        case .canGoBack: return "canGoBack"
        case.canGoForward: return "canGoForward"
        }
    }
}

class BaseWebView: WKWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var webTitle: ((String) -> Void)?
    private var webProgress: ((Float) -> Void)?
    private var webCanGoBack: ((Bool) -> Void)?
    private var webCanGoForward: ((Bool) -> Void)?
    
    var webObserves: (Title:((String) -> Void)?, Progress:((Float) -> Void)?, CanGoBack:((Bool) -> Void)?, CanGoForward:((Bool) -> Void)?)? {
        didSet {
            
            if let webtitle = webObserves?.Title {
                if let _ = webTitle {
                    self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
                }
                webTitle = webtitle
                self.addObserver(self, forKeyPath: WebObserve.title.keyStr, options: .new, context: nil)
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == WebObserve.progress.keyStr {
            if webProgress != nil {
                webProgress!(Float(self.estimatedProgress))
            }
        }else if keyPath == WebObserve.title.keyStr {
            if webTitle != nil {
                webTitle!(self.title ?? "Null")
            }
        }else if keyPath == WebObserve.canGoBack.keyStr {
            if webCanGoBack != nil {
                webCanGoBack!(self.canGoBack)
            }
        }else if keyPath == WebObserve.canGoForward.keyStr {
            if webCanGoForward != nil {
                webCanGoForward!(self.canGoForward)
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let _ = webProgress {
            self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
        }
        
        if let _ = webTitle {
            self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
        }
        
        if let _ = webCanGoBack {
            self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
        }
        
        if let _ = webCanGoForward {
            self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
        }
    }
    
}




