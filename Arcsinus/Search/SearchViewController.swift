//
//  SearchViewController.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    private let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        
        searchBar.rx.text.distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(20), scheduler: MainScheduler.instance)
            .bind { [weak self] text in
                self?.search(query: text)
        }.disposed(by: disposeBag)

        isLoading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        viewModel.persons.bind(to: tableView.rx.items(cellIdentifier: String(describing: SearchCell.self), cellType: SearchCell.self)) { (row, element, cell) in
            cell.setup(with: element)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SWPerson.self).bind { [unowned self] person in
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardWillChangeFrame(notification)
        }
    }
    
    private func keyboardWillChangeFrame(_ notification: Notification) {
        if let params = notification.keyboardParameters {
            var contentInsets: UIEdgeInsets
            if params.frame.origin.y < view.bounds.height {
                contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: params.size, right: 0)
            } else {
                contentInsets = UIEdgeInsets.zero
            }
            tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
        }
    }
    
    private func search(query: String?) {
        isLoading.accept(query?.count ?? 0 > 1)
        viewModel.search(query: query) { [weak self] error in
            self?.isLoading.accept(false)
            if let error = error {
                let alert: UIAlertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let cancel: UIAlertAction = UIAlertAction(title: "Done", style: .cancel)
                alert.addAction(cancel)

                let action: UIAlertAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    self?.search(query: query)
                })
                alert.addAction(action)
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
