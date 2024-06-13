//
//  ViewController.swift
//  WKWebViewTest
//
//  Created by stevenpak on 6/3/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the WKWebViewConfiguration
        let contentController = WKUserContentController()
        contentController.add(self, name: "messageHandler")

        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        // Initialize the WKWebView with the configuration
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        view.addSubview(webView)

        // Load an HTML string
        let htmlString = """
        <html>
        <body>
        <h1>Hello, WKWebView!</h1>
        <button type="button" onclick="sendMessageToNativeApp()">Send Message</button>
        <script>
        function sendMessageToNativeApp() {
            window.webkit.messageHandlers.messageHandler.postMessage('Hello from JavaScript');
        }
        </script>
        </body>
        </html>
        """
        webView.loadHTMLString(htmlString, baseURL: nil)
    }

    // Handle messages from JavaScript
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "messageHandler" {
            if let messageBody = message.body as? String {
                print("JavaScript message received: \(messageBody)")
                showAlert(message: messageBody)
            }
        }
    }

    // Show an alert with the message from JavaScript
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Message from JavaScript", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

