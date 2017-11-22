//
//  TweetsDetailsTableViewController.swift
//  smashTag
//
//  Created by Manolis Zervos on 22/11/2017.
//  Copyright © 2017 Manolis Zervos. All rights reserved.
//

import UIKit
import Twitter

struct TweetSectionCategory {
    let name: String
    let mentions: [Mention]
}

class TweetsDetailsTableViewController: UITableViewController {
    var tweet: Twitter.Tweet? {
        didSet {
            createDictionary()
            self.tableView.reloadData()
        }
    }
    
    var tweetSections = [TweetSectionCategory]()
    
    private func createDictionary() {
        tweetSections.removeAll()
        
        if let hashtags = tweet?.hashtags, !hashtags.isEmpty {
            tweetSections.append( TweetSectionCategory(name: "Hashtags", mentions: hashtags))
        }
        
        if let mentions = tweet?.userMentions, !mentions.isEmpty {
            tweetSections.append(TweetSectionCategory(name: "Mentions", mentions: mentions))
        }
        
        if let urls = tweet?.urls, !urls.isEmpty {
            tweetSections.append(TweetSectionCategory(name: "URL'S", mentions: urls))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweetSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetSections[section].mentions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleLineCell", for: indexPath) as! SingleLineTableViewCell
        cell.titleLabel.text = tweetSections[indexPath.section].mentions[indexPath.row].keyword
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tweetSections[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SingleLineTableViewCell
        let cellText = cell.titleLabel.text
        
        if let header = tableView.headerView(forSection: indexPath.section)?.textLabel?.text {
            switch header {
            case "Hashtags", "Mentions":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TweetsTableViewController") as! TweetsTableViewController
                vc.textToSearch = cellText
                vc.tableView.allowsSelection = false
                self.navigationController?.pushViewController(vc, animated: true)
            case "URL'S":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
                vc.url = cellText
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
