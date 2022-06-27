//
//  ViewController.swift
//  PrefetchTableView
//
//  Created by Le Tong Minh Hieu on 27/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /// ViewModels
    private let viewModels = Array(1...1000).map { _ in ViewModel() }
    
    /// Random image URL string
    let url = "https://source.unsplash.com/random/\(300)x\(300)"
    
    /// MARK:  -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.registerFromNib(forCellClass: PhotoCell.self)
//        tableView.register(PhotoCell.self, forCellReuseIdentifier: "cell")
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 300
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: PhotoCell.self, for: indexPath)
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            let viewModel = viewModels[indexPath.row]
            viewModel.downloadImage(completion: nil)
        }
    }
}

