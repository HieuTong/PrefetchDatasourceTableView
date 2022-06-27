//
//  ViewModel.swift
//  PrefetchTableView
//
//  Created by Le Tong Minh Hieu on 27/06/2022.
//

import Foundation
import UIKit

class ViewModel {
    init() {}
    
    private var isDownloading = false
    private var cachedImage: UIImage?
    private var callback: ((UIImage?) -> Void)?
    
    func downloadImage(completion: ((UIImage?) -> Void)?) {
        if let cachedImage = cachedImage {
            completion?(cachedImage)
            return
        }
        
        guard !isDownloading else {
            self.callback = completion
            return
        }
        
        isDownloading = true
        
        let size = Int.random(in: 100...350)
        
        guard let url = URL(string: "https://source.unsplash.com/random/\(size)x\(size)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.cachedImage = image
                self?.callback?(image)
                self?.callback = nil
                completion?(image)
            }
        }
        task.resume()
    }
}
