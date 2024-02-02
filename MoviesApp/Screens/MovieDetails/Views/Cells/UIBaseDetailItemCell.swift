//
//  UIBaseDetailItemCell.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import UIKit

struct DetailItemCellStyle{
   let textColor: UIColor
   let alignment: NSTextAlignment
   let fontSize: CGFloat
   let fontWeight: UIFont.Weight
    
    init(_ textColor: UIColor, alignment: NSTextAlignment, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular) {
        self.textColor = textColor
        self.alignment = alignment
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
}

class UIBaseDetailItemCell: UITableViewCell {
    
    var padding: CGFloat = 0
    
    var contentPadding: CGFloat = 8
    
    var iconImage: UIImageView = {
        let img = UIImageView(image: nil)
        img.isHidden = true
        img.tintColor = .redColor
        return img
     }()

    var contentLabel : UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.font = UIFont.boldSystemFont(ofSize: 16)
         lab.textColor = .subtitleColor
         lab.numberOfLines = 0
         return lab
    }()
    
    lazy var contentStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [iconImage,contentLabel ])
         stack.axis = .horizontal
         stack.spacing = 12
         stack.distribution = .fill
         stack.alignment = .leading
         return stack
    }()
        
    var containerView: UIView = {
         let view = UIView()
         view.clipsToBounds = true
         return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews(){
        backgroundColor = .primaryColor
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(contentStack)
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints(){
        containerView.snp.makeConstraints{
            $0.top.leading.equalTo(contentView).offset(padding)
            $0.bottom.trailing.equalTo(contentView).offset(-padding)
        }
        
        contentStack.snp.makeConstraints{
            $0.top.leading.equalTo(containerView).offset(contentPadding)
            $0.bottom.trailing.equalTo(containerView).offset(-contentPadding)
        }
        iconImage.snp.makeConstraints{$0.size.equalTo(20)}
    }
    
    func configure(with model: DetailItemViewData){
        contentLabel.text = model.text
        guard let icon = UIImage(systemName: model.icon ?? "") else { return}
        iconImage.image = icon
    }
    
    func setStyle(with value: DetailItemCellStyle){
        contentLabel.textColor = value.textColor
        contentLabel.textAlignment = value.alignment
        contentLabel.font = .systemFont(ofSize: value.fontSize, weight: value.fontWeight)
    }
}
