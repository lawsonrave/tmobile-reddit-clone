//
//  ViewController.swift
//  Lawson TMobile Challenge Reddit Clone
//
//  Created by ravebizz on 4/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = HomeVM()
    private var myTableView: UITableView!
    var posts: [Child] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        configureViewModel()
        viewModel.updateUIClosure?()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    func getData() {
        viewModel.getData { posts in
            if let posts = posts {
                self.updateUI(with: posts)
            }
            self.myTableView.dataSource = self
            self.myTableView.delegate = self
        }
    }
    
    func updateUI(with posts: Posts) {
        self.posts = posts.allPosts.children
        for child in self.posts {
            print(child.post.title)
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(self.posts[indexPath.row].post.title)"
        return cell
    }
}

