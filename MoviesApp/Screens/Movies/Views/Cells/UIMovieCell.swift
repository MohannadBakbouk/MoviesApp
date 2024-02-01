//
//  UIMovieCell.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import UIKit
import Kingfisher
import SnapKit
import SkeletonView

final class UIMovieCell: UICollectionViewCell {
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.kf.indicatorType = .activity
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .primaryColor
        image.accessibilityIdentifier = "MovieImageView"
        image.isSkeletonable = true
        return image
     }()
    
    private var nameLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 18)
        label.isSkeletonable = true
        return label
    }()
    
    private var yearLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines  = 1
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .redColor
        return label
    }()
    
    private var overviewLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines  = 0
        label.textColor = .subtitleColor
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let ratingView: UIRatingView = {
        let rating = UIRatingView()
        rating.isSkeletonable = true
        return rating
    }()
    
    private let ratingCountLabel: UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.textColor = .subtitleColor
         lab.font = UIFont.systemFont(ofSize: 16)
         return lab
    }()
    
    private lazy var ratingStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [ratingView, ratingCountLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         stack.distribution = .fill
         stack.isHidden = true
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
         lab.text = ""
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
         stack.isHidden = true
         return stack
    }()
    
    private lazy var infoStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [nameLabel, yearLabel, overviewLabel, ratingStack, popularityStack])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.isSkeletonable = true
        return stack
    }()
    
    private lazy var mainStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [movieImage, infoStack])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.isSkeletonable = true
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
        isSkeletonable = true
        contentView.isSkeletonable = true
        backgroundColor = .secondaryColor
        clipsToBounds = true
        layer.cornerRadius = 12
        contentView.addSubview(mainStack)
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints(){
        mainStack.snp.makeConstraints {
            $0.top.leading.equalTo(contentView).offset(15)
            $0.bottom.trailing.equalTo(contentView).offset(-15)
        }
        
        movieImage.snp.makeConstraints{
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.3)
            $0.height.equalTo(mainStack.snp.height)
        }
         
        yearLabel.snp.makeConstraints{
            $0.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints{
            $0.height.equalTo(45).priority(.low)
            $0.height.greaterThanOrEqualTo(20).priority(.high)
        }
    }
    
    func configure(with model : MovieViewData){
        nameLabel.text = model.title
        yearLabel.text = "\(model.year)"
        overviewLabel.text = model.overview
        ratingView.setValueOnlyOneStar(value: model.rating)
        ratingCountLabel.text = "\(model.ratingCount)"
        popularityCountLabel.text = "\(model.popularity)"
        ratingStack.isHidden = false
        popularityStack.isHidden = false
        guard let url = model.image else { return}
        movieImage.kf.setImage(with: url)
    }
}
