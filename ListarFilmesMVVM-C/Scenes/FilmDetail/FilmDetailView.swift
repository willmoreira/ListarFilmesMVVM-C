//
//  FilmDetailView.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

protocol FilmDetailViewDelegate where Self: UIViewController {
    
}

class FilmDetailView: UIView {
    weak var delegate: FilmDetailViewDelegate?
    var film: Result? {
        didSet{
            updateFilm()
        }
    }
    
    var customImageView: UIImageView = {
        let myImg = UIImageView()
        myImg.contentMode = .scaleAspectFit
        return myImg
    }()
    
    var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 24)
        titleView.textAlignment = .center
        titleView.numberOfLines = 2
        return titleView
    }()
    
    var descriptLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupInit() {
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.text = film?.title
        descriptLabel.text = film?.overview
        titleView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleView)
        addSubview(customImageView)
        addSubview(descriptLabel)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            customImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customImageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            customImageView.widthAnchor.constraint(equalToConstant: 350),
            customImageView.heightAnchor.constraint(equalToConstant: 350),
            
            descriptLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 16),
        ])
    }
    
    func updateFilm() {
        if let imgPathUrl = film?.posterPath {
            let imageUrl = URL(string: ProjectStrings.urlSdWebImage.localized + imgPathUrl)
            customImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ProjectStrings.placeholder.localized))
        }
        titleView.text = film?.title
        descriptLabel.text = film?.overview
    }
}
