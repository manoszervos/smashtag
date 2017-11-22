//
//  TweetTableViewCell.swift
//  smashTag
//
//  Created by Manolis Zervos on 22/11/2017.
//  Copyright © 2017 Manolis Zervos. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet?{
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
//        tweetTextLabel.text = tweet?.text
        tweetUserLabel.text = tweet?.user.description
        
        // get image view
        if let profileImagURL =  tweet?.user.profileImageURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImagURL) {
                    DispatchQueue.main.async {
                        self?.tweetProfileImageView.image = UIImage(data: imageData)
                    }
                }
            }
        } else {
            tweetProfileImageView.image = nil
        }
        
        // get date created
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel.text = formatter.string(from: created)
        } else {
            tweetCreatedLabel.text = nil
        }
        
        // get tweet text and add attributes on it
        
        let tweetAttributedString = NSMutableAttributedString(string: (tweet?.text)!)
        if let hashtags = tweet?.hashtags {
            for hashtag in hashtags {
                tweetAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: hashtag.nsrange)
            }
        }
        
        if let urls = tweet?.urls {
            for url in urls {
                tweetAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: url.nsrange)
            }
        }
        
        if let mentions = tweet?.userMentions {
            for mention in mentions {
                tweetAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green , range: mention.nsrange)
            }
        }
        
        tweetTextLabel.attributedText = tweetAttributedString
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
