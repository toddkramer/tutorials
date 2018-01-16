
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
        coordinator.animate(alongsideTransition: { _ in
            self.scalePDFViewToFit()
        }, completion: nil)
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
        pdfView.autoScales = true
    }

    func setupThumbnailView() {
        pdfThumbnailView.pdfView = pdfView
        pdfThumbnailView.thumbnailSize = CGSize(width: thumbnailDimension, height: thumbnailDimension)
        pdfThumbnailView.backgroundColor = sidebarBackgroundColor
    }

    func loadPDF() {
        guard let url = pdfURL else { return }
        let document = PDFDocument(url: url)
        pdfView.document = document
        resetNavigationButtons()
    }

    // MARK: - Notifications

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(resetNavigationButtons), name: .PDFViewPageChanged, object: nil)
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
        pdfView.goToPreviousPage(sender)
    }

    @IBAction func nextTapped(_ sender: Any) {
        pdfView.goToNextPage(sender)
    }

    // MARK: - Logic

    func toggleSidebar() {
        let thumbnailViewWidth = pdfThumbnailView.frame.width
        let screenWidth = UIScreen.main.bounds.width
        let multiplier = thumbnailViewWidth / (screenWidth - thumbnailViewWidth) + 1.0
        let isShowing = sidebarLeadingConstraint.constant == 0
        let scaleFactor = pdfView.scaleFactor
        UIView.animate(withDuration: animationDuration) {
            self.sidebarLeadingConstraint.constant = isShowing ? -thumbnailViewWidth : 0
            self.pdfView.scaleFactor = isShowing ? scaleFactor * multiplier : scaleFactor / multiplier
            self.view.layoutIfNeeded()
        }
    }

    func scalePDFViewToFit() {
        UIView.animate(withDuration: animationDuration) {
            self.pdfView.scaleFactor = self.pdfView.scaleFactorForSizeToFit
            self.view.layoutIfNeeded()
        }
    }

    @objc func resetNavigationButtons() {
        previousButton.isEnabled = pdfView.canGoToPreviousPage()
        nextButton.isEnabled = pdfView.canGoToNextPage()
    }

}

