//
//  MoreDetailsViewRepresentable.swift
//  PodcastApp
//
//  Created by Abrar on 16/10/2025.
//

import SwiftUI
import UIKit

struct MoreDetailsViewRepresentable: UIViewControllerRepresentable {
    
    private var content: ViewableContent
    
    private let storyboardName = "MoreDetailsViewController"
    private let viewControllerID = "MoreDetailsViewController"

    internal init(content: ViewableContent) {
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> MoreDetailsViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID)
                as? MoreDetailsViewController else {
            fatalError("Failed to load MoreDetailsViewController from Storyboard: \(storyboardName)")
        }
        
        vc.content = content
        return vc
    }

    func updateUIViewController(_ uiViewController: MoreDetailsViewController, context: Context) {
        uiViewController.content = content
    }
}
