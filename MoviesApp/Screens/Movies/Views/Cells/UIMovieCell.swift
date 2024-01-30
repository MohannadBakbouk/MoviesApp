//
//  UIMovieCell.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import UIKit
import Kingfisher
import SnapKit

final class UIMovieCell: UICollectionViewCell {
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.kf.indicatorType = .activity
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .yellow
        image.accessibilityIdentifier = "MovieImageView"
        return image
     }()
    
    private var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "bnnnmm"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var yearLabel : UILabel = {
        let label = UILabel()
        label.text = "uuuu"
        label.textColor = .subtitleColor
        return label
    }()
    
    private var overviewLabel : UILabel = {
        let label = UILabel()
        label.text = "oover"
        label.numberOfLines  = 4
        label.textColor = .subtitleColor
        return label
    }()
    
    private let ratingView: UIRatingView = {
        let rating = UIRatingView()
        return rating
    }()
    
    private let voteCountLabel: UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.textColor = .subtitleColor
         lab.font = UIFont.systemFont(ofSize: 16)
         return lab
    }()
    
    private lazy var ratingStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [ratingView, voteCountLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         stack.distribution = .fill
         return stack
    }()
    
    private let popularityImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Images.eye)
        image.tintColor = .white
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return image
    }()
    
    private let popularityCountLabel: UILabel = {
         let lab = UILabel()
         lab.text = "jj"
         lab.textColor = .subtitleColor
         lab.font = UIFont.systemFont(ofSize: 16)
         lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
         return lab
    }()
    
    private lazy var popularityStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [popularityImage, popularityCountLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         stack.distribution = .fill
         stack.alignment = .leading
         return stack
    }()
    
    private lazy var infoStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [nameLabel, yearLabel, overviewLabel, ratingStack, popularityStack])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var mainStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [movieImage , infoStack])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func setupViews(){
        backgroundColor = .secondaryColor
        clipsToBounds = true
        layer.cornerRadius = 12
        contentView.addSubview(mainStack)
        mainStack.snp.makeConstraints {
            $0.top.leading.equalTo(contentView).offset(15)
            $0.bottom.trailing.equalTo(contentView).offset(-15)
        }
        
        movieImage.snp.makeConstraints{
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.3)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.8)
        }
        
        movieImage.snp.makeConstraints{
            $0.width.height.equalTo(20)
        }
    }
}
