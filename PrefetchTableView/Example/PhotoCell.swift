//
//  PhotoCell.swift
//  PrefetchTableView
//
//  Created by Le Tong Minh Hieu on 27/06/2022.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: ViewModel) {
        viewModel.downloadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
    }
}
