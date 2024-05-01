//
//  ViewController.swift
//  TechieButlerAssignment
//
//  Created by Gurpreet Gulati on 01/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var currentPage = 1
    let pageSize = 10
    
    lazy var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.fetchPosts()
    }
    
    func configureView()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self //COMMENT THIS LINE IF NO PAGINATION IS SUPPORTED
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func showDetailVC(post:Post) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailVC.className) as? DetailVC {
            vc.post = post
            self.present(vc, animated: true)
        }
    }
}

//MARK: TABLE VIEW DELEGATE AND DATA SOURCE
extension ViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.className, for: indexPath) as? TableCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        let data = self.posts[indexPath.row]
        cell.configureData(data:data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
           guard let lastIndexPath = indexPaths.last else {
               return
           }
           let rowsLeft = posts.count - lastIndexPath.row - 1
           if rowsLeft < 5 { // Fetch more data when 5 rows are left
               currentPage += 1
               fetchPosts()
           }
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = posts[indexPath.row]
        self.showDetailVC(post: data)
    }
}

//MARK: WEB SERVICE
extension ViewController {
    func fetchPosts(url:String = "https://jsonplaceholder.typicode.com/posts") {
        NetworkManager.shared.fetchData(from: url) { [weak self] (result: Result<[Post], NetworkError>) in
            print("API CALLED")
            switch result {
            case .success(let posts):
                self?.posts = posts
            case .failure(let error):
                print(error)
            }
        }
    }
}
