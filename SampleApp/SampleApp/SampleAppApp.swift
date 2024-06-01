//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import SwiftUI

@main
struct SampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CountriesListView()
            }
        }
    }
}
