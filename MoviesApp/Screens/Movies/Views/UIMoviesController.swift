//
//  UIMoviesController.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit
import SkeletonView

final class UIMoviesController: UIBaseViewController<MoviesViewModel> {
    let padding : CGFloat = 12
    
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = .primaryColor
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.accessibilityIdentifier = "MovieCollectionView"
        return collection
    }()
    
    lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingViewsToViewModelEvents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard viewModel.movies.value.count == 0 else {return}
        viewModel.loadMovies()
    }
    
    private func setupViews(){
        view.backgroundColor = .primaryColor
        view.addSubview(collectionView)
        setupCollection()
        setupViewsConstraints()
        setupCollectionCellSize()
        SkeletonAppearance.default.multilineLastLineFillPercent = 100
        SkeletonAppearance.default.gradient = SkeletonGradient(baseColor: .subtitleColor)
    }
    
    private func setupCollection(){
        collectionView.register(UIMovieCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isSkeletonable = true
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width)
        let hieght = (UIScreen.main.bounds.height) / 3.5
        collectionViewLayout.itemSize = CGSize(width: width , height: hieght)
    }
    
    private func setupViewsConstraints(){
        collectionView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func bindingViewsToViewModelEvents(){
         bindingMoviesToCollectionView()
         bindingIsLoadingToAnimator()
         bindingError()
    }
    
    func stopSkeletonAnimation(){
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
        collectionView.reloadData()
    }
}

extension UIMoviesController: SkeletonCollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(with: UIMovieCell.self, for: indexPath) as? UIMovieCell ,
              let model = viewModel.movies.value[safe:indexPath.row] else {return UICollectionViewCell()}
        cell.configure(with: model)
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        String(describing: UIMovieCell.self)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == (viewModel.movies.value.count - 1) ,!viewModel.isLoadingMore.value else {return}
        viewModel.reachedBottomTrigger.send()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selected = viewModel.movies.value[safe:indexPath.row] else {return}
        (coordinator as? MainCoordinator)?.showMovieDetails(with: selected)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width )
        let hieght = (collectionView.frame.height) / 3.5
        return CGSize(width: width , height: hieght)
    }
}

