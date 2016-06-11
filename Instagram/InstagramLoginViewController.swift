//
//  InstagramLoginViewController.swift
//  Instagram
//
//  Created by Dhruv Mangtani on 6/8/16.
//  Copyright © 2016 dhruv.mangtani. All rights reserved.
//

import UIKit
class InstagramLoginViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*InstagramEngine.sharedEngine().logout()
        let authURL = InstagramEngine.sharedEngine().authorizationURL()
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: authURL))
        */
        // Do any additional setup after loading the view.
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://api.instagram.com/oauth/authorize/?client_id=02828d789a744f4e8a3f26a54bf11ea7&redirect_uri=localhost:3000/auth/instagram/callback&response_type=code&scope=basic+public_content")!))
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.URL!.absoluteString.rangeOfString("code=") != nil{
            //print(request.URL)
            self.performSegueWithIdentifier("toPhotos", sender: self)
        }
        /*do{
        try InstagramEngine.sharedEngine().receivedValidAccessTokenFromURL(request.URL!)
        } catch let error as NSError {
           print("Error: \(error.localizedDescription)")
        }
        */
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
