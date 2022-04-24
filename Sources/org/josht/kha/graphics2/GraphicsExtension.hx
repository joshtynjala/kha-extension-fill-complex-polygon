/*
	kha-extension-fill-complex-polygon
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package org.josht.kha.graphics2;

import earcut.Earcut;
import kha.math.Vector2;
import kha.graphics2.Graphics;

class GraphicsExtension {
	private static var data:Array<Float> = [];
	private static var triangles:Array<Int> = [];

	public static function fillComplexPolygon(g2:Graphics, x:Float, y:Float, vertices:Array<Vector2>):Void {
		data.resize(0);
		for (vertex in vertices) {
			data.push(vertex.x);
			data.push(vertex.y);
		}

		triangles.resize(0);
		Earcut.earcut(data, null, 2, triangles);
		data.resize(0);

		var i = 0;
		while (i < triangles.length) {
			var v0 = vertices[triangles[i]];
			var v1 = vertices[triangles[i + 1]];
			var v2 = vertices[triangles[i + 2]];
			g2.fillTriangle(v0.x + x, v0.y + y, v1.x + x, v1.y + y, v2.x + x, v2.y + y);
			i += 3;
		}
		triangles.resize(0);
	}
}
