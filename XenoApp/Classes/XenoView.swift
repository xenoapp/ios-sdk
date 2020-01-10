//
//  XenoView.swift
//  Xeno
//
//  Created by Rémi Delhaye on 28/03/2019.
//  Copyright © 2019 Ask Technologies, Inc. All rights reserved.
//

import UIKit

internal protocol XENOViewDelegate {
    func closeButtonPressed()
    func webViewDidFinishLoad()
    func openLink(url: URL)
}

internal class XenoView: UIWebView {

    internal var xenoDelegate : XENOViewDelegate?

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebView()
    }

    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupWebView()
    }

    internal func setupWebView() {

        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.scrollView.bounces = false
        self.delegate = self
    }
}

extension XenoView : UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        xenoDelegate?.webViewDidFinishLoad()
    }

    internal func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {

        if request.url?.scheme == "xeno" {

            if request.url?.host == "closeButtonPressed" {

                xenoDelegate?.closeButtonPressed()
                return false
            }
        }

        if navigationType == .linkClicked {

            if request.url != nil {

                xenoDelegate?.openLink(url: request.url!)
            }
        }

        if navigationType == .other {

            return true
        }

        return false
    }
}
