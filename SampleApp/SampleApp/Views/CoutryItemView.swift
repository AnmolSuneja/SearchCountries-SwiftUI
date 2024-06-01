//
//  CountryItemView.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import SwiftUI

struct CountryItemView: View {
    let country: Country
    let flagDimension: CGFloat = 50
        
    init(country: Country) {
        self.country = country
    }
    
    var body: some View {
        HStack {
            flagImageView
            
            Text(country.name ?? Constants.missingFieldPlaceholder)
                .font(.title3)
                .bold()
                .lineLimit(2)
            
            Spacer(minLength: 10)
            
            detailView
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.pink.opacity(0.3))
        )
    }
    
    var flagImageView: some View {
        AsyncImage(url: URL(string: country.flagUrl)) { phase in
            switch phase {
            case .empty:
                //noFlagView
                ProgressView()
                    .frame(width: flagDimension, height: flagDimension)
            case .success(let returnedImage):
                returnedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: flagDimension, height: flagDimension)
            case .failure:
                noFlagView
            @unknown default:
                noFlagView
            }
        }
    }
    
    var noFlagView: some View {
        Image(systemName: "questionmark")
            .font(.headline)
            .frame(width: flagDimension, height: flagDimension)
    }
    
    var detailView: some View {
        VStack(alignment: .trailing) {
            Text("\(Constants.capitalPlaceholder) \(country.capital ?? Constants.missingFieldPlaceholder)")
            Text("\(Constants.currencyPlaceholder) \(country.currency ?? Constants.missingFieldPlaceholder)")
            Text("\(Constants.populationPlaceholder) \(country.populationText)")
        }
        .lineLimit(1)
        .font(.footnote)
        .minimumScaleFactor(0.8)
        .foregroundStyle(Color.blue)
    }
}
