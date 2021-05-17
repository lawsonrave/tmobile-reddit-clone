//
//  ViewController.swift
//  Lawson TMobile Challenge Reddit Clone
//
//  Created by ravebizz on 4/29/21.
//

import UIKit

private let reuseIdentifier = "PostCell"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = HomeVM()
    private var myTableView: UITableView!
//    var posts: [Child] = []
    var posts: [Child] = [] {
        didSet {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        configureViewModel()
        viewModel.updateUIClosure?()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.autoresizesSubviews = true
        
        self.view.addSubview(myTableView)
    }
    
    func getData() {
        viewModel.getData { posts in
            if let posts = posts {
                self.updateUI(with: posts)
            }
        }
    }
    
    func updateUI(with posts: Posts) {
        self.posts = posts.allPosts.children
        for child in self.posts {
            print(child.post)
        }
        myTableView.reloadData()
    }
    
    func configureViewModel() {
        viewModel.updateUIClosure = {
//          update UI here
        }
    }


}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        cell.configure(post: self.posts[indexPath.row].post)
        
        let score = String(self.posts[indexPath.row].post.score)
        let numComments = String(self.posts[indexPath.row].post.numComments)
        
        cell.textLabel!.text = "API Score: \(score) \n Comments: \(numComments)"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

