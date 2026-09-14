//
//  ViewController.swift
//  SearchBarCode
//
//  Created by 김용현 on 9/14/26.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    var allItems = ["Apple", "Banana", "Cherry", "Durian", "Elderberry", "Fig", "Grape"]

    var filteredItems: [String] = []

    var isSearching: Bool {
        /* 검색 컨트롤러가 활성화되어 있고, 검색창이 비어 있지 않으면 true를 반환함 */
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }

    private let fruitTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    let searchController = UISearchController(searchResultsController: nil)


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupTableView()
        setupSearchBar()

        filteredItems = allItems
    }


    // MARK: - Helpers

    private func setupTableView() {
        view.addSubview(fruitTableView)

        fruitTableView.dataSource = self

        fruitTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        fruitTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fruitTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fruitTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            fruitTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            fruitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupSearchBar() {
        title = "Fruits"

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Fruits"

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredItems.count : allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = isSearching ? filteredItems[indexPath.row] : allItems[indexPath.row]

        cell.textLabel?.text = item

        return cell
    }

}


// MARK: - UISearchResultsUpdating

extension ViewController: UISearchResultsUpdating {

    /* 검색창에 값을 입력하거나 지울 때 자동으로 호출됨 */
    func updateSearchResults(for searchController: UISearchController) {
        /* 검색창에 값이 있으면 그 값을 함수에 전달하고, 값이 nil이면 빈 문자열을 전달함 */
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }

    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            /* 검색창이 비어 있으면 allItems 배열을 filteredItems 배열에 저장함 */
            filteredItems = allItems
        } else {
            /* allItems 배열에서 입력된 값을 포함하는 항목만 골라서 filteredItems 배열에 저장함 */
            filteredItems = allItems.filter { item in
                item.lowercased().contains(searchText.lowercased())
            }
        }

        fruitTableView.reloadData()
    }

}
