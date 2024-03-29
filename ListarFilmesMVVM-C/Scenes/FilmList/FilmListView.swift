//
//  FilmListView.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

protocol FilmListViewDelegate where Self: UIViewController {
    func goToDetailViewController(_ index: Int)
}

class FilmListView: UIView {
    
    weak var delegate: FilmListViewDelegate?
    lazy var listFilms: [Result] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ProjectStrings.cell.localized)
        return tableView
    }()
    
    lazy var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 24)
        return titleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupInit() {
        configureView()
    }
    
    private func configureView() {
        self.titleView.text = ProjectStrings.titleMoviesList.localized
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: ProjectStrings.customTableViewCell.localized)
        addSubview(titleView)
        addSubview(tableView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor,constant: 100),
            titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

extension FilmListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.goToDetailViewController(index)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectStrings.customTableViewCell.localized, for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = listFilms[indexPath.row].title
        cell.subtitleLabel.text = ProjectStrings.launchedIn.localized + listFilms[indexPath.row].releaseDate
        cell.customImageView.sd_setImage(with: URL(string: ProjectStrings.urlSdWebImage.localized + listFilms[indexPath.row].posterPath), placeholderImage: UIImage(named: ProjectStrings.placeholder.localized))
        return cell
    }
}
