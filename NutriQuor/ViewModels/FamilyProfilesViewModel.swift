//
//  FamilyProfilesViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 1/6/26.
//

import Foundation
import Combine

@MainActor
final class FamilyProfilesViewModel: ObservableObject {
    @Published private(set) var members: [Profile] = []

    init(members: [Profile] = []) {
        self.members = members
    }

    func setMembers(_ members: [Profile]) {
        self.members = members
    }
}
