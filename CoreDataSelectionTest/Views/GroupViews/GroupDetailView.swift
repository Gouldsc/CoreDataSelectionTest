//
//  GroupDetailView.swift
//  GroupDetailView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct GroupDetailView: View
{
	@Environment( \.managedObjectContext ) private var viewContext
	
	//	MARK: - EntityA @FetchRequest
	@FetchRequest( sortDescriptors: [NSSortDescriptor( keyPath: \EntityA.name_,
													   ascending: true )],
				   animation: .default )
	private var entityAs: FetchedResults<EntityA>
		
	@State var group: Group
	
	var body: some View
	{
		VStack
		{
			Text( group.name )
				.font(.largeTitle)
				.bold()
			
			ForEach( entityAs )
			{
				tEntityA in
					HStack
					{
						Text( tEntityA.name )
							.foregroundColor( group.contains( entityA: tEntityA ) ? .green : .gray )
						Spacer()
						Button( action:
								{
									addOrRemove( entity: tEntityA )
								} )
								{
									Image( systemName: group.contains( entityA: tEntityA ) ? "minus.circle" : "plus.circle" )
								}
								.foregroundColor( group.contains( entityA: tEntityA ) ? .red : .green )
								.buttonStyle( .plain )
					}
			}
		}.padding( 50 )
	}
	
	private func addOrRemove( entity theEntity: EntityA )
	{
		switch group.contains( entityA: theEntity )
		{
			case true:
				theEntity.removeFromGroups( group )
				
			case false:
				theEntity.addToGroups( group )
		}
		
		PersistenceController.shared.save()
	}
}
