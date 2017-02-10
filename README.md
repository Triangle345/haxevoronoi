# haxevoronoi
Voronoi/Delaunay triangulation Library for haxe


    pnts.push(new Point(130,140));
    pnts.push(new Point(175,300));
    pnts.push(new Point(205,110));
    pnts.push(new Point(220,200));
    pnts.push(new Point(250,185));
    pnts.push(new Point(300,230));
    pnts.push(new Point(400,230));
    pnts.push(new Point(400,120));
    pnts.push(new Point(10,5));
    pnts.push(new Point(50,111));
    pnts.push(new Point(400,320));

		// the d. triangulation returns a list of triangles.
    var dtri = vor.GenerateTriangulation(pnts);
	
    // the voronoi generation returns voronoi cells.
    // voronoi cells contain a border (list of lines) , a site point and a list of triangles.
    var cells = vor.GenerateVoronoi(pnts);
    
    ![alt tag](https://cloud.githubusercontent.com/assets/4261822/22809537/426ac960-ef01-11e6-9298-e723e5d5fb34.PNG)
    
    
