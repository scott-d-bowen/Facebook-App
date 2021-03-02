//  ViewController.swift
//  Facebook App
//
//  Created by Scotty B on 2-Mar-2021.

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet var wkFacebookView: WKWebView!    // Strong Ref is required here, no [weak]
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        wkFacebookView = WKWebView(frame: .zero, configuration: webConfiguration)
        wkFacebookView.navigationDelegate = self
        wkFacebookView.uiDelegate = self    // Testing WKUIDelegate...
        view = wkFacebookView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://m.facebook.com")
        let myRequest = URLRequest(url: myURL!)
        wkFacebookView.load(myRequest)
        wkFacebookView.allowsBackForwardNavigationGestures = true
        
    }
    
    func webView(_ webView: WKWebView,
         runOpenPanelWith parameters: WKOpenPanelParameters,
         initiatedByFrame frame: WKFrameInfo,
         completionHandler: @escaping ([URL]?) -> Void) {
        
            let openPanel = NSOpenPanel()
                openPanel.canChooseFiles = true
                openPanel.begin { (result) in
                    if result == NSApplication.ModalResponse.OK {
                        if let url = openPanel.url {
                            completionHandler([url])
                        }
                    } else if result == NSApplication.ModalResponse.cancel {
                        completionHandler(nil)
                    }
                }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
