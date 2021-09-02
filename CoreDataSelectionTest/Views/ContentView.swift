//
//  ContentView.swift
//  CoreDataSelectionTest
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI
import CoreData

struct ContentView: View
{
    @Environment(\.managedObjectContext) private var viewContext
	
	//	FIXME: This is a workaround. @SceneStorage conflicts with @FetchRequest, using @AppStorage temporarily
	@AppStorage( "ContentView.selectedListItemId" ) private var selectedListItemId: Selection.ID?
//	@SceneStorage( "ContentView.selectedListItemId" ) private var selectedListItemId: Selection.ID?
	
    var body: some View
	{
		NavigationView
		{
			SourceListView( selection: $selectedListItemId )
				.environment( \.managedObjectContext, viewContext )
			Text( "Detail, no selection" )
		}
    }
}

