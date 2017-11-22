//
//  WebViewViewController.swift
//  smashTag
//
//  Created by Manolis Zervos on 22/11/2017.
//  Copyright © 2017 Manolis Zervos. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
    @IBOutlet weak var tweetWebView: UIWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadUrl() {
        if let url = url {
            tweetWebView.loadRequest(NSURLRequest(url: URL(string: url)!) as URLRequest)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
