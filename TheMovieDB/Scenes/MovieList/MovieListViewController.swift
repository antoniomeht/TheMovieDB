//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import UIKit

protocol MovieListDisplayLogic: AnyObject {
    func displayMovies(_ displayMovies: [DisplayMovie], append: Bool)
}

class MovieListViewController: BaseViewController, MovieListDisplayLogic {

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var movieTypeButton: UIButton!
    
    var searchController: UISearchController?
    var presenter: MovieListPresenterLogic?
    var displayMovies: [DisplayMovie]? {
        didSet {
            reloadTableCells()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchController()
        setupMenuButton()
        presenter?.getNewMovieList()
    }
    
    private func setupView(){
        title = StringConstants.MovieList.title
        presenter = MovieListPresenter(viewController: self)
    }
    
    private func setupTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.register(UINib(nibName: MovieListCell.cellIdentificator, bundle: nil), forCellReuseIdentifier: MovieListCell.cellIdentificator)
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: SearchMovieViewController())
        searchController?.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func setupMenuButton() {
        let menuClosure = {(action: UIAction) in
            self.updateListButton(action.title)
        }
        movieTypeButton.menu = UIMenu(children: [
            UIAction(title: StringConstants.MovieList.ListType.nowPlaying, state: .on, handler: menuClosure),
            UIAction(title: StringConstants.MovieList.ListType.popular, handler: menuClosure),
            UIAction(title: StringConstants.MovieList.ListType.topRated, handler: menuClosure),
            UIAction(title: StringConstants.MovieList.ListType.upcoming, handler: menuClosure)
        ])
        movieTypeButton.showsMenuAsPrimaryAction = true
        movieTypeButton.changesSelectionAsPrimaryAction = true
    }
    
    private func reloadTableCells(){
        DispatchQueue.main.async { [weak self] in
            self?.movieTableView.reloadData()
        }
    }
    
    func displayMovies(_ displayMovies: [DisplayMovie], append: Bool) {
        if append {
            self.displayMovies?.append(contentsOf: displayMovies)
        } else {
            self.displayMovies = displayMovies
        }
    }
    
    func updateListButton(_ selection: String) {
        presenter?.setMovieListType(MovieListType.getType(selection))
    }
    
    private func presentMovieDetail(movieId: Int){
        let controller = MovieDetailViewController(movieId: movieId)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - TableView Delegate & DataService

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utils.screenSize.width / 1.5
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

// MARK: - Search Controller Delegates

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, let controller = searchController.searchResultsController as? SearchMovieDisplayLogic else {
            return
        }
        controller.searchTextDidChanged(text: text)
    }
}
