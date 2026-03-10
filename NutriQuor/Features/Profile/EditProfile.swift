//
//  EditProfile.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct EditProfile: View {
    
    @State private var fullName: String = ""
    @State private var dob: Date = Date()
    
    @State private var gender: String = "Male"
    @State private var relationship: String = "Self"
    
    let genders = ["Male", "Female", "Other"]
    let relationships = ["Self", "Father", "Mother", "Child", "Spouse"]
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                // FULL NAME
                Section(header: Text("Full Name")) {
                    
                    TextField("Enter your full name", text: $fullName)
                }
                
                // DATE OF BIRTH
                Section() {
                    
                    DatePicker(
                        "Date of Birth",
                        selection: $dob,
                        displayedComponents: .date
                    )
                }
                
                // GENDER
                Section() {
                    
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self) { g in
                            Text(g)
                        }
                    }
                    .pickerStyle(.menu) // dropdown
                }
                
                // RELATIONSHIP
                Section() {
                    
                    Picker("Relationship", selection: $relationship) {
                        ForEach(relationships, id: \.self) { r in
                            Text(r)
                        }
                    }
                    .pickerStyle(.menu)
                }

                
                PrimaryGoalsCard()
                
                MedicalConditionsCard()
                
                AllergiesCard()
                
                
                // SAVE BUTTON
                Section {
                    
                    Button {
                        
                        print(fullName)
                        print(dob)
                        print(gender)
                        print(relationship)
                        
                    } label: {
                        
                        Text("Save Profile")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                    }
                }

            }
            .navigationTitle("Edit Profile")
        }.background()
    }
}

#Preview {
    EditProfile()
}
