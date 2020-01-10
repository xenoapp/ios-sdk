//
//  Xeno.swift
//  Xeno
//
//  Created by Rémi Delhaye on 28/03/2019.
//  Copyright © 2019 Ask Technologies, Inc. All rights reserved.
//

import UIKit
import SafariServices

public final class Xeno: NSObject {
    
    // MARK: Public Var
    
    public static let sharedInstance : Xeno = {
        let instance = Xeno()
        return instance
    }()
    
    public var identity : Dictionary<String, String>?
    
    public var apiKey : String = ""
    
    public var containerViewColor =  UIColor.gray
    
    public var brandColorHex : String?
    
    internal override init() {
        self.identity = ["id": UIDevice.current.identifierForVendor!.uuidString, "name": "Unknown", "kind": "lead"]
    }
    
    public func prepare(apiKey: String, identity: Dictionary<String, String>? = nil) {
        self.apiKey = apiKey
        if (identity != nil) {
            self.identity = identity
        }
    }
    
    // MARK: Private Var
    
    private var xenoView : XenoView?
    
    private var containerView : UIView?
    
    private var _chatData : NSData?
    
    // MARK: Public Methods
    
    public func show() {
        
        let url     = URL(string: "https://xeno.app/api/mobile_loader?key=\(self.apiKey)")!
        let session = URLSession(configuration: .default)
        let task    = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            self.brandColorHex = String(data: data, encoding: .utf8)!
            
            DispatchQueue.main.async {
//                UIApplication.shared.statusBarView?.backgroundColor = UIColor(hexString: self.currentStatusBarColorHex!)
                
                if self.xenoView == nil || self.containerView == nil {
                    self.createXenoView()
                }
                
                self.view()?.addSubview(self.containerView!)
                self.containerView?.addSubview(self.xenoView!)
                self.loadXenoView()
            }
            
        };
        
        task.resume()
    }
    
    public func dismiss() {
        
        containerView?.removeFromSuperview()
        xenoView?.removeFromSuperview()
        xenoView = nil
    }
    
    public func reload() {
        
        xenoView?.reload()
        self.loadXenoView()
    }
    
    // MARK: Private Methods
    
    private func createXenoView() {
        
        self.containerView = UIView.init(frame: (CGRect(x: 0, y: 0, width: (self.view()?.bounds.size.width)!, height: (self.view()?.bounds.size.height)!)))
        self.containerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.containerView?.backgroundColor = containerViewColor
        
        xenoView = XenoView.init(frame: (CGRect(x: 0, y: 0, width: (self.view()?.bounds.size.width)!, height: (self.view()?.bounds.size.height)! - 0)))
        xenoView?.setupWebView()
        xenoView?.xenoDelegate = self
    }
    
    private func loadXenoView() {
        var identifyString = ""
        
        if let identity = identity {
            
            identifyString = ",identify: function() {return {"
            
            var optionsString = ""
            
            for (key, value) in (identity) {
                optionsString = optionsString.appending("\(key): \"\(value)\",")
            }
            
            if optionsString.count > 2 {
                optionsString = String(optionsString[..<optionsString.index(optionsString.endIndex, offsetBy: -1)])
            }
            
            identifyString = identifyString.appending(optionsString)
            
            identifyString = identifyString.appending("}}")
        }
        
        xenoView?.loadHTMLString("<!DOCTYPE html><html><head>" +
            "</head><style>.slaask-button { display: none !important; }</style>" +
            
            "<script>" +
            "window._xenoSettings = {key: '\(apiKey)', options: { native_sdk: true }" +
            "\(identifyString),onInit: function(_xeno) {_xeno.on('ready', function(){_xeno.show()});document.getElementById('ios-lds-dual-ring').remove()}};" +
            "</script>" +
            "<script src=\"https://cdn.xeno.app/chat_loader.js\"></script><body><style>.lds-dual-ring {display: inline-block;width: 100%;height: 100%;}.lds-dual-ring:after {content: ' ';display: block;width: 100px;height: 100px;margin: calc(100% - 100px) auto auto auto;border-radius: 50%;border: 5px solid \(brandColorHex!);border-color: \(brandColorHex!) transparent \(brandColorHex!) transparent;animation: lds-dual-ring 1.2s linear infinite;}@keyframes lds-dual-ring {0% {transform: rotate(0deg);}100% {transform: rotate(360deg);}}</style><div id=\"ios-lds-dual-ring\" class=\"lds-dual-ring\"></div></body></html>", baseURL: nil)
        
    }
    
    private func view() -> UIView? {
        
        return topViewController()?.view
    }
    
    internal func topViewController() -> UIViewController? {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return nil
    }
}

// MARK: XENOViewDelegate

extension Xeno : XENOViewDelegate {
    
    func webViewDidFinishLoad() {
    }
    
    
    internal func closeButtonPressed() {
        dismiss()
    }
    
    internal func openLink(url: URL) {
        let svc = SFSafariViewController(url: url)
        self.topViewController()?.present(svc, animated: true, completion: nil)
    }
}

extension UIColor {
    convenience init(hexString: String, alpha:CGFloat? = 1.0) {
        var hexInt: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

