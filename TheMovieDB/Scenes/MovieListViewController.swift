//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import UIKit

protocol MovieListDisplayLogic: AnyObject {
    func displayMovies(_ displayMovies: [DisplayMovie])
}

class MovieListViewController: BaseViewController, MovieListDisplayLogic {

    @IBOutlet weak var movieTableView: UITableView!
    
    var presenter: MovieListPresenterLogic?
    var displayMovies: [DisplayMovie]? {
        didSet {
            reloadTableCells()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
        setupTableView()
        presenter?.getMovieList()
    }
    
    private func setupNavigation(){
        title = StringConstants.MovieList.title
    }
    
    private func setupView(){
        presenter = MovieListPresenter(viewController: self)
    }
    
    private func setupTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.register(UINib(nibName: MovieListCell.cellIdentificator, bundle: nil), forCellReuseIdentifier: MovieListCell.cellIdentificator)
    }
    
    private func reloadTableCells(){
        DispatchQueue.main.async { [weak self] in
            self?.movieTableView.reloadData()
        }
    }
    
    func displayMovies(_ displayMovies: [DisplayMovie]) {
        self.displayMovies = displayMovies
    }

}

// MARK: - TableView Delegate & DataService

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utils.screenSize.width / 2
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.cellIdentificator, for: indexPath) as? MovieListCell
        cell?.configureCell(displayMovies?[indexPath.row])
        return cell ?? UITableViewCell()
    }

}
