//
//  PostTableViewCell.swift
//  Lawson TMobile Challenge Reddit Clone
//
//  Created by ravebizz on 5/17/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 21))
//        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.numberOfLines = 0
        label.backgroundColor = .red
        return label
    }()
    var myImageView: UIImageView = {
//        Set image width and height to thumbnail_width, thumbnail_height. Implement in model first
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return imageView
    }()
    var scoreLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 21))
        label.numberOfLines = 0
        label.backgroundColor = .blue
        return label
    }()
    var commentsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 21))
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }()
    var post: Post? {
        didSet {
            self.addSubview(titleLabel)
            self.addSubview(myImageView)
            self.addSubview(scoreLabel)
            self.addSubview(commentsLabel)
            updateUI()
        }
    }
    
    func configure(post: Post?) {
        self.post = post
    }
    
    func updateUI() {
        setUpConstraints()
        updateTitleLabel()
        getImage()
        updateScoreLabel()
        updateCommentsLabel()
    }
    
    func updateTitleLabel() {
        self.titleLabel.text = post?.title
        
//        self.titleLabel.sizeToFit()
    }
    
    func updateScoreLabel() {
        self.scoreLabel.text = "Score: \(String(post?.score ?? 0))"
    }
    
    func updateCommentsLabel() {
        self.commentsLabel.text = "Comments: \(String(post?.numComments ?? 0))"
    }
    
    func setUpConstraints() {
        
        func setUpTitleConstraints() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ])
        }
        
        func setUpImageConstraints() {
            myImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                myImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                myImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                myImageView.heightAnchor.constraint(equalToConstant: CGFloat(self.post?.thumbnailHeight ?? 0)),
                myImageView.widthAnchor.constraint(equalToConstant: CGFloat(self.post?.thumbnailWidth ?? 0)),
            ])
        }
        
        func setUpScoreConstraints() {
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                scoreLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10),
                scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            ])
        }
        
        func setUpCommentsConstraints() {
            commentsLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                commentsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                commentsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
                commentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                commentsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
            ])
        }
        
        setUpTitleConstraints()
        setUpImageConstraints()
        setUpScoreConstraints()
        setUpCommentsConstraints()
    }
    
    func getImage() {
        let imageLink = post?.thumbnail ?? ""
        guard let url = URL(string: imageLink) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.myImageView.image = image
            }
        }
    }

}
