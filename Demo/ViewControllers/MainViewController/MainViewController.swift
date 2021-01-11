//
//  MainViewController.swift
//  Demo
//
//  Created by Matias Ladelfa on 09/01/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MainViewModel?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize UI and try to fetch data.
        setupView()
        viewModel?.getSamples()
    }
    
    // MARK: - View Configuration
    /// View's initial configuration.
    private func setupView() {
        setupUI()
        setupNotifications()
        
        viewModel = MainViewModel()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.XibName.sampleCell, bundle: nil), forCellReuseIdentifier: Constants.XibName.sampleCell)
        
        navigationItem.title = Constants.MainView.title
    }
    
    /// Initialize notification observers and analytics.
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(samplesDownloadHandler),
                                               name: .samplesDownloaded,
                                               object: nil)
    }
    
    // MARK: - Notification Handlers
    /// Reloads UI based on downloaded data.
    @objc private func samplesDownloadHandler() {
        tableView.reloadData()
    }
}

// MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {
    /// Table view cell selection handler.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? SampleCell,
              let image = cell.imageView?.image,
              let title = cell.titleLabel.text,
              let description = cell.descriptionLabel.text else { return }
              
        guard let rootNav = navigationController else { return }
        let detail = DetailViewCoordinator(rootNav, title: title, description: description, placeholder: image)
        detail.start()
    }
}

// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    /// Defines table row count.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.samples?.count ?? 0
    }
    
    /// Defines table column count.
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    /// Return table view cell height.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.MainView.cellHeight
    }
    
    /// Cell configuration.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.XibName.sampleCell) as? SampleCell else {
                return UITableViewCell()
        }
        
        // Validate fetched data and set cell.
        guard let sample = viewModel?.samples?[indexPath.row] else { return cell }
        cell.configure(title: sample.title, description: sample.description, url: sample.image)
        
        return cell
    }
}
