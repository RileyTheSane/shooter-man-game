extends Node2D

func normalMarkerPos():
	$Marker2D.position = Vector2(53, -3)
	$DirectionMarker.position = Vector2(103, -3)

func flippedMarkerPos():
	$Marker2D.position = Vector2(53, 3)
	$DirectionMarker.position = Vector2(103, 3)
