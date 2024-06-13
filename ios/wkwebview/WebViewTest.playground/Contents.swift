//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import WebKit

class MyViewController : UIViewController {
    
    // "WKWebView" Instance
    var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize webview
        wkWebView = WKWebView(frame: view.bounds)
        wkWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(wkWebView)
        
        // load URL
        if let url = URL(string: "http://www.apple.com") {
            let request = URLRequest(url: url)
            wkWebView.load(request)
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
