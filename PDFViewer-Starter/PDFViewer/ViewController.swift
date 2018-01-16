
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit
import PDFKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var pdfThumbnailView: PDFThumbnailView!
    @IBOutlet weak var sidebarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!

    // MARK: - Constants

    let thumbnailDimension = 44
    let pdfURL = Bundle.main.url(forResource: "iOS_Deployment_Business", withExtension: "pdf")
    let animationDuration: TimeInterval = 0.25
    let sidebarBackgroundColor = UIColor(named: "SidebarBackgroundColor")

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addObservers()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    deinit {
        removeObservers()
    }

    // MARK: - Setup

    func setup() {
        setupPDFView()
        setupThumbnailView()
        loadPDF()
    }

    func setupPDFView() {

    }

    func setupThumbnailView() {

    }

    func loadPDF() {

    }

    // MARK: - Notifications

    func addObservers() {

    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Actions

    @IBAction func sidebarTapped(_ sender: Any) {
        toggleSidebar()
    }

    @IBAction func resetTapped(_ sender: Any) {
        scalePDFViewToFit()
    }

    @IBAction func previousTapped(_ sender: Any) {

    }

    @IBAction func nextTapped(_ sender: Any) {

    }

    // MARK: - Logic

    func toggleSidebar() {

    }

    func scalePDFViewToFit() {

    }

    @objc func resetNavigationButtons() {

    }

}

