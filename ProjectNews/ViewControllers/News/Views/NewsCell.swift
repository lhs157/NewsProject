//
//  NewsCell.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class NewsCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(_ news: ArticlesRealm) {
        imgView.kf.setImage(with: URL(string: news.urlToImage ?? ""))
        headlineLabel.text = news.title
        descriptionLabel.text = news.desc
        timeStampLabel.text = news.publishedAt
    }
    
}
