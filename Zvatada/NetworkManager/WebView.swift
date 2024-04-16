//
//  WebView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 14/04/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
