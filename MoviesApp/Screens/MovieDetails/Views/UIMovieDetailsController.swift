//
//  UIMovieDetailsController.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import UIKit
import SnapKit

final class UIMovieDetailsController: UIBaseViewController<MovieDetailsViewModel> {

    private var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = .never
        return scroll
    }()
    
    private var contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .primaryColor
        return view
    }()
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .secondaryColor
        image.accessibilityIdentifier = "MovieImageView"
        return image
     }()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .primaryColor
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60 // fix issue
        table.separatorStyle = .none
        table.accessibilityIdentifier = "DetailsTableView"
        table.tableFooterView = UIView()
        return table
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: Images.back, withConfiguration: UIImage.SymbolConfiguration(pointSize: 45))
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.accessibilityIdentifier = "BackButton"
        return button
    }()
    
    var tableViewHeight : ConstraintMakerEditable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingDetailsToViews()
        viewModel.loadMovieDetails()
        displayingMainInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constraint.update(offset: tableView.contentSize.height)
    }
    
    private func setupViews(){
        view.backgroundColor = .primaryColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(contentOf: [movieImage, tableView, backButton])
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        setupTableview()
        setupViewsConstraints()
    }
    
    private func setupTableview(){
        tableView.register(mutipleCells: [UIBaseDetailItemCell.self, UITinyDetailItemCell.self])
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViewsConstraints(){
        scrollView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{ maker in
            maker.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            maker.width.equalTo(scrollView.frameLayoutGuide).priority(.required)
            maker.height.greaterThanOrEqualTo(scrollView.frameLayoutGuide).priority(.high)
            maker.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
        }
        
        movieImage.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(contentView)
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalTo(scrollView.snp.height).multipliedBy(0.5)
        }
        
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalTo(contentView)
            $0.top.equalTo(movieImage.snp.bottom).offset(10)
            tableViewHeight = $0.height.equalTo(50)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-15)
        }
        
        backButton.snp.makeConstraints{
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(0)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            $0.size.equalTo(35)
        }
    }
    
    private func displayingMainInfo(){
        tableView.reloadData()
        guard let url = viewModel.movieInfo.image else { return}
        movieImage.kf.setImage(with: url)
    }
    
    @objc func backButtonDidTap(){
        coordinator?.back()
    }
}


extension UIMovieDetailsController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details.value == nil ? 2 : DetailItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detailItem =  DetailItem(rawValue: indexPath.row) else {return UITableViewCell()}
        return makeCellFor(item: detailItem, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func makeCellFor(item: DetailItem, at index: IndexPath) -> UITableViewCell{
        let cellClass =  (item == .title || item == .overview) ? UIBaseDetailItemCell.self : UITinyDetailItemCell.self
        let cell = tableView.dequeueReusableCell(with: cellClass, for: index) as? UIBaseDetailItemCell
        cell?.setStyle(with: makeStyleItemFor(item: item))
        cell?.configure(with: makeDataModelFor(item: item))
        cell?.accessibilityIdentifier = "\(String(describing: item))_cell"
        return cell ?? UITableViewCell()
    }
    
    func makeDataModelFor(item: DetailItem) -> DetailItemViewData{
        let mainInfo = viewModel.movieInfo, details =  viewModel.details.value
        switch item {
            case .title:
                return DetailItemViewData(mainInfo.title, type: .title)
            case .overview:
                return DetailItemViewData(mainInfo.overview, type: .overview)
            case .year:
                return DetailItemViewData("\(mainInfo.year)", icon: Images.calendar, type: .year)
            case .rating:
                return DetailItemViewData(details?.rating, icon: Images.star, type: .rating)
            case .category:
                return DetailItemViewData(details?.category, icon: Images.tag, type: .category)
            case .runTime:
                return DetailItemViewData(details?.runtime, icon: Images.camera, type: .runTime)
            case .status:
                return DetailItemViewData(details?.status, icon: Images.bars, type: .status)
            case .revenue:
                return DetailItemViewData(details?.revenue, icon: Images.dollar, type: .revenue)
        }
    }
    
    func makeStyleItemFor(item: DetailItem) -> DetailItemCellStyle{
        switch item {
            case .title:
            return DetailItemCellStyle(.redColor, alignment: .center, fontSize: 25, fontWeight: .bold)
            case .overview:
                return DetailItemCellStyle(.subtitleColor, alignment: .left, fontSize: 15)
            default:
                return DetailItemCellStyle(.detailsColor, alignment: .left, fontSize: 16 , fontWeight: .semibold)
        }
    }
}
