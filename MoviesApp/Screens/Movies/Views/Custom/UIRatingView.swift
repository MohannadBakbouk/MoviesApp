//
//  UIRatingView.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import Foundation
import UIKit

final class UIRatingView : UIStackView {
    
    private var count : Int = 1
    
    var showValue: Bool = true
    
    private var valueLabel : UILabel = {
         let lab = UILabel()
         lab.text = "0.0"
         lab.font = UIFont.systemFont(ofSize: 16)
         lab.textColor = .white
         lab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
         return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
      alignment = .leading
      distribution = .fillProportionally
      axis = .horizontal
      spacing = 5
      _ = (0..<count).map{_ in addArrangedSubview(makeStar())}
      _ = showValue ? addArrangedSubview(valueLabel) : valueLabel.removeFromSuperview()
    }
    
    func setValueWithMultipleStar(value : Double){
        _ = arrangedSubviews.map{$0.removeFromSuperview()}
        _ = (0..<Int(value)).map{_ in addArrangedSubview(makeStar())}
        _ = value.truncatingRemainder(dividingBy: 1) >= 0.5 ? addArrangedSubview(makeStar(name: Images.halfFilledStar)) : ()
        _ = arrangedSubviews.count < count ? (0..<count - arrangedSubviews.count).map{_ in addArrangedSubview(makeStar(name: Images.star))} : []
    }
    
    func setValueOnlyOneStar(value : Double){
        _ = arrangedSubviews.map{$0.removeFromSuperview()}
        let starName =  value == 0 ? Images.star : value > 1 ? Images.filledStar : Images.halfFilledStar
        addArrangedSubview(makeStar(name: starName))
        guard showValue else {return}
        addArrangedSubview(valueLabel)
        valueLabel.text =  String(format: "%.1f", value)
    }
    
    private func makeStar(name : String = Images.filledStar) -> UIImageView {
        let star = UIImageView(image: UIImage(systemName: name)!)
        star.tintColor = .systemYellow
        star.contentMode = .scaleAspectFit
        return star
    }
}

