//
//  Model.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

struct UserResponse {
    let token: String
    let user: User
}

struct User {
    let id: String
    let email: String
    let hasActiveWedding: Bool
    let tablesAtWedding: [Table]
    let otherWeddings: [WeddingGuest]
    let guests: [Guest]
}

let userMocked = User(id: "1",
                      email: "alexia.elena.aldea@gmail.com",
                      hasActiveWedding: true,
                      tablesAtWedding: [
                        Table(position: CGPoint(x: 0.2, y: 0.3), label: "Table 1", participants: [
                                Guest(id: "1", name: "Daniel", email: "da@gmail.com"),
                                Guest(id: "2", name: "Maria", email: "maria@d.com")
                                ]),
                        Table(position: CGPoint(x: 0.5, y: 0.5), label: "Table 2", participants: [
                            Guest(id: "3", name: "Daniel", email: "da@gmail.com"),
                            Guest(id: "4", name: "Maria", email: "maria@d.com"),
                            Guest(id: "5", name: "Dana", email: "dcsfd@.com")
                            ]),
                        Table(position: CGPoint(x: 0.8, y: 0.7), label: "Table 3", participants: [])
                    ],
                      otherWeddings: [WeddingGuest(id: "1", tableNb: "5", date: "12 mai 2025",
                                                   location: "Calea Grivitei 8-10")],
                      guests: [
                        Guest(id: "1", name: "Daniel", email: "da@gmail.com"),
                        Guest(id: "2", name: "Maria", email: "maria@d.com"),
                        Guest(id: "3", name: "Daniel", email: "da@gmail.com"),
                        Guest(id: "4", name: "Maria", email: "maria@d.com"),
                        Guest(id: "5", name: "Dana", email: "dcsfd@.com")
                      ])

let weddingsMocked: [Wedding] = [
    Wedding(id: "1", name: "Olaf si Elsa", date: "13.06.2025", location: "Promenada Mall", images: [
        "https://recorder.ro/wp-content/uploads/2024/12/Asset-1@3x-100-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/Experiment-recorder-tiktok-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/Thumb-fara-scris-680x445.png",
        "https://recorder.ro/wp-content/uploads/2024/11/thumb22-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/GEORGE-BECALI-680x445.jpeg",
        "https://recorder.ro/wp-content/uploads/2024/12/CIOLACU-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/MARIO-IORGULESCU-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/NICUSOR-DAN-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/HORATIU-POTRA-1-680x445.jpeg",
        "https://recorder.ro/wp-content/uploads/2024/12/SCHENGEN-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/COALITIE-680x445.jpeg",
        "https://recorder.ro/wp-content/uploads/2024/12/GABRIEL-VLASE-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/HORATIU-POTRA-680x445.jpeg",
        "https://recorder.ro/wp-content/uploads/2024/12/ALEGERI-ANULATE-680x445.png",
        "https://recorder.ro/wp-content/uploads/2024/12/GEORGESCU-LEGIONARI-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/PUTIN-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/12/simion-680x445.jpeg",
        "https://recorder.ro/wp-content/uploads/2024/11/STAMPILA-VOT-680x445.jpeg",
        "https://recorder.ro/wp-content/themes/recorder/src/images/recorder_newsletter_thumb.jpg",
        "https://recorder.ro/wp-content/uploads/2024/11/Palatul-Parlamentului-Recorder-680x445.png",
        "https://recorder.ro/wp-content/uploads/2024/11/MAin-Votantii-lui-CG-680x445.png",
        "https://recorder.ro/wp-content/uploads/2024/11/ID214216_INQUAM_Photos_Ovidiu-Dumitru_Matiu-680x445.jpg",
        "https://recorder.ro/wp-content/uploads/2024/11/USR-DREPT-Geoana-680x445.png"
    ]),
    Wedding(id: "2", name: "Ana si Sven", date: "07.11.2025", location: "Gara de Nord", images: [])
]
