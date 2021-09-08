//
//  EntityCDetailView.swift
//  EntityCDetailView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct EntityCDetailView: View
{
	@Binding var entityC: EntityC
	@State var nameFieldText = ""
	
	var body: some View
	{
		VStack
		{
			TextField( "\(entityC.name)", text: $nameFieldText )
			Text( "ID:\n \(entityC.objectID)." )
				.font( .title3 )
				.bold()
			Text( "userOrder: \(entityC.userOrder)" )
				.font( .title3 )
				.bold()
		}
		.padding()
		.onChange( of: nameFieldText, perform: { updatePersistentStore( $0 ) })
		
	}
	
	func updatePersistentStore( _ ignoredString: String )
	{
		entityC.name = nameFieldText
		PersistenceController.shared.save()
	}
}
