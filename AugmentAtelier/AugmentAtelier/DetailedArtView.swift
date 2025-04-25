//
//  DetailedArtView.swift
//  AugmentAtelier
//
//  Created by Steinhauer, Jan on 24.04.25.
//

import SwiftUI

struct DetailedArtView: View {
    @EnvironmentObject var viewModel: AtelierViewModel

    var description: String {
        switch viewModel.currentModelName {
        case "Jaguar Whistle":
            return "An ancient Mesoamerican whistle shaped like a jaguar. Used in rituals and known for its eerie sound."
        case "Frog Game":
            return "A traditional game involving frog figurines. Possibly a representation of early interactive art."
        case "Road Pillar":
            return "A sculptural representation of infrastructural design — where art meets utility."
        default:
            return "No description available."
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.currentModelName)
                .font(.largeTitle)
                .bold()

            Text(description)
                .multilineTextAlignment(.leading)
                               .padding()
                               .frame(width: 500)

            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

#Preview {
    DetailedArtView()
        .environmentObject(AtelierViewModel())
}
