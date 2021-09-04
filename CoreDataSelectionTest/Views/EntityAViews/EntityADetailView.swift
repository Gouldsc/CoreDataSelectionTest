//
//  EntityADetailView.swift
//  EntityADetailView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct EntityADetailView: View
{
	@Binding var entityA: EntityA
	@State var nameFieldText = ""
	
    var body: some View
	{
		VStack
		{
			TextField( "\(entityA.name)", text: $nameFieldText )
			Text( "ID:\n \(entityA.objectID)." )
				.font( .title3 )
				.bold()
		}
		.padding()
		.onChange( of: nameFieldText, perform: { updatePersistentStore( $0 ) })

    }
	
	func updatePersistentStore( _ ignoredString: String )
	{
		entityA.name = nameFieldText
		PersistenceController.shared.save()
	}
}
