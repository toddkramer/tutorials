//
//  PhotoCollectionViewCell.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class PhotoCollectionViewCellNode: ASCellNode {

    var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var imageNode = ASNetworkImageNode()
    var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    var captionContainerNode = ASDisplayNode()
    var captionLabelNode = AttributedTextNode()

    let glacierScenic: GlacierScenic
    var nodeSize: CGSize {
        let spacing: CGFloat = 1
        let screenWidth = UIScreen.mainScreen().bounds.width
        let itemWidth = floor((screenWidth / 2) - (spacing / 2))
        let itemHeight = floor((screenWidth / 3) - (spacing / 2))
        return CGSize(width: itemWidth, height: itemHeight)
    }

    init(glacierScenic: GlacierScenic) {
        self.glacierScenic = glacierScenic
        super.init()
        configure()
    }

    func configure() {
        backgroundColor = UIColor.blackColor()
        configureLoadingIndicator()
        configureImageNode()
        configureCaptionNodes()
    }

    func configureLoadingIndicator() {
        loadingIndicator.center = loadingIndicatorCenter()
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }

    func loadingIndicatorCenter() -> CGPoint {
        let size: CGSize = loadingIndicator.frame.size
        let centerX = nodeSize.width / 2 - size.width / 2
        let centerY = nodeSize.height / 2 - size.height / 2
        return CGPoint(x: centerX, y: centerY)
    }

    func configureImageNode() {
        imageNode.frame = viewFrame()
        imageNode.delegate = self
        imageNode.URL = NSURL(string: glacierScenic.photoURLString)
        addSubnode(imageNode)
    }

    func configureCaptionNodes() {
        configureCaptionBlurView()
        configureCaptionContainerNode()
        configureCaptionLabelNode()
    }

    func configureCaptionBlurView() {
        blurView.frame = captionContainerFrame()
        view.addSubview(blurView)
    }

    func configureCaptionContainerNode() {
        captionContainerNode.frame = captionContainerFrame()
        captionContainerNode.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        addSubnode(captionContainerNode)
    }

    func configureCaptionLabelNode() {
        captionLabelNode.configure(glacierScenic.name, size: 16, textAlignment: .Center)
        let constrainedSize = CGSize(width: nodeSize.width, height: CGFloat.max)
        let labelNodeHeight: CGFloat = captionLabelNode.attributedString!.boundingRectWithSize(constrainedSize, options: .UsesFontLeading, context: nil).height
        let labelNodeYValue = captionContainerFrame().height / 2 - labelNodeHeight / 2
        captionLabelNode.frame = CGRect(x: 0, y: labelNodeYValue, width: nodeSize.width, height: labelNodeHeight)
        captionContainerNode.addSubnode(captionLabelNode)
    }

    func captionContainerFrame() -> CGRect {
        let containerHeight: CGFloat = 35
        return CGRect(x: 0, y: nodeSize.height - containerHeight, width: nodeSize.width, height: containerHeight)
    }

    func viewFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: nodeSize.width, height: nodeSize.height)
    }

    override func calculateLayoutThatFits(constrainedSize: ASSizeRange) -> ASLayout {
        return ASLayout(layoutableObject: self, size: nodeSize)
    }

}

extension PhotoCollectionViewCellNode: ASNetworkImageNodeDelegate {

    func imageNode(imageNode: ASNetworkImageNode, didLoadImage image: UIImage) {
        loadingIndicator.stopAnimating()
    }

}