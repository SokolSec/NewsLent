//
//  ViewController.swift
//  News
//
//  Created by Даниил Сокол on 05.02.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(TableViewControllerbyNews.self, forCellReuseIdentifier: TableViewControllerbyNews.identifier)
        return table
    }()
    
    
    var refhrea: UIRefreshControl{
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return ref
    }
    private var viewModels = [TableViewControllerbyNewsModel]()
    private var articles = [Article]()
    
    
    @objc private func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
    }
    
    @IBOutlet weak var ref : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refhrea)
        title = "News by SOKOL D.S."
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        APIConnect.linkAPI.newsBestStory { [weak self ] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    TableViewControllerbyNewsModel(title: $0.title , subtitle: $0.description )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
    }
    }
    
    @objc func handleRefresh(_ control: UIRefreshControl) {
        tableView.backgroundColor = control.tintColor
        control.endRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard  let cell = tableView.dequeueReusableCell(withIdentifier: TableViewControllerbyNews.identifier, for: indexPath) as? TableViewControllerbyNews else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url) else {
            return
        }
        let browser = SFSafariViewController(url: url)
        present(browser, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
