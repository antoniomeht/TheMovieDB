//
//  SearchMovieViewController.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import UIKit

protocol SearchMovieDisplayLogic: AnyObject {
    func searchTextDidChanged(text: String?)
    func displayMovies(_ displayMovies: [DisplayMovie], append: Bool)
}

class SearchMovieViewController: BaseViewController, SearchMovieDisplayLogic {

    @IBOutlet weak var movieTableView: UITableView!
    
    var presenter: SearchMoviePresenterLogic?
    var displayMovies: [DisplayMovie]? {
        didSet {
            reloadTableCells()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        presenter = SearchMoviePresenter(viewController: self)
    }
    
    private func setupTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.register(UINib(nibName: MovieListCell.cellIdentificator, bundle: nil), forCellReuseIdentifier: MovieListCell.cellIdentificator)
    }
    
    func searchTextDidChanged(text: String?) {
        presenter?.searchText(text: text ?? .empty)
    }
    
    private func reloadTableCells(){
        DispatchQueue.main.async { [weak self] in
            self?.movieTableView.reloadData()
        }
    }
    
    private func presentMovieDetail(movieId: Int){
        let controller = MovieDetailViewController(movieId: movieId)
        presentingViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func displayMovies(_ displayMovies: [DisplayMovie], append: Bool) {
        if append {
            self.displayMovies?.append(contentsOf: displayMovies)
        } else {
            self.displayMovies = displayMovies
        }
    }
}

// MARK: - TableView Delegate & DataService

extension SearchMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utils.screenSize.width / 1.5
    }
}

extension SearchMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.cellIdentificator, for: indexPath) as? MovieListCell
        cell?.configureCell(displayMovies?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (displayMovies?.count ?? 0) - 1{
            presenter?.loadPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieId = displayMovies?[indexPath.row].id {
            presentMovieDetail(movieId: movieId)
        }
    }

}
