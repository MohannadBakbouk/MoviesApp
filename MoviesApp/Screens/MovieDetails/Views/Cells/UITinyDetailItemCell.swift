//
//  UITinyDetailItemCell.swift
//  MoviesApp
//
//  Created by Mohannad on 02/02/2024.
//

import Foundation
final class UITinyDetailItemCell: UIBaseDetailItemCell {
    override func setupViews() {
        containerView.backgroundColor = .secondaryColor
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 12
        padding = 7 
        contentPadding = 10
        iconImage.isHidden = false
        contentLabel.numberOfLines = 1
        super.setupViews()
    }
}
