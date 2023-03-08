//
//  CloseButtonView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/8/23.
//

import SwiftUI

struct CloseButtonView: View {
    
    // MARK: Properties
    
    @Binding var shouldDisplay: Bool
    
    // MARK: Views
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    shouldDisplay.toggle()
                } label: {
                    Image(systemName: ImageConstants.xmark)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1)
                        .font(.title)
                        .padding()
                }
                .frame(width: 50, height: 50)
            }
            .padding(.top, 20)
            Spacer()
        }
    }
}

struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView(shouldDisplay: .constant(true))
    }
}
