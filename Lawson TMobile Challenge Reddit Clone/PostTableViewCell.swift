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
    
//    var parentTableView: UITableView? {
//        var view = superview
//        while let v = view, v.isKind(of: UITableView.self) == false {
//            view = v.superview
//        }
//        return view as? UITableView
//
//    }
    var titleLabel: UILabel = {
//        Reset width to parent tableview width/screen width
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 21))
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.backgroundColor = .red
        label.numberOfLines = 0
        return label
    }()
    var myImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return imageView
    }()
    var post: Post? {
        didSet {
            updateUI()
            self.addSubview(titleLabel)
            self.addSubview(myImageView)
        }
    }
    
    func configure(post: Post?) {
        self.post = post
    }
    
    func updateUI() {
        updateTitleLabel()
        getImage()
        setUpConstraints()
    }
    
    func updateTitleLabel() {
        self.titleLabel.text = post?.title
        
        self.titleLabel.sizeToFit()
    }
    
    func setUpConstraints() {
        
        func setUpTitleConstraints() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
//                Set leading anchor to parentTableView leading anchor + 10
//                titleLabel.leadingAnchor.constraint(equalTo: parentTableView?.leadingAnchor ?? NSLayoutXAxisAnchor(), constant: 10),
            ])
        }
        
        setUpTitleConstraints()
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
