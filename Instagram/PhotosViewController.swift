//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Dhruv Mangtani on 6/9/16.
//  Copyright © 2016 dhruv.mangtani. All rights reserved.
//

import UIKit
import AFNetworking
class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let clientId = "02828d789a744f4e8a3f26a54bf11ea7"
        let url = NSURL(string:"https://api.instagram.com/v1/users/self/media/recent?access_token=1780823063.02828d7.e945f0991b08416b901ee42532656b00")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.data = responseDictionary["data"] as! NSArray
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 530
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl){
        let url = NSURL(string:"https://api.instagram.com/v1/users/self/media/recent?access_token=1780823063.02828d7.e945f0991b08416b901ee42532656b00")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.data = responseDictionary["data"] as! NSArray
                            self.tableView.reloadData()
                            refreshControl.endRefreshing()
                    }
                }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data != nil{
            return data.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoTableViewCell
        let imageURL = NSURL(string: (data[indexPath.row] as! NSDictionary)["images"]!["low_resolution"]!!["url"] as! String)
        let profileImageURL = NSURL(string: (data[indexPath.row] as! NSDictionary)["user"]!["profile_picture"]! as! String)
        let username = (data[indexPath.row] as! NSDictionary)["user"]!["username"]! as! String
        let likes = (data[indexPath.row] as! NSDictionary)["likes"]!["count"]! as! Int
        let caption = (data[indexPath.row] as! NSDictionary)["caption"]?["text"] as? String
        cell.photoView.setImageWithURL(imageURL!)
        cell.profileView.setImageWithURL(profileImageURL!)
        cell.userNameLabel.text = username
        cell.likesLabel.text = "Likes: \(likes)"
        if(caption != nil){
            cell.captionLabel.text = caption
        }else{
            cell.captionLabel.text = ""
        }
        return cell
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
