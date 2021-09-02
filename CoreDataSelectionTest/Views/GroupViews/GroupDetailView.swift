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
	@State private var isToggled = false
	
	var body: some View
	{
		VStack
		{
			Text( group.name )
				.font(.largeTitle)
				.bold()
			List
			{
				ForEach( entityAs )
				{
					tEntityA in
						HStack
					{
						Text( tEntityA.name )
						Toggle( "title", isOn: $isToggled )
							.onChange( of: self.isToggled, perform:
							{
								updateIsActivatedStatus( to: $0 )
							} )
							.labelsHidden()
					}
				}
			}
		}
	}
	
	private func updateIsActivatedStatus( to: Bool )
	{
		switch isToggled
		{
			case true:
				print( "ON" )
				
			case false:
				print( "OFF" )
		}
		PersistenceController.shared.save()
	}
}
